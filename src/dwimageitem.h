#ifndef DWIMAGEITEM_H
#define DWIMAGEITEM_H

#include <QQuickItem>
#include <QSharedPointer>
#include <QUrl>
#include <QRectF>


class dwTexture;
class QSGTexture;

class dwImageItem : public QQuickItem
{

    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(bool crop READ crop WRITE setCrop NOTIFY cropChanged)
    Q_PROPERTY(QRectF cropRect READ cropRect WRITE setCropRect NOTIFY cropRectChanged)
    Q_PROPERTY(QSGTexture* texture READ texture NOTIFY textureChanged)

public:
    dwImageItem(QQuickItem * parent = 0);

    QSGNode * updatePaintNode(QSGNode * oldNode, UpdatePaintNodeData * data);

    QUrl source() const
    {
        return m_source;
    }

    bool crop() const
    {
        return m_crop;
    }

    QRectF cropRect() const
    {
        return m_cropRect;
    }

    QSGTexture* texture() const;

signals:

    void sourceChanged(QUrl source);

    void cropChanged(bool crop);

    void cropRectChanged(QRectF cropRect);

    void textureChanged(QSGTexture* texture);

public slots:

    void onWindowChanged();

void setSource(QUrl source)
{
    if (m_source == source)
        return;

    m_source = source;
    emit sourceChanged(source);

    reloadTexture();
}

void reloadTexture();

void setCrop(bool crop)
{
    if (m_crop == crop)
        return;

    m_crop = crop;
    emit cropChanged(crop);

    update();
}

void setCropRect(QRectF cropRect)
{
    if (m_cropRect == cropRect)
        return;

    m_cropRect = cropRect;
    emit cropRectChanged(cropRect);

    setImplicitSize(cropRect.width(), cropRect.height());
    update();
}

private:
    QSharedPointer<dwTexture> m_texture;
    QUrl m_source;
    bool m_crop;
    QRectF m_cropRect;
};

#endif // DWIMAGEITEM_H
