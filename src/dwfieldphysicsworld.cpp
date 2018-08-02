#include "dwfieldphysicsworld.h"
#include <qmath.h>
#include "dwroot.h"
#include "dwfieldphysicscontactlistener.h"

dwFieldPhysicsWorld * dwFieldPhysicsWorld::m_instance = 0;

dwFieldPhysicsWorld::dwFieldPhysicsWorld(QObject *parent) :
    QObject(parent),
    b2Draw(),
    refCounter(0),
    m_physicsScale(1)
{
    m_instance = this;

    m_drawFlags = (e_shapeBit | e_jointBit | e_pairBit);
    m_world = new b2World(b2Vec2(0, 9.81));
    m_world->SetDebugDraw(this);
    m_world->SetContactListener( m_contactListener = new dwFieldPhysicsContactListener(this) );

    m_doingDebugDraw = false;

    // updated manually by field
    //connect(dwRoot::singleton(), &dwRoot::update, this, &dwFieldPhysicsWorld::update);
}

void dwFieldPhysicsWorld::update(float dt)
{
    emit beforeUpdating(dt);

    m_world->Step(dt, 8, 3
    #ifdef B2_PARTICLE
    ,3
#endif
    );
    m_contactListener->processCallbacks();

//    for ( b2Body* b = _world->GetBodyList(); b; b = b->GetNext())
//    {
//        if(b->GetUserData())
//        {
//            QQuickItem * item = static_cast<QQuickItem *>(b->GetUserData());
//            item->setX((b->GetPosition().x/m_physicsScale - item->width()/2));
//            item->setY( (b->GetPosition().y/m_physicsScale - item->height()/2 ));
//            item->setRotation(b->GetAngle() * 180 / M_PI );
//        }
//    }

    emit afterUpdating(dt);
}

void dwFieldPhysicsWorld::fopbDestroyed(dwFOPhysicsBody *body)
{
    m_contactListener->fopbDestroyed(body);
}




int dwFieldPhysicsWorld::addLevelGeomRect(float centerX, float centerY, float halfWidth, float halfHeight, float rotationDeg, int category)
{
    if(halfWidth == 0 || halfHeight == 0) return -1;

    b2BodyDef def;
    def.type = b2_staticBody;
    def.position = b2Vec2(centerX*m_physicsScale, centerY*m_physicsScale);
    def.angle = rotationDeg * M_PI / 180.0;

    b2Body * body = m_world->CreateBody(&def);

    b2PolygonShape shape;
    shape.SetAsBox(halfWidth*m_physicsScale, halfHeight*m_physicsScale, b2Vec2(0,0), 0 );

    b2FixtureDef boxFixtureDef;
    boxFixtureDef.shape = &shape;
    boxFixtureDef.density = 1;
    boxFixtureDef.filter.categoryBits = category;
    body->CreateFixture(&boxFixtureDef);

    return _refBodies.insert(++refCounter, body).key();
}

int dwFieldPhysicsWorld::addLevelGeomEdge(float x1, float y1, float x2, float y2, int category)
{
    b2BodyDef def;
    def.type = b2_staticBody;
    def.position = b2Vec2(x1*m_physicsScale, y1*m_physicsScale);

    b2Body * body = m_world->CreateBody(&def);

    b2EdgeShape shape;
    shape.Set(b2Vec2(0,0), b2Vec2((x2-x1)*m_physicsScale, (y2-y1)*m_physicsScale));

    b2FixtureDef edgeFixtureDef;
    edgeFixtureDef.shape = &shape;
    //edgeFixtureDef.density = 1;
    edgeFixtureDef.filter.categoryBits = category;
    body->CreateFixture(&edgeFixtureDef);

    return _refBodies.insert(++refCounter, body).key();
}

