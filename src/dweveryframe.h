#ifndef DWEVERYFRAME_H
#define DWEVERYFRAME_H

#include <QObject>

class dwEveryFrame : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    bool m_enabled;

public:
    explicit dwEveryFrame(QObject *parent = 0);

bool enabled() const
{
    return m_enabled;
}

signals:
    void update(float dt);

    void enabledChanged(bool arg);

public slots:
    void onUpdated(float dt);

    void setEnabled(bool arg)
    {
        if (m_enabled == arg)
            return;

        m_enabled = arg;
        emit enabledChanged(arg);

        //changeConnection();
    }

private:
    void changeConnection();
};

#endif // DWEVERYFRAME_H
