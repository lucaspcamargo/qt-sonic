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

#include "util/dwsoundrawstream.h"
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
        dwSoundRawStream stream(&file, SF_WAVE_HEADER, -1, -1, this);
        buf->setData(&stream);
    }else
    {
        QNetworkAccessManager * manager = dwRoot::singleton()->appEngine()->networkAccessManager();
        QNetworkReply * reply = manager->get(QNetworkRequest(url));
        dwSoundRawStream stream(reply, SF_WAVE_HEADER, -1, -1, this);
        buf->setData(&stream);
        delete reply;
    }
}
