#ifndef DWFIELDBVH_H
#define DWFIELDBVH_H

#include <QObject>

class dwFieldBVHNode;

class dwFieldBVH : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal viewCenterX READ viewCenterX WRITE setViewCenterX NOTIFY viewCenterXChanged)
    Q_PROPERTY(qreal viewCenterY READ viewCenterY WRITE setViewCenterY NOTIFY viewCenterYChanged)
    Q_PROPERTY(qreal viewRadius READ viewRadius WRITE setViewRadius NOTIFY viewRadiusChanged)
    Q_PROPERTY(bool activateAll READ activateAll WRITE setActivateAll NOTIFY activateAllChanged)
    Q_PROPERTY(dwFieldBVHNode * rootNode READ rootNode CONSTANT)

    qreal m_viewCenterX;

    qreal m_viewCenterY;

    dwFieldBVHNode * m_rootNode;

    qreal m_viewRadius;

    void updateNode(dwFieldBVHNode * node);

    bool m_activateAll;

public:
    explicit dwFieldBVH(QObject *parent = 0);
    ~dwFieldBVH();

    qreal viewCenterX() const
    {
        return m_viewCenterX;
    }

    qreal viewCenterY() const
    {
        return m_viewCenterY;
    }

    dwFieldBVHNode * rootNode() const
    {
        return m_rootNode;
    }

    qreal viewRadius() const
    {
        return m_viewRadius;
    }

    bool activateAll() const
    {
        return m_activateAll;
    }

signals:

    void viewCenterXChanged(qreal arg);

    void viewCenterYChanged(qreal arg);

    void viewRadiusChanged(qreal arg);

    void activateAllChanged(bool arg);

public slots:
    void setViewCenterX(qreal arg)
    {
        if (m_viewCenterX == arg)
            return;

        m_viewCenterX = arg;
        emit viewCenterXChanged(arg);
    }
    void setViewCenterY(qreal arg)
    {
        if (m_viewCenterY == arg)
            return;

        m_viewCenterY = arg;
        emit viewCenterYChanged(arg);
    }

    dwFieldBVHNode *createNode(qreal xC, qreal yC, qreal radius, dwFieldBVHNode * parent);

    void buildBVH(int maxNodes, dwFieldBVHNode * node);

    void update(qreal dt);

    void setViewRadius(qreal arg)
    {
        if (m_viewRadius == arg)
            return;

        m_viewRadius = arg;
        emit viewRadiusChanged(arg);
    }
    void setActivateAll(bool arg)
    {
        if (m_activateAll == arg)
            return;

        m_activateAll = arg;
        emit activateAllChanged(arg);
    }
};

#endif // DWFIELDBVH_H
