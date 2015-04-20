#include "dwfophysicsbody.h"

dwFOPhysicsBody::dwFOPhysicsBody(QObject *parent) : QObject(parent)
{
    m_object = 0;
    ensureParent();

    m_world = dwFieldPhysicsWorld::singleton()->world();
    m_body = 0;
    m_scale = dwFieldPhysicsWorld::singleton()->physicsScale();
    m_invScale = 1/m_scale;

    m_enabled = true;
    m_collisionCallbackEnabled = false;
    m_autorebuild = 0;

    m_bodyType = BT_STATIC;
    m_shapeType = ST_CIRCLE;
    m_shapeData = QVector4D(0,0,0,0);
    m_sensor = false;
    m_shapeCategory = dwFieldPhysicsWorld::CC_DYNAMIC;
    m_shapeCollisionMask = dwFieldPhysicsWorld::CC_LAYER_A | dwFieldPhysicsWorld::CC_LAYER_B | dwFieldPhysicsWorld::CC_DYNAMIC;
}

dwFOPhysicsBody::~dwFOPhysicsBody()
{
    if(m_body) m_world->DestroyBody(m_body);
}


bool dwFOPhysicsBody::ensureParent()
{
    if(m_object) return true;
    return (m_object = reinterpret_cast<QQuickItem*>(parent())) != 0;
}

void dwFOPhysicsBody::rebuildBody()
{
    if(m_body)
    {
        switch (m_bodyType) {
        case BT_STATIC:
        case BT_KINEMATIC:
        case BT_DYNAMIC_SENSOR:
            disconnect(m_object, &dwFieldObject::xChanged, this, &dwFOPhysicsBody::updateBodyTransform);
            disconnect(m_object, &dwFieldObject::yChanged, this, &dwFOPhysicsBody::updateBodyTransform);
            disconnect(m_object, &dwFieldObject::rotationChanged, this, &dwFOPhysicsBody::updateBodyTransform);
            break;
        case BT_DYNAMIC:
            disconnect( dwFieldPhysicsWorld::singleton(), &dwFieldPhysicsWorld::afterUpdating, this, &dwFOPhysicsBody::updateObjectTransform);
        default:
            break;
        }

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
    fixture.isSensor = m_sensor;
    fixture.filter.categoryBits = static_cast<uint16>(m_shapeCategory);
    fixture.filter.maskBits = static_cast<uint16>(m_shapeCollisionMask);

    b2BodyDef def;
    switch (m_bodyType) {
    case BT_STATIC:
        def.type = b2_staticBody;
        break;

    case BT_KINEMATIC:
        def.type = b2_kinematicBody;
        break;

    case BT_DYNAMIC_SENSOR:
        def.gravityScale = 0;
        def.allowSleep = false;

    case BT_DYNAMIC:
        def.type = b2_dynamicBody;
        break;

    default:
        def.type = b2_staticBody;
        break;
    }

    def.active = m_enabled;
    def.position.Set( scale * ( m_object->x() + m_origin.x()) , scale * ( m_object->y() + m_origin.y() ) );
    def.angle = 0;

    m_body = m_world->CreateBody(&def);
    m_body->CreateFixture(&fixture)->SetUserData(this);
    m_body->SetUserData(this);

    delete shape;

    switch (m_bodyType) {
    case BT_STATIC:
    case BT_KINEMATIC:
    case BT_DYNAMIC_SENSOR:
        connect(m_object, &dwFieldObject::xChanged, this, &dwFOPhysicsBody::updateBodyTransform);
        connect(m_object, &dwFieldObject::yChanged, this, &dwFOPhysicsBody::updateBodyTransform);
        connect(m_object, &dwFieldObject::rotationChanged, this, &dwFOPhysicsBody::updateBodyTransform);
        break;
    case BT_DYNAMIC:
        connect( dwFieldPhysicsWorld::singleton(), &dwFieldPhysicsWorld::afterUpdating, this, &dwFOPhysicsBody::updateObjectTransform);
        break;
    default:
        break;
    }

}

void dwFOPhysicsBody::updateBodyTransform()
{
    //qDebug(QString("-> %1 %2").arg(m_invScale * (m_body->GetPosition().x)).arg(m_invScale * (m_body->GetPosition().y)).toLocal8Bit());
    m_body->SetTransform(((float32)m_scale) * b2Vec2((float32)(m_object->x() + m_origin.x()), (float32)(m_object->y() + m_origin.y())), 0.0f);
    //qDebug(QString("%1 %2 %3 %4").arg(m_scale * (m_object->x() + m_origin.x())).arg(m_scale * (m_object->y() + m_origin.y())).arg(m_invScale * (m_body->GetPosition().x)).arg(m_invScale * (m_body->GetPosition().y)).toLocal8Bit());
}

#include "qmath.h"

void dwFOPhysicsBody::updateObjectTransform()
{
    if(m_object ||  ensureParent())
    {
        const b2Transform &t = m_body->GetTransform();
        m_object->setX( m_invScale * t.p.x - m_origin.x() );
        m_object->setY( m_invScale * t.p.y - m_origin.y() );
        m_object->setRotation( qRadiansToDegrees(t.q.GetAngle()) );
    }
}

