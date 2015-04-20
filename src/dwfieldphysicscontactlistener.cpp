#include "dwfieldphysicscontactlistener.h"
#include "dwfophysicsbody.h"

dwFieldPhysicsContactListener::dwFieldPhysicsContactListener(QObject *parent) : QObject(parent)
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
        dwFOPhysicsBody * bodyA = reinterpret_cast<dwFOPhysicsBody*>(a);
        dwFOPhysicsBody * bodyB = reinterpret_cast<dwFOPhysicsBody*>(b);

        if(a)
        {
            if(bodyA->collisionCallbackEnabled())
                bodyA->collision(contact->GetFixtureB()->GetFilterData().categoryBits, bodyB);
        }

        if(b)
        {
            if(bodyB->collisionCallbackEnabled())
                bodyB->collision(contact->GetFixtureA()->GetFilterData().categoryBits, bodyA);
        }
    }
}

void dwFieldPhysicsContactListener::EndContact(b2Contact *contact)
{

}

