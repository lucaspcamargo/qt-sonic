#ifndef DWTEXTURE_H
#define DWTEXTURE_H

#include <QImage>
#include <QUrl>

class QOpenGLTexture;
class QSGTexture;
class QQuickWindow;

class dwTexture
{
public:
    dwTexture( QUrl source, QImage image );
    ~dwTexture();

    QSGTexture * texture() { return m_texture; }

    bool isRealized() { return m_realized; }

    void realize( QQuickWindow * window );

private:
    QUrl m_source;
    QSGTexture * m_texture;
    QOpenGLTexture * m_glTexture;
    QImage m_image;
    bool m_realized;
};

#endif // DWTEXTURE_H
