#ifndef DWFIELDPHYSICSCONTACTLISTENER_H
#define DWFIELDPHYSICSCONTACTLISTENER_H

#include "Box2D/Box2D.h"
#include <QObject>
#include <QList>

class dwFOPhysicsBody;

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


    struct ContactCallback {
        bool isCollisionEnd;
        dwFOPhysicsBody * bodyA;
        dwFOPhysicsBody * bodyB;
        int catBodyB;

        ContactCallback(bool end, dwFOPhysicsBody *a, dwFOPhysicsBody *b, int cB) :
        isCollisionEnd(end),
        bodyA(a),
        bodyB(b),
        catBodyB(cB){}
    };

    void processCallbacks();

signals:

public slots:

private:
    QList<ContactCallback> m_callbackBuffer;
};

#endif // DWFIELDPHYSICSCONTACTLISTENER_H
