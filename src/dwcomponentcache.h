#ifndef DWCOMPONENTCACHE_H
#define DWCOMPONENTCACHE_H

#include <QObject>
#include <QMap>
#include <QUrl>

class QQmlComponent;

class dwComponentCache : public QObject
{
    Q_OBJECT
public:
    explicit dwComponentCache(QObject *parent = 0);

signals:

public slots:
    QQmlComponent * getComponent(QUrl location);

private:
    QMap<QString, QQmlComponent *> _cache;

};

#endif // DWCOMPONENTCACHE_H
