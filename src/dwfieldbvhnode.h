#ifndef DWFIELDBVHNODE_H
#define DWFIELDBVHNODE_H

#include <QObject>

class dwFieldBVHNode : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal centerX READ centerX WRITE setCenterX NOTIFY centerXChanged)
    Q_PROPERTY(qreal centerY READ centerY WRITE setCenterY NOTIFY centerYChanged)
    Q_PROPERTY(qreal radius READ radius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(bool active READ active WRITE setActive NOTIFY activeChanged)
    qreal m_centerX;

    qreal m_centerY;

    qreal m_radius;

    bool m_active;

public:
    explicit dwFieldBVHNode(dwFieldBVHNode *parent = 0);
    ~dwFieldBVHNode();

    qreal centerX() const
    {
        return m_centerX;
    }

    qreal centerY() const
    {
        return m_centerY;
    }

    qreal radius() const
    {
        return m_radius;
    }

    bool active() const
    {
        return m_active;
    }

    void childEvent(QChildEvent *);

signals:
    void activated();
    void deactivated();

    void centerXChanged(qreal arg);

    void centerYChanged(qreal arg);

    void radiusChanged(qreal arg);

    void activeChanged(bool arg);

public slots:

    int childrenCount()
    {
        return children().length();
    }

    dwFieldBVHNode * child(int index)
    {
        return static_cast<dwFieldBVHNode*>(children()[index]);
    }

    void setCenterX(qreal arg)
    {
        if (m_centerX == arg)
            return;

        m_centerX = arg;
        emit centerXChanged(arg);
    }
    void setCenterY(qreal arg)
    {
        if (m_centerY == arg)
            return;

        m_centerY = arg;
        emit centerYChanged(arg);
    }
    void setRadius(qreal arg)
    {
        if (m_radius == arg)
            return;

        m_radius = arg;
        emit radiusChanged(arg);
    }
    void setActive(bool arg)
    {
        if (m_active == arg)
            return;

        m_active = arg;
        emit activeChanged(arg);

        if(arg)
            emit activated();
        else
            emit deactivated();

        //qDebug(arg? "node changed to active" : "node changed to inactive");
    }

    void setHierarchyInactive()
    {
        if(!m_active) return;

        foreach (QObject * obj, children())
        {
            dwFieldBVHNode * childNode = static_cast<dwFieldBVHNode * >(obj);
            if(childNode->active())
                childNode->setHierarchyInactive();
        }

        setActive(false);
    }

    void recalcGeometry();
    void disconnectActivationSignals();
    qreal getXExtent();
    qreal getYExtent();

    void markForDeletion();
};

#endif // DWFIELDBVHNODE_H
