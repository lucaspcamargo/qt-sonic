#ifndef DWROOT_H
#define DWROOT_H

#include <QObject>


class QQmlApplicationEngine;
class QQuickWindow;
class QElapsedTimer;

class DWSoundSystem;

class dwRoot : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float profilerFPS READ profilerFPS NOTIFY profilerFPSChanged)
    Q_PROPERTY(float profilerFrameTime READ profilerFrameTime NOTIFY profilerFrameTimeChanged)
    Q_PROPERTY(float profilerWorstFrameTime READ profilerWorstFrameTime NOTIFY profilerWorstFrameTimeChanged)
    Q_PROPERTY(DWSoundSystem * soundSystem READ soundSystem FINAL CONSTANT)
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

signals:
    void preUpdate(float frameTime);
    void update(float frameTime);
    void postUpdate(float frameTime);

    void profilerFPSChanged(float arg);
    void profilerFrameTimeChanged(float arg);
    void profilerWorstFrameTimeChanged(float arg);

public slots:
    void onLoaded();
    void doFrameUpdate();

    static dwRoot * singleton(){return m_singleton;}
    DWSoundSystem * soundSystem(){ return m_soundSystem; }

private:
    QQmlApplicationEngine * m_engine;
    QQuickWindow * m_window;
    QElapsedTimer * m_timer;


    float m_profAccum;
    float m_profFrameTimeAccum;
    int m_profCounter;
    float m_profWorstAccum;

    float m_profilerFPS;
    float m_profilerFrameTime;
    float m_profilerWorstFrameTime;

    static dwRoot * m_singleton;
    DWSoundSystem * m_soundSystem;
};

#endif // DWROOT_H