int dwFieldPhysicsWorld::addLevelGeomArc(float centerX, float centerY, float radius, float rotationDeg, int quadrant, int category)
{
    b2BodyDef def;
    def.type = b2_staticBody;
    def.position = b2Vec2(centerX*m_physicsScale, centerY*m_physicsScale);
    def.angle = rotationDeg*M_PI/180.0 - M_PI_2 * quadrant;


    b2Body * body = m_world->CreateBody(&def);

    int ARC_SEGMENTS = static_cast<int>(qMax(radius / 8.0 , 1.0));
    b2ChainShape shape;
    b2Vec2 *arcPoints = new b2Vec2[ARC_SEGMENTS + 1]();
    for(int i = 0; i <= ARC_SEGMENTS; i++)
    {
        float angle = i/static_cast<float>(ARC_SEGMENTS) * M_PI_2;
        arcPoints[i].x = qCos(-angle) * radius * m_physicsScale;
        arcPoints[i].y = qSin(-angle)* radius * m_physicsScale;
    }
    shape.CreateChain(arcPoints, ARC_SEGMENTS + 1);
    delete[] arcPoints;

    b2FixtureDef arcFixtureDef;
    arcFixtureDef.shape = &shape;
    arcFixtureDef.density = 1;
    arcFixtureDef.filter.categoryBits = category;
    body->CreateFixture(&arcFixtureDef);

    return _refBodies.insert(++refCounter, body).key();
}

int dwFieldPhysicsWorld::addLevelGeomCircle(float x1, float y1, float radius)
{
    Q_UNUSED(x1)
    Q_UNUSED(y1)
    Q_UNUSED(radius)
    return -1;
}

int dwFieldPhysicsWorld::addLevelGeomChain(float centerX, float centerY, QList<qreal> pointsX, QList<qreal> pointsY, int category, bool absolutePoints)
{
    b2BodyDef def;
    def.type = b2_staticBody;
    def.position = b2Vec2(centerX*m_physicsScale, centerY*m_physicsScale);
    //def.angle = rotationDeg*M_PI/180.0 - M_PI_2 * quadrant;


    b2Body * body = m_world->CreateBody(&def);

    int n = pointsX.length();

    b2ChainShape shape;
    b2Vec2 *bPoints = new b2Vec2[n]();
    for(int i = 0; i < n; i++)
    {
        bPoints[i].x = (pointsX[i] + (absolutePoints? centerX : 0))  * m_physicsScale;
        bPoints[i].y = (pointsY[i] + (absolutePoints? centerY : 0))  * m_physicsScale;
    }
    shape.CreateChain(bPoints, n);
    delete[] bPoints;

    b2FixtureDef chainFixtureDef;
    chainFixtureDef.shape = &shape;
    chainFixtureDef.density = 1;
    chainFixtureDef.filter.categoryBits = category;
    body->CreateFixture(&chainFixtureDef);

    return _refBodies.insert(++refCounter, body).key();
}

void dwFieldPhysicsWorld::setLevelGeomTransform(int prefabId, float x, float y, float angle)
{
    _refBodies[prefabId]->SetTransform(b2Vec2(x*m_physicsScale, y*m_physicsScale), angle);
}

void dwFieldPhysicsWorld::setLevelGeomActive(int id, bool active)
{
    _refBodies[id]->SetActive(active);
}

void dwFieldPhysicsWorld::removeLevelGeom(int id)
{
    if(_refBodies.contains(id))
    {
        m_world->DestroyBody(_refBodies[id]);
        _refBodies.remove(id);
    }
}

void dwFieldPhysicsWorld::removeAllLevelGeom()
{
    foreach (b2Body * body, _refBodies)
    {
        m_world->DestroyBody(body);
    }

    _refBodies.clear();

}

class MyFilteredRayCastCallback : public b2RayCastCallback
{
public:
    MyFilteredRayCastCallback( int categories )
    {
        m_fixture = 0;
        m_categories = categories;
        m_fraction = -1;
    }
    float32 ReportFixture(b2Fixture* fixture, const b2Vec2& point,
                          const b2Vec2& normal, float32 fraction)
    {
        if(!(fixture->GetFilterData().categoryBits & m_categories)) return -1;
        m_fixture = fixture;
        m_point = point;
        m_normal = normal;
        m_fraction = fraction;
        return fraction;
    }
    int m_categories;
    b2Fixture* m_fixture;
    b2Vec2 m_point;
    b2Vec2 m_normal;
    float32 m_fraction;
};
float dwFieldPhysicsWorld::raycastClosestDistance(float x1, float y1, float x2, float y2, int categories)
{
    return raycast(x1,y1,x2,y2,categories)[0];
}

