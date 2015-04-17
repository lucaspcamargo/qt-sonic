#include "dwcomponentcache.h"
#include "dwroot.h"
#include <QQmlApplicationEngine>
#include <QQmlComponent>

dwComponentCache::dwComponentCache(QObject *parent) :
    QObject(parent)
{
    _cache = QMap<QString, QQmlComponent *>();
}

#include <QThread>
QQmlComponent *dwComponentCache::getComponent(QUrl loc)
{
    QString str = loc.toString();
    qDebug(str.toLocal8Bit());

    if(_cache.contains(str))
    {
        return _cache[str];
    }
    else
    {
        QQmlApplicationEngine * eng = dwRoot::singleton()->appEngine();
        QQmlComponent * comp = new QQmlComponent(eng, loc, QQmlComponent::PreferSynchronous);
        _cache.insert(str, comp);
        return comp;
    }
}
