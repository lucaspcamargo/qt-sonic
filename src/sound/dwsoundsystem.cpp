#include "dwsoundsystem.h"
#include "nSoundSystem.h"
#include "nSoundBuffer.h"
#include "nSoundListener.h"
#include "../dwroot.h"

DWSoundSystem::DWSoundSystem(QObject *parent) :
    nSoundSystem(parent)
{
    listener()->updateManual(QVector3D(0,0,0), QVector3D(0,0,-1), QVector3D(0,1,0), QVector3D(0,0,0));
    listener();
    connect(dwRoot::singleton(), &dwRoot::update, this, &DWSoundSystem::update);
}

#include "wav/nwavestream.h"
#include "stb_vorbis/nvorbisstream.h"
#include <QFile>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
void DWSoundSystem::fillBuffer(nSoundBuffer *buf, QUrl url)
{
    if(!url.toLocalFile().isEmpty())
    {
        QFile file(url.toLocalFile());
        file.open(QIODevice::ReadOnly);

        nSoundStream * stream;

        if(file.fileName().endsWith(".ogg"))
            stream = new nVorbisStream(&file, this);
        else
            stream = new nWaveStream (&file, SF_WAVE_HEADER, -1, -1, this);

        buf->setData(stream);
        delete stream;
    }else
    {
        QNetworkAccessManager * manager = dwRoot::singleton()->appEngine()->networkAccessManager();
        QNetworkReply * reply = manager->get(QNetworkRequest(url));

        nSoundStream * stream;

        if(url.toString().endsWith(".ogg"))
            stream = new nVorbisStream(reply, this);
        else
            stream = new nWaveStream (reply, SF_WAVE_HEADER, -1, -1, this);

        buf->setData(stream);
        delete reply;
    }
}
