#ifndef DWSOUNDRAWSTREAM_H
#define DWSOUNDRAWSTREAM_H

#include "../nSoundStream.h"

class QIODevice;

class dwSoundRawStream : public nSoundStream
{
    Q_OBJECT
public:
    explicit dwSoundRawStream(QIODevice * device, nSoundFormat format, int frequency, int channels = -1, QObject *parent = 0);

signals:

public slots:
    virtual quint64 frames() { return _totalFrames; }
    virtual int channels() { return _channels; }
    virtual int frequency() { return _frequency; }

    virtual nSoundBag * createSoundBag(QObject * parent = 0);

    virtual nSoundFormat format() { return _format; }
    virtual bool suggestStreaming() { return false; }

    virtual void rewind();
    virtual quint64 read(void* data, unsigned long frames);

private:
    QIODevice * _device;
    int _deviceOffset;
    int _frequency;
    int _channels;
    nSoundFormat _format;
    quint64 _totalFrames;

};

#endif // DWSOUNDRAWSTREAM_H
