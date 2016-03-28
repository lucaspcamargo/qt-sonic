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
    // if there is no texture, there will be no node
    if(!m_texture)
        return 0;

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
        node->setSourceRect(m_cropRect);
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
