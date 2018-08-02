#include "dwimageitem.h"
#include "dwtexturecache.h"
#include "dwtexture.h"

#include <QQuickWindow>
#include <QSGTexture>
#include <QSGSimpleRectNode>
#include <QSGSimpleTextureNode>

#include "QDebug"

dwImageItem::dwImageItem(QQuickItem *parent) :
    QQuickItem(parent),
    m_texture(0),
    m_crop(false),
    m_cropRect(QRectF(0,0,0,0))
{
    setFlag(ItemHasContents, true);
    connect(this, &dwImageItem::windowChanged, this, &dwImageItem::onWindowChanged);



}

QSGNode *dwImageItem::updatePaintNode(QSGNode *oldNode, QQuickItem::UpdatePaintNodeData *data)
{
    Q_UNUSED(data)

    // if there is no texture, there will be no node
    if(!m_texture || width() <= 0 || height() <=0 )
    {
        if(oldNode) delete oldNode;
        return 0;
    }

    if(!m_texture->isRealized())
    {
        m_texture->realize(window());
    }

    QSGSimpleTextureNode * node = 0;

    if(oldNode)
    {
        node = static_cast<QSGSimpleTextureNode*>(oldNode);
    }else
    {
        node = new QSGSimpleTextureNode();
    }

    node->setTexture(m_texture->texture());
    node->setRect(QRectF( 0, 0,
                          width(),
                          height() ));

    if(m_crop)
    {
#ifdef SCALE_TEXTURES_HALF
        const qreal scale =  0.5;    //m_texture->texture()->textureSize().width() / m_texture->size().width();
        node->setSourceRect(m_cropRect.x() * scale,
                            m_cropRect.y() * scale,
                            m_cropRect.width() * scale,
                            m_cropRect.height() * scale );
#else
        node->setSourceRect(m_cropRect);
#endif
    }

    return node;
}

void dwImageItem::onWindowChanged()
{
    reloadTexture();
    //update(); not needed because reloadTexture already calls it
}

void dwImageItem::reloadTexture()
{

    if(m_source.isValid() && window())
    {
        m_texture = dwTextureCache::singleton()->getTexture(m_source, window());
        if(!m_texture.isNull())
        {
            QSize s = m_texture->size();
            setImplicitSize(s.width(), s.height());
        }
    }
    else
    {
        if(!m_texture.isNull())
            m_texture.clear();
    }

    update();

}


QSGTexture* dwImageItem::texture() const
{
    if(m_texture.isNull() && !m_texture->isRealized())
        return 0;
    else
        return m_texture->texture();
}
