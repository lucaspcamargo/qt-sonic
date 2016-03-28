#ifndef DWSPRITESHEETCACHE_H
#define DWSPRITESHEETCACHE_H

#include <QObject>
#include <QUrl>
#include <QHash>
#include <QWeakPointer>
#include <QSharedPointer>

class QQuickWindow;
class dwSpritesheet;

class dwSpritesheetCache : public QObject
{
    Q_OBJECT

public:
    explicit dwSpritesheetCache(QObject *parent = 0);
    virtual ~dwSpritesheetCache();

    inline static dwSpritesheetCache * singleton(){ return ms_singleton; }

    QSharedPointer<dwSpritesheet> getSpritesheet(QUrl source, QQuickWindow* window);


signals:

public slots:

private:
    QSharedPointer<dwSpritesheet> createSpritesheet(QUrl source, QQuickWindow* window);

    QHash<QUrl, QWeakPointer<dwSpritesheet> > m_spritesheets;

    static dwSpritesheetCache * ms_singleton;
};


#endif // DWSPRITESHEETCACHE_H
