#include "dwfophysicsbody.h"

dwFOPhysicsBody::dwFOPhysicsBody(QObject *parent) : QObject(parent)
{
    m_object = reinterpret_cast<dwFieldObject*>(parent);

    m_world = dwFieldPhysicsWorld::singleton()->world();
    m_body = 0;

    m_shapeType = ST_CIRCLE;
    m_origin = QPointF(0, 0);
    m_shapeCategory = dwFieldPhysicsWorld::CC_DYNAMIC;
    m_shapeCollisionMask = dwFieldPhysicsWorld::CC_LAYER_A | dwFieldPhysicsWorld::CC_LAYER_B | dwFieldPhysicsWorld::CC_DYNAMIC;
}

dwFOPhysicsBody::~dwFOPhysicsBody()
{
    if(m_body) m_world->DestroyBody(m_body);
}

void dwFOPhysicsBody::rebuildBody()
{
    if(m_body) m_world->DestroyBody(m_body);
    m_body = 0;

    if(!m_enabled || m_shapeData.isEmpty())
        return;    // don't do shit

    // first, our shape
    b2Shape *shape = 0;
    b2CircleShape *c = 0;
    b2PolygonShape *b = 0;

    switch (m_shapeType) {
    case ST_CIRCLE:
        if(m_shapeData.length() < 1)
            return;
        c = new b2CircleShape();
        c->m_p.SetZero();
        c->m_radius = m_shapeData[0];
        shape = c;
        break;
    case ST_POLY_BOX:
        if(m_shapeData.length() < 2)
            return;
        b = new b2PolygonShape();
        b->SetAsBox(m_shapeData[0],m_shapeData[1],b2Vec2_zero,0);
        shape = b;
        break;
    default:
        break;
    }

    if(!shape)
        return;

    b2FixtureDef fixture;
    fixture.shape = shape;
    fixture.filter.categoryBits = static_cast<uint16>(m_shapeCategory);
    fixture.filter.maskBits = static_cast<uint16>(m_shapeCollisionMask);
    delete shape;
}

