#include "dwfieldphysicscontactlistener.h"
#include "dwfophysicsbody.h"

dwFieldPhysicsContactListener::dwFieldPhysicsContactListener(QObject *parent) : QObject(parent),
    m_callbackBuffer()
{

}

dwFieldPhysicsContactListener::~dwFieldPhysicsContactListener()
{

}

void dwFieldPhysicsContactListener::BeginContact(b2Contact *contact)
{
    if(!contact->IsTouching()) return;

    void * a = contact->GetFixtureA()->GetUserData();
    void * b = contact->GetFixtureB()->GetUserData();

    if(a || b)
    {
        dwFOPhysicsBody * bodyA = static_cast<dwFOPhysicsBody*>(a);
        dwFOPhysicsBody * bodyB = static_cast<dwFOPhysicsBody*>(b);

        if(a)
        {
            if(bodyA->collisionCallbackEnabled())
                m_callbackBuffer.push_back(ContactCallback(false, bodyA, bodyB, contact->GetFixtureB()->GetFilterData().categoryBits));
        }

        if(b)
        {
            if(bodyB->collisionCallbackEnabled())
                m_callbackBuffer.push_back(ContactCallback(false, bodyB, bodyA, contact->GetFixtureA()->GetFilterData().categoryBits));
        }
    }
}

// Obvious DRY violation. Meh...

void dwFieldPhysicsContactListener::EndContact(b2Contact *contact)
{
    if(!contact->IsTouching()) return;

    void * a = contact->GetFixtureA()->GetUserData();
    void * b = contact->GetFixtureB()->GetUserData();

    if(a || b)
    {
        dwFOPhysicsBody * bodyA = static_cast<dwFOPhysicsBody*>(a);
        dwFOPhysicsBody * bodyB = static_cast<dwFOPhysicsBody*>(b);

        if(a)
        {
            if(bodyA->collisionEndCallbackEnabled())
                m_callbackBuffer.push_back(ContactCallback(true, bodyA, bodyB, contact->GetFixtureB()->GetFilterData().categoryBits));
        }

        if(b)
        {
            if(bodyB->collisionEndCallbackEnabled())
                m_callbackBuffer.push_back(ContactCallback(true, bodyB, bodyA, contact->GetFixtureA()->GetFilterData().categoryBits));
        }
    }
}

void dwFieldPhysicsContactListener::processCallbacks()
{
    foreach (ContactCallback callback, m_callbackBuffer) {
        if(!callback.isCollisionEnd)
            callback.bodyA->collision( callback.catBodyB, callback.bodyB );
        else
            callback.bodyA->collisionEnd( callback.catBodyB, callback.bodyB );

    }

    m_callbackBuffer.clear();
}

