#include "dwfophysicsbody.h"

dwFOPhysicsBody::dwFOPhysicsBody(QObject *parent) : QObject(parent)
{
    ensureParent();

    m_world = dwFieldPhysicsWorld::singleton()->world();
    m_body = 0;

    m_enabled = true;
    m_autorebuild = 0;

    m_bodyType = BT_STATIC;
    m_shapeType = ST_CIRCLE;
    m_shapeData = QVector4D(0,0,0,0);
    m_shapeCategory = dwFieldPhysicsWorld::CC_DYNAMIC;
    m_shapeCollisionMask = dwFieldPhysicsWorld::CC_LAYER_A | dwFieldPhysicsWorld::CC_LAYER_B | dwFieldPhysicsWorld::CC_DYNAMIC;
}

dwFOPhysicsBody::~dwFOPhysicsBody()
{
    if(m_body) m_world->DestroyBody(m_body);
}


bool dwFOPhysicsBody::ensureParent()
{
    return (m_object = reinterpret_cast<dwFieldObject*>(parent())) != 0;
}

void dwFOPhysicsBody::rebuildBody()
{
    if(m_body)
    {
        m_world->DestroyBody(m_body);
        m_body = 0;
    }

    if(!ensureParent())
    {
        return;
    }

    b2Shape *shape = 0;
    b2CircleShape *c = 0;
    b2PolygonShape *b = 0;

    qreal scale = dwFieldPhysicsWorld::singleton()->physicsScale();

    switch (m_shapeType) {
    case ST_CIRCLE:
        c = new b2CircleShape();
        c->m_p.SetZero();
        c->m_radius = scale * m_shapeData[0];
        shape = c;
        break;
    case ST_POLY_BOX:
        b = new b2PolygonShape();
        b->SetAsBox(scale * m_shapeData.x(), scale * m_shapeData.y());
        shape = b;
        break;
    default:
        break;
    }

    if(!shape)
        return;

    b2FixtureDef fixture;
    fixture.shape = shape;
    fixture.density = 1;
    fixture.filter.categoryBits = static_cast<uint16>(m_shapeCategory);
    fixture.filter.maskBits = static_cast<uint16>(m_shapeCollisionMask);

    b2BodyDef def;
    def.type = b2_staticBody;
    def.position.Set( scale * ( m_object->x() + m_origin.x()) , scale * ( m_object->y() + m_origin.y() ) );
    def.angle = 0;

    m_body = m_world->CreateBody(&def);
    m_body->CreateFixture(&fixture);

    delete shape;

    switch (m_bodyType) {
    case BT_STATIC:
        connect(m_object, &dwFieldObject::xChanged, this, &dwFOPhysicsBody::updateBodyTransform);
        connect(m_object, &dwFieldObject::yChanged, this, &dwFOPhysicsBody::updateBodyTransform);
        connect(m_object, &dwFieldObject::rotationChanged, this, &dwFOPhysicsBody::updateBodyTransform);
        break;
    default:
        break;
    }
}

void dwFOPhysicsBody::updateBodyTransform()
{
    qreal scale = dwFieldPhysicsWorld::singleton()->physicsScale();
    m_body->SetTransform(b2Vec2(scale * (m_object->x() + m_origin.x()), scale * (m_object->y() + m_origin.y())), 0);
}

