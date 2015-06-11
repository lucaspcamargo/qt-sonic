#include "dwroot.h"
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include <QElapsedTimer>

#include "dwtexturecache.h"
#include "dwsoundsystem.h"

dwRoot * dwRoot::m_singleton = 0;

dwRoot::dwRoot(QQmlApplicationEngine *parent) :
    QObject(parent),
    m_engine(parent),
    m_profAccum(0),
    m_profCounter(0),
    m_profWorstAccum(0),
    m_profilerFPS(0),
    m_profilerFrameTime(0),
    m_profilerWorstFrameTime(0)
{
    m_singleton = this;

    setObjectName("dwRoot");
    m_engine->rootContext()->setContextProperty("DWRoot", this);

    m_textureCache = new dwTextureCache(this);
    m_soundSystem = new dwSoundSystem(this);
    m_engine->rootContext()->setContextProperty("dwTextureCache", m_soundSystem);
    m_engine->rootContext()->setContextProperty("dwSoundSystem", m_soundSystem);

    m_timer = new QElapsedTimer();
    m_timer->start();
}

void dwRoot::onLoaded()
{
    m_window = reinterpret_cast<QQuickWindow*>(m_engine->rootObjects()[0]);
    m_window->setClearBeforeRendering(false);
    connect(m_window, &QQuickWindow::afterAnimating, this, &dwRoot::doFrameUpdate);
    connect(m_window, &QQuickWindow::afterRendering, m_textureCache, &dwTextureCache::onAfterRendering);
}

void dwRoot::doFrameUpdate()
{
    qint64 elapsed = m_timer->nsecsElapsed();
    m_timer->restart();

    float time;

#ifdef ANDROID_DUMMIED
    time = (0.01666666f * qRound(qMin(elapsed * 0.000000001f, 0.1f)/0.016666666f));
#else
    time = (qMin(elapsed * 0.000000001, 0.1));
#endif

    if(qAbs(time - 1.0/60.0) < 0.002)
        time = 1.0/60.0;

    emit preUpdate(time);
    emit update(time);
    emit postUpdate(time);

    qint64 updateElapsed = m_timer->nsecsElapsed();
    float updateTime = (updateElapsed * 0.000000001);

    m_profAccum += time;
    m_profFrameTimeAccum += updateTime;
    m_profCounter ++;

    m_profWorstAccum = qMax(m_profWorstAccum, updateTime);

    if(m_profCounter == 30)
    {
        m_profilerFPS = 30 / m_profAccum;
        m_profAccum = 0;
        m_profCounter = 0;
        emit profilerFPSChanged(m_profilerFPS);

        m_profilerFrameTime = m_profFrameTimeAccum / 30;
        m_profilerWorstFrameTime = m_profWorstAccum;
        m_profFrameTimeAccum = 0;
        m_profWorstAccum = 0;
        emit profilerFrameTimeChanged(m_profilerFrameTime);
        emit profilerWorstFrameTimeChanged(m_profilerWorstFrameTime);
    }

   //qDebug(QStringLiteral("elapsed: %1  dt: %2").arg(elapsed).arg(qMin(elapsed * 0.000000001f, 0.5f)).toLocal8Bit() );


}

