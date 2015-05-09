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

#include "qt/qtaudiostream.h"

nSoundStream* DWSoundSystem::createStreamUrl(QUrl url, QObject *parentObj)
{

    nSoundStream * stream;
    QIODevice * device;

    if(!url.toLocalFile().isEmpty())
    {
        QFile * file = new QFile(url.toLocalFile());
        file->open(QIODevice::ReadOnly);
        device = file;

    }else
    {
        QNetworkAccessManager * manager = dwRoot::singleton()->appEngine()->networkAccessManager();
        QNetworkReply * reply = manager->get(QNetworkRequest(url));      
        device = reply;
    }

    if(url.toString().endsWith(".ogg"))
        stream = new nVorbisStream(device, parentObj);
    else
        stream = new nWaveStream (device, SF_WAVE_HEADER, -1, -1, parentObj);

    device->setParent(stream);

    return stream;

}

void DWSoundSystem::fillBuffer(nSoundBuffer *buf, QUrl url)
{

    nSoundStream * stream = createStreamUrl(url, 0);

    if(stream)
    {
        buf->setData(stream);

        delete stream;
    }
}
