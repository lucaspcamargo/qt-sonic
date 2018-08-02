#include "dwtexture.h"

#include "dwtexturecache.h"

#include <QDebug>
#include <QSGTexture>
#include <QOpenGLPixelTransferOptions>

dwTexture::dwTexture( QUrl source, QImage image ) :
    m_texture( 0 ),
    m_glTexture( 0 ),
    m_source(source),
    m_realized(false),
    m_size(image.size())
{
    m_data = Data();
    m_data.type = Data::QT_IMAGE;
    m_data.qtImage = image;
}

dwTexture::~dwTexture()
{
    dwTextureCache * c = dwTextureCache::singleton();
    if(!c) return;

    if(m_texture) c->deleteAfterRendering(m_texture);
    if(m_glTexture) c->deleteAfterRendering(m_glTexture);
}

#include <QQuickWindow>
#include <QOpenGLTexture>




void dwTexture::realize(QQuickWindow *window)
{

    // todo handle m_data
    QImage m_image = m_data.qtImage;
    m_size = QSize(m_image.size()); // save size before rescaling
    #ifdef SCALE_TEXTURES_HALF
        m_image = m_image.scaled(m_image.width()/2, m_image.height()/2, Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
    #endif

    if(!m_image.isNull())
    {

#ifdef ANDROID

        QQuickWindow::CreateTextureOptions opts = m_image.hasAlphaChannel()?
                    QQuickWindow::TextureHasAlphaChannel :
                    QQuickWindow::TextureIsOpaque;

        m_texture = window->createTextureFromImage(m_image, opts);
        m_texture->setFiltering(QSGTexture::Nearest);

#else

        QImage::Format newFormat = QImage::Format_Invalid;

        QOpenGLTexture::TextureFormat texFmt;
        QOpenGLTexture::PixelType pixType;
        QOpenGLTexture::PixelFormat pixFmt;



#ifdef USE_COMPRESSED_TEXTURES

        if(m_image.hasAlphaChannel())
        {
            newFormat = QImage::Format_RGBA8888_Premultiplied;
            pixType = QOpenGLTexture::UInt32_RGBA8_Rev;
            pixFmt = QOpenGLTexture::RGBA;
            texFmt = (QOpenGLTexture::TextureFormat) GL_COMPRESSED_RGBA_S3TC_DXT5_EXT;

        }
        else
        {
            newFormat = QImage::Format_RGBX8888;
            pixType = QOpenGLTexture::UInt32_RGBA8_Rev;
            pixFmt = QOpenGLTexture::RGBA;
            texFmt = (QOpenGLTexture::TextureFormat) GL_COMPRESSED_RGB_S3TC_DXT1_EXT;
        }

#else

        if(m_image.hasAlphaChannel())
        {
            newFormat = QImage::Format_RGBA8888_Premultiplied;
            pixType = QOpenGLTexture::UInt32_RGBA8_Rev;
            pixFmt = QOpenGLTexture::RGBA;
            texFmt = QOpenGLTexture::RGBA8_UNorm;
        }
        else
        {
            newFormat = QImage::Format_RGBX8888;
            pixType = QOpenGLTexture::UInt32_RGBA8_Rev;
            pixFmt = QOpenGLTexture::RGBA;
            texFmt = QOpenGLTexture::RGB8_UNorm;
        }
#endif

        if(newFormat != m_image.format() && newFormat != QImage::Format_Invalid)
            m_image = m_image.convertToFormat(newFormat);

        m_glTexture = new QOpenGLTexture(QOpenGLTexture::Target2D);
        m_glTexture->setFormat(texFmt);
        m_glTexture->setSize(m_image.width(), m_image.height());

        m_glTexture->allocateStorage();
        m_glTexture->setData( pixFmt, pixType, (const void*) m_image.bits() );
#ifdef NO_MIPMAPPING
        m_glTexture->setMinMagFilters(QOpenGLTexture::Nearest, QOpenGLTexture::Nearest);
#else
        m_glTexture->generateMipMaps();
        m_glTexture->setMinMagFilters(QOpenGLTexture::LinearMipMapLinear, QOpenGLTexture::Linear);
#endif
        QQuickWindow::CreateTextureOptions opts = m_image.hasAlphaChannel()?
                    QQuickWindow::TextureHasAlphaChannel :
                    QQuickWindow::TextureIsOpaque;

        m_texture = window->createTextureFromId(m_glTexture->textureId(), m_size, opts );

#endif
        m_realized = true;
        m_image = QImage();
    }
}

