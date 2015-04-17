#ifndef DWFIELDPHYSICSCONTACTLISTENER_H
#define DWFIELDPHYSICSCONTACTLISTENER_H

#include "Box2D/Box2D.h"
#include <QObject>

class dwFieldPhysicsContactListener : public QObject, public b2ContactListener
{
    Q_OBJECT
public:
    explicit dwFieldPhysicsContactListener(QObject *parent = 0);
    ~dwFieldPhysicsContactListener();

    /// Called when two fixtures begin to touch.
    virtual void BeginContact(b2Contact* contact);

    /// Called when two fixtures cease to touch.
    virtual void EndContact(b2Contact* contact);


signals:

public slots:
};

#endif // DWFIELDPHYSICSCONTACTLISTENER_H
