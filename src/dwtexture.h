#ifndef DWTEXTURE_H
#define DWTEXTURE_H

#include <QImage>
#include <QUrl>




#ifdef ANDROID
#define SCALE_TEXTURES_HALF
#define NO_MIPMAPPING
#else
//#define USE_COMPRESSED_TEXTURES
#endif


class QOpenGLTexture;
class QSGTexture;
class QQuickWindow;

class dwTexture
{
public:
    dwTexture( QUrl source, QImage image );
    ~dwTexture();

    QSGTexture * texture() const { return m_texture; }

    bool isRealized() const { return m_realized; }

    void realize( QQuickWindow * window );

    QSize size() const {return m_size;}

    struct Data {

        enum Type {

            QT_IMAGE,
            RAW_IMAGE
        };

        Type type;

        QImage qtImage;

        QByteArray rawImage;
        int width;
        int height;
        int glFormat;

    };

private:
    QUrl m_source;
    QSGTexture * m_texture;
    QOpenGLTexture * m_glTexture;
    Data m_data;
    QSize m_size;
    bool m_realized;
};

#endif // DWTEXTURE_H
