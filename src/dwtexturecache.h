#ifndef DWTEXTURECACHE_H
#define DWTEXTURECACHE_H

#include <QObject>
#include <QUrl>
#include <QHash>
#include <QWeakPointer>
#include <QSharedPointer>

class QQuickWindow;
class dwTexture;
class QSGTexture;
class QOpenGLTexture;

class dwTextureCache : public QObject
{
    Q_OBJECT

public:
    explicit dwTextureCache(QObject *parent = 0);

    inline static dwTextureCache * singleton(){ return ms_singleton; }

    QSharedPointer<dwTexture> getTexture(QUrl source, QQuickWindow* window);

    void deleteAfterRendering(QOpenGLTexture * tex);
    void deleteAfterRendering(QSGTexture * tex);

signals:

public slots:

    void onAfterRendering();

private:
    QSharedPointer<dwTexture> createTexture(QUrl source, QQuickWindow* window);

    QHash<QUrl, QWeakPointer<dwTexture> > m_textures;
    QList<QSGTexture*> m_qsgDeleteList;
    QList<QOpenGLTexture*> m_glDeleteList;

    static dwTextureCache * ms_singleton;
};

#endif // DWTEXTURECACHE_H
