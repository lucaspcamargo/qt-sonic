#ifndef NSOUNDSTREAMTHREADWRAPPER_H
#define NSOUNDSTREAMTHREADWRAPPER_H

#include "../nSoundStream.h"
#include <QObject>
#include <QContiguousCache>
#include <QMutex>
/*
class nSoundStreamThreadWrapper : public nSoundStream
{
    Q_OBJECT

public:
    nSoundStreamThreadWrapper(nSoundStream * stream, QObject* p = 0);
    ~nSoundStreamThreadWrapper();

public slots:
    virtual quint64 frames() { return _stream->frames(); }
    virtual int channels() { return _stream->channels(); }
    virtual int frequency() { return _stream->frequency(); }

    virtual nSoundBag * createSoundBag(QObject * parent = 0) { return _stream->createSoundBag(parent); }

    virtual nSoundFormat format() { return _stream->format(); }
    virtual bool suggestStreaming() { return _stream->suggestStreaming(); }

    virtual quint64 read(void* data, unsigned long frames);

    virtual void rewind();

private:
    //QContiguousCache * _data;
    QMutex _dataMutex;
    nSoundStream * _stream;
};
*/
#endif // NSOUNDSTREAMTHREADWRAPPER_H
