#ifndef DWIMAGEITEM_H
#define DWIMAGEITEM_H

#include <QQuickItem>
#include <QSharedPointer>
#include <QUrl>

class dwTexture;

class dwImageItem : public QQuickItem
{

    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)


public:
    dwImageItem(QQuickItem * parent = 0);

    QSGNode * updatePaintNode(QSGNode * oldNode, UpdatePaintNodeData * data);

    QUrl source() const
    {
        return m_source;
    }

signals:

    void sourceChanged(QUrl source);

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

private:
    QSharedPointer<dwTexture> m_texture;
    QUrl m_source;
};

#endif // DWIMAGEITEM_H
