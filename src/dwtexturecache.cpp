#include "dwtexturecache.h"

#include "dwtexture.h"

#include <QImage>
#include <QImageReader>
#include <QStringList>
#include <QQuickWindow>
#include <QList>
#include <QByteArray>
#include <QDebug>
#include <QOpenGLTexture>

dwTextureCache * dwTextureCache::ms_singleton = 0;

dwTextureCache::dwTextureCache(QObject *parent) : QObject(parent)
{
    ms_singleton = this;

    QString initStr = "[dwTextureCache] Supported image formats: ";
    QList<QByteArray> exts = QImageReader::supportedImageFormats();
    foreach (QByteArray ext, exts)
    {
        initStr.append(ext);
        initStr.append(" ");
    }
    qDebug(initStr.toLocal8Bit());
}

dwTextureCache::~dwTextureCache()
{
    ms_singleton = 0;
}

QSharedPointer<dwTexture> dwTextureCache::getTexture(QUrl source, QQuickWindow *window)
{
    source = source.adjusted(QUrl::NormalizePathSegments);

    if(m_textures.contains(source))
    {
        QSharedPointer<dwTexture> ptr = m_textures.value(source).toStrongRef();
        if(ptr)
            return ptr;
        else
            m_textures.remove(source);
    }

    QSharedPointer<dwTexture> ptr(0);

    if(window)
        ptr = createTexture(source, window);

    if(ptr)
    {
        m_textures.insert( source, ptr.toWeakRef() );
    }

    return ptr;
}

void dwTextureCache::deleteAfterRendering(QOpenGLTexture *tex)
{
    m_glDeleteList.push_back(tex);
}

void dwTextureCache::deleteAfterRendering(QSGTexture *tex)
{
    m_qsgDeleteList.push_back(tex);
}

#include <QSGTexture> // for destruction
void dwTextureCache::onAfterRendering()
{
    if(!m_glDeleteList.isEmpty())
    {
        foreach(QOpenGLTexture * tex, m_glDeleteList)
        {
            tex->destroy();
            delete tex;
        }
        m_glDeleteList.clear();
    }

    if(!m_qsgDeleteList.isEmpty())
    {
        foreach(QSGTexture * qtex, m_qsgDeleteList)
        {
            delete qtex;
        }
        m_qsgDeleteList.clear();
    }
}

#include "dwutil.h"

QSharedPointer<dwTexture> dwTextureCache::createTexture(QUrl source, QQuickWindow *window)
{

    QSharedPointer<dwTexture> ret(0);

    QImage img;
    QIODevice * dev = dwUtil::singleton()->getDeviceFromUrl(source);
    QScopedPointer<QIODevice> devPtr(dev);

    QImageReader reader(devPtr.data());

    if(reader.canRead())
    {
        img = reader.read();

        if(! img.isNull() )
        {
            dwTexture * tex = new dwTexture(source, img);
            ret = QSharedPointer<dwTexture>(tex);
        }
    }

    return ret;
}

