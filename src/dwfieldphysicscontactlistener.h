#ifndef DWFIELDPHYSICSCONTACTLISTENER_H
#define DWFIELDPHYSICSCONTACTLISTENER_H

#include <box2d/box2d.h>
#include <QObject>
#include <QVector>

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


    void fopbDestroyed(dwFOPhysicsBody* body) { m_destroyedStuff.push_back(body); }

    struct ContactCallback {
        bool isCollisionEnd;
        dwFOPhysicsBody * bodyA;
        dwFOPhysicsBody * bodyB;
        int catBodyB;

        ContactCallback(){} // we have a default constructor that does nothing
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
    QVector<ContactCallback> m_callbackBuffer;
    QVector<dwFOPhysicsBody*> m_destroyedStuff;
};

#endif // DWFIELDPHYSICSCONTACTLISTENER_H
