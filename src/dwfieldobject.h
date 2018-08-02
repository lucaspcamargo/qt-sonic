#ifndef DWFIELDOBJECT_H
#define DWFIELDOBJECT_H

#include <QQuickItem>

class dwFieldObject : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(bool active READ active WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(int managerIndex READ managerId WRITE setManagerId NOTIFY managerIdChanged)

    Q_PROPERTY(bool sizeMatters READ sizeMatters WRITE setSizeMatters NOTIFY sizeMattersChanged)
    Q_PROPERTY(bool rotationMatters READ rotationMatters WRITE setRotationMatters NOTIFY rotationMattersChanged)

    Q_PROPERTY(bool notStub READ notStub CONSTANT)
    Q_PROPERTY(bool autoVisibility READ autoVisibility WRITE setAutoVisibility NOTIFY autoVisibilityChanged)

    bool m_active;

    int m_managerId;

    bool m_sizeMatters;

    bool m_rotationMatters;

    bool m_autoVisibility;

public:
    dwFieldObject(QQuickItem * parent = 0);
    ~dwFieldObject();

    bool active() const
    {
        return m_active;
    }

    int managerId() const
    {
        return m_managerId;
    }

    bool sizeMatters() const
    {
        return m_sizeMatters;
    }

    bool rotationMatters() const
    {
        return m_rotationMatters;
    }

    bool notStub() const
    {
        return true;
    }

    bool autoVisibility() const
    {
        return m_autoVisibility;
    }

signals:

    void activeChanged(bool arg);
    void activated();
    void deactivated();

    void managerIdChanged(int arg);

    void sizeMattersChanged(bool arg);

    void rotationMattersChanged(bool arg);

    void autoVisibilityChanged(bool arg);

public slots:

void nodeConnect(QObject * bvhNode);

void activate()
{
    setActive(true);
}

void deactivate()
{
    setActive(false);
}

void setActive(bool arg)
{
    if (m_active == arg)
        return;

    m_active = arg;
    emit activeChanged(arg);

    if(m_autoVisibility) setVisible( arg );

    if(arg) emit activated();
    else emit deactivated();


}
void setManagerId(int arg)
{
    if (m_managerId == arg)
        return;

    m_managerId = arg;
    emit managerIdChanged(arg);
}
void setSizeMatters(bool arg)
{
    if (m_sizeMatters == arg)
        return;

    m_sizeMatters = arg;
    emit sizeMattersChanged(arg);
}
void setRotationMatters(bool arg)
{
    if (m_rotationMatters == arg)
        return;

    m_rotationMatters = arg;
    emit rotationMattersChanged(arg);
}
void setAutoVisibility(bool arg)
{
    if (m_autoVisibility == arg)
        return;

    m_autoVisibility = arg;
    emit autoVisibilityChanged(arg);
}
};

#endif // DWFIELDOBJECT_H
