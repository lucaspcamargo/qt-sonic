#include "dwspritesheetcache.h"

#include "dwspritesheet.h"


dwSpritesheetCache * dwSpritesheetCache::ms_singleton = 0;

dwSpritesheetCache::dwSpritesheetCache(QObject *parent) : QObject(parent)
{
    ms_singleton = this;

    QString initStr = "[dwSpritesheetCache] Initializing ";
}

dwSpritesheetCache::~dwSpritesheetCache()
{
    ms_singleton = 0;
}

QSharedPointer<dwSpritesheet> dwSpritesheetCache::getSpritesheet(QUrl source, QQuickWindow *window)
{
    source = source.adjusted(QUrl::NormalizePathSegments);

    if(m_spritesheets.contains(source))
    {
        QSharedPointer<dwSpritesheet> ptr = m_spritesheets.value(source).toStrongRef();
        if(ptr)
            return ptr;
        else
            m_spritesheets.remove(source);
    }

    QSharedPointer<dwSpritesheet> ptr(0);

    if(window)
        ptr = createSpritesheet(source, window);

    if(ptr)
    {
        m_spritesheets.insert( source, ptr.toWeakRef() );
    }

    return ptr;
}

#include "dwutil.h"

QSharedPointer<dwSpritesheet> dwSpritesheetCache::createSpritesheet(QUrl source, QQuickWindow *window)
{

    QSharedPointer<dwSpritesheet> ret(0);


    dwSpritesheet * ss = new dwSpritesheet(source);
    ret = QSharedPointer<dwSpritesheet>(ss);


    return ret;
}

