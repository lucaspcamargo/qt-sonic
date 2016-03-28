#ifndef DWSPRITE_H
#define DWSPRITE_H

#include "dwimageitem.h"
#include "dwspritesheet.h"
#include "dwanimatable.h"

#include <QUrl>
#include <QSharedPointer>

class dwSprite : public dwImageItem, public dwAnimatable
{
    Q_OBJECT
    Q_PROPERTY(QUrl spritesheet READ spritesheet WRITE setSpritesheet NOTIFY spritesheetChanged)
    Q_PROPERTY(QString sequence READ sequence WRITE setSequence NOTIFY sequenceChanged)
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(int animationDomain READ animationDomain WRITE setAnimationDomain NOTIFY animationDomainChanged)


public:
    explicit dwSprite(QQuickItem * parent = 0);
    virtual ~dwSprite();
    
    QUrl spritesheet() const
    {
        return m_spritesheet;
    }

    QString sequence() const
    {
        return m_sequence;
    }

    bool running() const
    {
        return m_running;
    }

    int animationDomain() const
    {
        return m_animationDomain;
    }



signals:
    
    void spritesheetChanged(QUrl spritesheet);

    void sequenceChanged(QString sequence);

    void runningChanged(bool running);

    void animationDomainChanged(int animationDomain);

    void animationLooped();

public slots:
void setSpritesheet(QUrl spritesheet)
{
    if (m_spritesheet == spritesheet)
        return;

    m_spritesheet = spritesheet;

    reloadSpritesheet();
    emit spritesheetChanged(spritesheet);
}
void setSequence(QString sequence)
{
    if (m_sequence == sequence)
        return;

    m_sequence = sequence;

    resetSequence();
    emit sequenceChanged(sequence);
}

void reloadSpritesheet();
void resetSequence(bool sheetChange = false);

void setRunning(bool running);

void setAnimationDomain(int animationDomain)
{
    if (m_animationDomain == animationDomain)
        return;

    m_animationDomain = animationDomain;
    emit animationDomainChanged(animationDomain);
}

void advanceFrame();

private:

void setupCurrentFrameOnImage();

QUrl m_spritesheet;
QString m_sequence;

QSharedPointer<dwSpritesheet> m_sheet;
dwSpritesheet::Sequence *m_seq;

int m_frame;
qreal m_timeInFrame;

bool m_running;
int m_animationDomain;

// dwAnimatable interface
public:
    void updateTime(qreal dt);
    int domain();
};

#endif // DWSPRITE_H
