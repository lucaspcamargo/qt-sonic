#ifndef DWSPRITESEQUENCE_H
#define DWSPRITESEQUENCE_H

#include <QObject>

class dwSpriteSequence : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int frameWidth READ frameWidth WRITE setFrameWidth NOTIFY frameWidthChanged)
    Q_PROPERTY(int frameHeight READ frameHeight WRITE setFrameHeight NOTIFY frameHeightChanged)
    Q_PROPERTY(int frameDuration READ frameDuration WRITE setFrameDuration NOTIFY frameDurationChanged)
    int m_frameWidth;

    int m_frameHeight;

int m_frameDuration;

public:
    explicit dwSpriteSequence(QObject *parent = 0);

int frameWidth() const
{
    return m_frameWidth;
}

int frameHeight() const
{
    return m_frameHeight;
}

int frameDuration() const
{
    return m_frameDuration;
}

signals:

void frameWidthChanged(int frameWidth);

void frameHeightChanged(int frameHeight);

void frameDurationChanged(int frameDuration);

public slots:
void setFrameWidth(int frameWidth)
{
    if (m_frameWidth == frameWidth)
        return;

    m_frameWidth = frameWidth;
    emit frameWidthChanged(frameWidth);
}
void setFrameHeight(int frameHeight)
{
    if (m_frameHeight == frameHeight)
        return;

    m_frameHeight = frameHeight;
    emit frameHeightChanged(frameHeight);
}
void setFrameDuration(int frameDuration)
{
    if (m_frameDuration == frameDuration)
        return;

    m_frameDuration = frameDuration;
    emit frameDurationChanged(frameDuration);
}
};

#endif // DWSPRITESEQUENCE_H
