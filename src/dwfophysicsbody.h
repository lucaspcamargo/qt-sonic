#ifndef DWFOPHYSICSBODY_H
#define DWFOPHYSICSBODY_H

#include <QQuickItem>

class DWFOPhysicsBody : public QObject
{
    Q_OBJECT
public:
    explicit DWFOPhysicsBody(QObject *parent = 0);
    ~DWFOPhysicsBody();

signals:

public slots:
};

#endif // DWFOPHYSICSBODY_H
