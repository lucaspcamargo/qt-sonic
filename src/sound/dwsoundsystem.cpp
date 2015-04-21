#include "dwsoundsystem.h"
#include "nSoundSystem.h"
#include "nSoundStream.h"
#include "nSoundBuffer.h"
#include "nSoundListener.h"
#include "../dwroot.h"

#include "wav/nwavestream.h"
#include "stb_vorbis/nvorbisstream.h"
#include <QFile>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

DWSoundSystem::DWSoundSystem(QObject *parent) :
    nSoundSystem(parent)
{
    listener()->updateManual(QVector3D(0,0,0), QVector3D(0,0,-1), QVector3D(0,1,0), QVector3D(0,0,0));
    listener();
    connect(dwRoot::singleton(), &dwRoot::preUpdate, this, &DWSoundSystem::update);
}

nSoundStream* DWSoundSystem::createStreamUrl(QUrl url, QObject *parentObj)
{
    nSoundStream * stream;

    if(!url.toLocalFile().isEmpty())
    {
        QFile * file = new QFile(url.toLocalFile());
        file->open(QIODevice::ReadOnly);

        if(file->fileName().endsWith(".ogg"))
            stream = new nVorbisStream(file, this);
        else
            stream = new nWaveStream (file, SF_WAVE_HEADER, -1, -1, this);

        file->setParent(stream);
    }else
    {
        QNetworkAccessManager * manager = dwRoot::singleton()->appEngine()->networkAccessManager();
        QNetworkReply * reply = manager->get(QNetworkRequest(url));

        nSoundStream * stream;

        if(url.toString().endsWith(".ogg"))
            stream = new nVorbisStream(reply, this);
        else
            stream = new nWaveStream (reply, SF_WAVE_HEADER, -1, -1, this);

        reply->setParent(stream);
    }

    stream->setParent(parentObj);

    return stream;
}

void DWSoundSystem::fillBuffer(nSoundBuffer *buf, QUrl url)
{
    nSoundStream * stream = createStreamUrl(url, 0);
    buf->setData(stream);
    delete stream;
}
