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
public:
    explicit nSoundStreamer(QString name, nSoundSource * source,  nSoundStreamerPlaylist * playlist, nSoundSystem * parent);
    virtual ~nSoundStreamer();

signals:


public slots:
    void update(float);

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
