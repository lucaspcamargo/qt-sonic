#ifndef DWROOT_H
#define DWROOT_H

#include <QObject>


class QQmlApplicationEngine;
class QQuickWindow;
class QElapsedTimer;

class dwSoundSystem;
class dwTextureCache;

class dwRoot : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float profilerFPS READ profilerFPS NOTIFY profilerFPSChanged)
    Q_PROPERTY(float profilerFrameTime READ profilerFrameTime NOTIFY profilerFrameTimeChanged)
    Q_PROPERTY(float profilerWorstFrameTime READ profilerWorstFrameTime NOTIFY profilerWorstFrameTimeChanged)
    Q_PROPERTY(dwTextureCache * textureCache READ textureCache FINAL CONSTANT)
    Q_PROPERTY(dwSoundSystem * soundSystem READ soundSystem FINAL CONSTANT)

public:
    explicit dwRoot(QQmlApplicationEngine *parent = 0);

    QQmlApplicationEngine * appEngine(){ return m_engine; }

    float profilerFPS() const
    {
        return m_profilerFPS;
    }

    float profilerFrameTime() const
    {
        return m_profilerFrameTime;
    }

    float profilerWorstFrameTime() const
    {
        return m_profilerWorstFrameTime;
    }

    dwSoundSystem * soundSystem() const { return m_soundSystem; }

    dwTextureCache * textureCache() const { return m_textureCache; }

signals:
    void preUpdate(float frameTime);
    void update(float frameTime);
    void postUpdate(float frameTime);

    void profilerFPSChanged(float arg);
    void profilerFrameTimeChanged(float arg);
    void profilerWorstFrameTimeChanged(float arg);

    void textureCacheChanged(dwTextureCache * textureCache);

public slots:
    void onLoaded();
    void doFrameUpdate();

    static dwRoot * singleton(){return m_singleton;}

private:
    QQmlApplicationEngine * m_engine;
    QQuickWindow * m_window;
    QElapsedTimer * m_timer;

    static dwRoot * m_singleton;
    dwSoundSystem * m_soundSystem;
    dwTextureCache * m_textureCache;

    float m_profAccum;
    float m_profFrameTimeAccum;
    int m_profCounter;
    float m_profWorstAccum;

    float m_profilerFPS;
    float m_profilerFrameTime;
    float m_profilerWorstFrameTime;
};

#endif // DWROOT_H
