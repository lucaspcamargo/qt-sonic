#include "dwsprite.h"
#include "dwspritesheetcache.h"
#include "dwspritesheet.h"
#include "dwanimationupdater.h"

dwSprite::dwSprite(QQuickItem *parent)
    :dwImageItem(parent),
      m_sheet(0),
      m_seq(0),
      m_frame(0),
      m_timeInFrame(0)
{
    setCrop(true);

    m_animationDomain = dwAnimationUpdater::FieldDomain;
    m_running = true;
    dwAnimationUpdater::singleton()->registerAnimatable(this);
}

dwSprite::~dwSprite()
{
    if(m_running)
        dwAnimationUpdater::singleton()->unregisterAnimatable(this);

}

void dwSprite::reloadSpritesheet()
{
    // unload current sheet
    m_sheet.clear();
    setSource(QUrl());

    // load new
    m_sheet = dwSpritesheetCache::singleton()->getSpritesheet(m_spritesheet.adjusted(QUrl::RemoveQuery), window());
    if(m_sheet)
    {
        setSource(m_sheet->textureSource());
        if(m_spritesheet.hasQuery())
        {
            m_sequence = m_spritesheet.query();
            emit sequenceChanged(m_sequence);
        }
        resetSequence(true);
    }
    else
    {
        qDebug("[dwSprite] Could not load spritesheet:");
        qDebug(m_spritesheet.toString().toLocal8Bit());
    }
}

void dwSprite::resetSequence(bool sheetChange)
{
    if(sheetChange)
    {
        if(!m_sheet->sequence(m_sequence))
            setSequence(m_sheet->sequence(0)->name);
    }

    m_seq = m_sheet->sequence(m_sequence);
    m_frame = 0;
    m_timeInFrame = 0;

    if(m_seq)
        setupCurrentFrameOnImage();

}

void dwSprite::setRunning(bool running)
{
    if (m_running == running)
        return;

    m_running = running;
    emit runningChanged(running);

    if(m_running)
        dwAnimationUpdater::singleton()->registerAnimatable(this);
    else
        dwAnimationUpdater::singleton()->unregisterAnimatable(this);

}

void dwSprite::advanceFrame()
{
    if(m_seq)
    {
        m_frame = (m_frame + 1)%(m_seq->frames.size());
        m_timeInFrame = 0;

        setupCurrentFrameOnImage();
    }
}

void dwSprite::setupCurrentFrameOnImage()
{
    setCropRect(m_seq->frames[m_frame].sourceRect);
    setImplicitSize(m_seq->frames[m_frame].size.width(), m_seq->frames[m_frame].size.height());
}

void dwSprite::updateTime(qreal dt)
{
    Q_ASSERT(m_running);
    if(!m_sheet) return;
    if(!m_seq) return;

    int prevFrame = m_frame;
    dwSpritesheet::Sequence *prevSeq = m_seq;

    m_timeInFrame += dt;

    while(m_timeInFrame > m_seq->frames[m_frame].duration)
    {
        m_timeInFrame -= m_seq->frames[m_frame].duration;
        m_frame = (m_frame + 1)%(m_seq->frames.size());

        if(m_frame == 0) emit animationLooped();
    }

    if(m_frame != prevFrame)
        setupCurrentFrameOnImage();
}



int dwSprite::domain()
{
    return m_animationDomain;
}
