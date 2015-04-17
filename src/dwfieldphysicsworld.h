#ifndef DWFIELDPHYSICSWORLD_H
#define DWFIELDPHYSICSWORLD_H

#include <QObject>
#include <Box2D/Box2D.h>
#include <QMap>
#include <QList>
#include <QQuickItem>
#include <QVector2D>
#include <QVector4D>

class dwFieldPhysicsWorld : public QObject, public b2Draw
{
    Q_OBJECT
    Q_PROPERTY(float physicsScale READ physicsScale WRITE setPhysicsScale NOTIFY physicsScaleChanged)
    Q_ENUMS(CollisionCategories)
public:

    enum CollisionCategories
    {
        CC_DYNAMIC = 0x01,
        CC__PLAYER = 0x02,
        CC_LAYER_A = 0x04,
        CC_LAYER_B = 0x08,
        CC_LAYERS = 0x0C,
        CC_LAYER_A_ONLYTOP = 0x10,
        CC_LAYER_B_ONLYTOP = 0x20,
        CC_LAYERS_ONLYTOP = 0x30,
        CC_OBJ_NOT_ROLLING = 0x40,
        CC__PLAYER_SENSOR = 0x80,
        CC_WATER_EDGE = 0x100
    };


    explicit dwFieldPhysicsWorld(QObject *parent = 0);

    float physicsScale() const
    {
        return m_physicsScale;
    }

    void DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color);
    void DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color);
    void DrawCircle(const b2Vec2& center, float32 radius, const b2Color& color);
    void DrawSolidCircle(const b2Vec2& center, float32 radius, const b2Vec2& axis, const b2Color& color);
    void DrawParticles(const b2Vec2 *centers, float32 radius, const b2ParticleColor *colors, int32 count);
    void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color);
    void DrawTransform(const b2Transform& xf);

    static dwFieldPhysicsWorld * singleton(){ return _instance; }
    b2World * world() {return _world;}

signals:
    void beforeUpdating(float dt);
    void afterUpdating(float dt);

    void physicsScaleChanged(float arg);

    void debugDrawPolygon( QList<qreal> pointsx, QList<qreal> pointsy, QColor color );
    void debugDrawSolidPolygon( QList<qreal> pointsx, QList<qreal> pointsy, QColor color );
    void debugDrawSegment( qreal x1, qreal y1, qreal x2, qreal y2, QColor color );

public slots:
    void update(float dt);

    int addLevelGeomRect(float centerX, float centerY, float halfWidth, float halfHeight, float rotationDeg, int categories = 0xFFFF);
    int addLevelGeomEdge(float x1, float y1, float x2, float y2, int categories = 0xFFFF);
    int addLevelGeomArc(float centerX, float centerY, float radius, float rotationDeg, int quadrant, int categories = 0xFFFF);
    int addLevelGeomCircle(float x1, float y1, float radius);
    void setLevelGeomTransform(int prefabId, float x, float y, float angle = 0);
    void removeLevelGeom(int id);
    void removeAllLevelGeom();

    float raycastClosestDistance(float x1, float y1, float x2, float y2, int categories = 0xFFFF);
    QVector4D raycast(float x1, float y1, float x2, float y2, int categories = 0xFFFF);
    void makeMeABox( QQuickItem * item );

    void debugDraw();

    void setPhysicsScale(float arg)
    {
        if (m_physicsScale == arg)
            return;

        m_physicsScale = arg;
        emit physicsScaleChanged(arg);
    }

private:
    int refCounter;
    b2World * _world;
    QMap<int, b2Body *> _refBodies;
    float m_physicsScale;

    static dwFieldPhysicsWorld * _instance;

    bool m_doingDebugDraw;
    QList<QVector2D> m_raysDrawBeginPoints;
    QList<QVector2D> m_raysDrawEndPoints;
    QList<qreal> m_raysDrawFractions;

};

#endif // DWFIELDPHYSICSWORLD_H
