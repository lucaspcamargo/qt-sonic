#ifndef DWFOPHYSICSBODY_H
#define DWFOPHYSICSBODY_H

#include "dwfieldobject.h"
#include "Box2D/Box2D.h"
#include "dwfieldphysicsworld.h"
#include "QQmlListProperty"

class dwFOPhysicsBody : public QObject
{
    Q_OBJECT
    Q_ENUMS(ShapeType)
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool autorebuild READ autorebuild WRITE setAutorebuild NOTIFY autorebuildChanged)
    Q_PROPERTY(ShapeType shapeType READ shapeType WRITE setShapeType NOTIFY shapeTypeChanged)
    Q_PROPERTY(BodyType bodyType READ bodyType WRITE setBodyType NOTIFY bodyTypeChanged)
    Q_PROPERTY(int shapeCategory READ shapeCategory WRITE setShapeCategory NOTIFY shapeCategoryChanged)
    Q_PROPERTY(int shapeCollisionMask READ shapeCollisionMask WRITE setShapeCollisionMask NOTIFY shapeCollisionMaskChanged)
    Q_PROPERTY(QVector4D shapeData READ shapeData WRITE setShapeData NOTIFY shapeDataChanged)
    Q_PROPERTY(QPointF origin READ origin WRITE setOrigin NOTIFY originChanged)
public:

    enum ShapeType
    {
        ST_CIRCLE,
        ST_POLY_BOX,
        ST_POLY_CUSTOM,
        ST_EDGE_CHAIN
    };

    enum BodyType
    {
        BT_STATIC,
        BT_KINEMATIC,
        BT_DYNAMIC
    };

    explicit dwFOPhysicsBody(QObject *parent = 0);
    ~dwFOPhysicsBody();

    QVector4D shapeData() const
    {
        return m_shapeData;
    }

    QPointF origin() const
    {
        return m_origin;
    }

    ShapeType shapeType() const
    {
        return m_shapeType;
    }

    int shapeCategory() const
    {
        return m_shapeCategory;
    }

    int shapeCollisionMask() const
    {
        return m_shapeCollisionMask;
    }

    bool enabled() const
    {
        return m_enabled;
    }

    bool autorebuild() const
    {
        return m_autorebuild;
    }

    BodyType bodyType() const
    {
        return m_bodyType;
    }

signals:

    void shapeDataChanged(QVector4D arg);

    void originChanged(QPointF arg);

    void shapeTypeChanged(ShapeType arg);

    void shapeCategoryChanged(int arg);

    void shapeCollisionMaskChanged(int arg);

    void enabledChanged(bool arg);

    void autorebuildChanged(bool arg);

    void bodyTypeChanged(BodyType arg);

public slots:

    void rebuildBody();
    void updateBodyTransform();

    void setShapeData(QVector4D arg)
    {
        if (m_shapeData == arg)
            return;

        m_shapeData = arg;
        emit shapeDataChanged(arg);
        if(m_autorebuild) rebuildBody();
    }

    void setOrigin(QPointF arg)
    {
        if (m_origin == arg)
            return;

        m_origin = arg;
        emit originChanged(arg);
        if(m_autorebuild) rebuildBody();
    }

    void setShapeType(ShapeType arg)
    {
        if (m_shapeType == arg)
            return;

        m_shapeType = arg;
        emit shapeTypeChanged(arg);
        if(m_autorebuild) rebuildBody();
    }

    void setShapeCategory(int arg)
    {
        if (m_shapeCategory == arg)
            return;

        m_shapeCategory = arg;
        emit shapeCategoryChanged(arg);
        if(m_autorebuild) rebuildBody();
    }

    void setShapeCollisionMask(int arg)
    {
        if (m_shapeCollisionMask == arg)
            return;

        m_shapeCollisionMask = arg;
        emit shapeCollisionMaskChanged(arg);
        if(m_autorebuild) rebuildBody();
    }

    void setEnabled(bool arg)
    {
        if (m_enabled == arg)
            return;

        m_enabled = arg;
        emit enabledChanged(arg);
        if(m_autorebuild) rebuildBody();
    }

    bool ensureParent();
    void setAutorebuild(bool arg)
    {
        if (m_autorebuild == arg)
            return;

        m_autorebuild = arg;
        emit autorebuildChanged(arg);
    }

    void setBodyType(BodyType arg)
    {
        if (m_bodyType == arg)
            return;

        m_bodyType = arg;
        emit bodyTypeChanged(arg);
    }

private:
    dwFieldObject * m_object;
    QVector4D m_shapeData;
    QPointF m_origin;
    ShapeType m_shapeType;
    int m_shapeCategory;
    int m_shapeCollisionMask;

    b2World * m_world;
    b2Body * m_body;

    bool m_enabled;
    bool m_autorebuild;
    BodyType m_bodyType;
};

#endif // DWFOPHYSICSBODY_H
