#include "dwfieldphysicscontactlistener.h"

dwFieldPhysicsContactListener::dwFieldPhysicsContactListener(QObject *parent) : QObject(parent)
{

}

dwFieldPhysicsContactListener::~dwFieldPhysicsContactListener()
{

}

void dwFieldPhysicsContactListener::BeginContact(b2Contact *contact)
{
    qDebug("begin");
    bool hasInfo = contact->GetFixtureA()->GetUserData() != 0 || contact->GetFixtureB()->GetUserData() != 0;
    if(!hasInfo) return;
}

void dwFieldPhysicsContactListener::EndContact(b2Contact *contact)
{
    qDebug("end");
    bool hasInfo = contact->GetFixtureA()->GetUserData() != 0 || contact->GetFixtureB()->GetUserData() != 0;
    if(!hasInfo) return;
}