QVector4D dwFieldPhysicsWorld::raycast(float x1, float y1, float x2, float y2, int categories)
{

    MyFilteredRayCastCallback callback(categories);
    m_world->RayCast(&callback, b2Vec2(x1*m_physicsScale, y1*m_physicsScale), b2Vec2(x2*m_physicsScale, y2*m_physicsScale) );

    if(m_doingDebugDraw && m_raysDrawBeginPoints.length() < 32)
    {
        m_raysDrawBeginPoints.append(QVector2D(x1, y1));
        m_raysDrawEndPoints.append(QVector2D(x2, y2));
        m_raysDrawFractions.append(callback.m_fraction);
    }
    return callback.m_fixture? QVector4D(callback.m_fraction, callback.m_normal.x, callback.m_normal.y, callback.m_fixture->GetFilterData().categoryBits) : QVector4D(-1, -1, -1, 0);
}

void dwFieldPhysicsWorld::makeMeABox(QQuickItem *item)
{
    b2BodyDef def;
    def.type = b2_dynamicBody;
    def.position = b2Vec2((item->x() + item->width()/2)*m_physicsScale, (item->y() + item->height()/2)*m_physicsScale);
    def.angle = item->rotation() * M_PI / 180.0;

    b2Body * body = m_world->CreateBody(&def);
    _refBodies.insert(++refCounter, body);

    b2PolygonShape shape;
    shape.SetAsBox((item->width()/2)*m_physicsScale, (item->height()/2)*m_physicsScale, b2Vec2(0,0), 0 );

    b2FixtureDef boxFixtureDef;
    boxFixtureDef.shape = &shape;
    boxFixtureDef.density = 1;
    boxFixtureDef.filter.categoryBits = CC_DYNAMIC;
    body->CreateFixture(&boxFixtureDef);

    body->SetUserData(item);
}

void dwFieldPhysicsWorld::debugDraw()
{
    m_doingDebugDraw = true;
    m_world->DrawDebugData();

    for(int i = 0; i < m_raysDrawBeginPoints.length(); i++)
    {
        emit debugDrawSegment(m_raysDrawBeginPoints[i].x(), m_raysDrawBeginPoints[i].y(), m_raysDrawEndPoints[i].x(), m_raysDrawEndPoints[i].y(), QColor(255, (m_raysDrawFractions[i]>0? 255 : 0), 255*qMax(0.0, m_raysDrawFractions[i])));
    }

    m_raysDrawBeginPoints.clear();
    m_raysDrawEndPoints.clear();
    m_raysDrawFractions.clear();
}

#define TO_QCOLOR(x) QColor(((x).r * 255), ((x).g * 255), ((x).b * 255))

void dwFieldPhysicsWorld::DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color)
{
    QList<qreal> pointsX, pointsY;
    for (int i = 0; i < vertexCount; ++i) {
        pointsX.push_back(vertices[i].x/m_physicsScale);
        pointsY.push_back(vertices[i].y/m_physicsScale);
    }

    emit debugDrawPolygon(pointsX, pointsY, TO_QCOLOR(color) );
}
void dwFieldPhysicsWorld::DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color)
{
    QList<qreal> pointsX, pointsY;
    for (int i = 0; i < vertexCount; ++i) {
        pointsX.push_back(vertices[i].x/m_physicsScale);
        pointsY.push_back(vertices[i].y/m_physicsScale);
    }

    emit debugDrawSolidPolygon(pointsX, pointsY, TO_QCOLOR(color) );
}
void dwFieldPhysicsWorld::DrawCircle(const b2Vec2& center, float32 radius, const b2Color& color)
{
    emit debugDrawCircle(center.x/m_physicsScale, center.y/m_physicsScale, radius/m_physicsScale, TO_QCOLOR(color));
}
void dwFieldPhysicsWorld::DrawSolidCircle(const b2Vec2& center, float32 radius, const b2Vec2& axis, const b2Color& color)
{
    emit debugDrawSolidCircle(center.x/m_physicsScale, center.y/m_physicsScale, radius/m_physicsScale, axis.x, axis.y, TO_QCOLOR(color));
}

#ifdef B2_PARTICLE
void dwFieldPhysicsWorld::DrawParticles(const b2Vec2 *centers, float32 radius, const b2ParticleColor *colors, int32 count)
{
    Q_UNUSED(centers)
    Q_UNUSED(radius)
    Q_UNUSED(colors)
    Q_UNUSED(count)
}
#endif

void dwFieldPhysicsWorld::DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color)
{
    emit debugDrawSegment(p1.x/m_physicsScale, p1.y/m_physicsScale, p2.x/m_physicsScale, p2.y/m_physicsScale, TO_QCOLOR(color));
}

void dwFieldPhysicsWorld::DrawTransform(const b2Transform& xf)
{
    Q_UNUSED(xf)
}
