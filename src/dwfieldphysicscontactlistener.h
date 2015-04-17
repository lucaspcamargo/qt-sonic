#ifndef DWFIELDPHYSICSCONTACTLISTENER_H
#define DWFIELDPHYSICSCONTACTLISTENER_H


class dwFieldPhysicsContactListener : public QObject
{
    Q_OBJECT
public:
    explicit dwFieldPhysicsContactListener(QObject *parent = 0);
    ~dwFieldPhysicsContactListener();

signals:

public slots:
};

#endif // DWFIELDPHYSICSCONTACTLISTENER_H
