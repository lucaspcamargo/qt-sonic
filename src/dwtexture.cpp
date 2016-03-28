#include "dwtexture.h"

#include "dwtexturecache.h"

#include <QDebug>
#include <QSGTexture>


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

#if 0
#define USE_TEXTURES_16BIT
#endif


void dwTexture::realize(QQuickWindow *window)
{

    // todo handle m_data
    QImage m_image = m_data.qtImage;

    if(!m_image.isNull())
    {

        if(
        #ifdef ANDROID
                0
        #else
                1
        #endif
                )
        {
            QImage::Format newFormat = QImage::Format_Invalid;

            QOpenGLTexture::TextureFormat texFmt;
            QOpenGLTexture::PixelType pixType;
            QOpenGLTexture::PixelFormat pixFmt;






#ifdef USE_TEXTURES_16BIT

            if(m_image.hasAlphaChannel())
            {
                newFormat = QImage::Format_RGBA8888_Premultiplied;
                pixType = QOpenGLTexture::UInt32_RGBA8_Rev;
                pixFmt = QOpenGLTexture::RGBA;
                texFmt = QOpenGLTexture::RGB5A1;
            }
            else
            {
                newFormat = QImage::Format_RGB16;
                pixType = QOpenGLTexture::UInt16_R5G6B5;
                pixFmt = QOpenGLTexture::RGB;
                texFmt = QOpenGLTexture::R5G6B5;
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
            m_glTexture->setData(0, pixFmt, pixType, (const void*) m_image.bits());

            QQuickWindow::CreateTextureOptions opts = m_image.hasAlphaChannel()?
                        QQuickWindow::TextureHasAlphaChannel :
                        QQuickWindow::CreateTextureOption(0);

            m_texture = window->createTextureFromId(m_glTexture->textureId(), m_image.size(), opts );
        }
        else
        {
            m_texture = window->createTextureFromImage(m_image);
        }
        m_realized = true;
        m_size = m_image.size();
        m_image = QImage();
    }
}

