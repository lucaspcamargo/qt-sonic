#ifndef NSOUNDSTREAMER_H
#define NSOUNDSTREAMER_H

#include <QObject>

#include "nSoundFormat.h"

class nSoundSystem;
class nSoundSource;
class nSoundBag;
class nSoundStream;
class nSoundStreamerPlaylist;

class nSoundStreamer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(nSoundSource* source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(nSoundStreamerPlaylist* playlist READ playlist WRITE setPlaylist NOTIFY playlistChanged)
public:
    explicit nSoundStreamer(QString name, nSoundSource * source,  nSoundStreamerPlaylist * playlist, nSoundSystem * parent);
    virtual ~nSoundStreamer();

    nSoundSource* source() const
    {
        return m_source;
    }

    nSoundStreamerPlaylist* playlist() const
    {
        return m_playlist;
    }

signals:


    void sourceChanged(nSoundSource* arg);

    void playlistChanged(nSoundStreamerPlaylist* arg);

public slots:
    void update(float);
    void rewind();

    void setSource(nSoundSource* arg)
    {
        if (m_source == arg)
            return;

        m_source = arg;
        emit sourceChanged(arg);
    }

    void setPlaylist(nSoundStreamerPlaylist* arg)
    {
        if (m_playlist == arg)
            return;

        m_playlist = arg;
        emit playlistChanged(arg);
    }

private:
    bool fillAndQueueBuffer(unsigned int buffer);
    int openalFormat(nSoundFormat format);

    nSoundStreamerPlaylist * m_playlist;
    int m_currentStream;

    nSoundSource * m_source;
    nSoundBag * m_bag;

    bool m_keepStreaming;
    unsigned int m_buffer0, m_buffer1, m_buffer2;
};
#endif // NSOUNDSTREAMER_H
