#ifndef DWSOUNDSYSTEM_H
#define DWSOUNDSYSTEM_H

#include "../thirdparty/neiasound/src/nsoundsystem.h"
#include <QUrl>

class nSoundStream;

class dwSoundSystem : public nSoundSystem
{
    Q_OBJECT
public:
    explicit dwSoundSystem(QObject *parent = 0);

signals:

public slots:

    nSoundStream * createStreamUrl(QUrl stream, QObject * parent);
    void fillBuffer(nSoundBuffer * buf, QUrl url);

private:
};

#endif // DWSOUNDSYSTEM_H
