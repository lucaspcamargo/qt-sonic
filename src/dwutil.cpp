#include "dwutil.h"


#include <QImage>
#include <QFile>

dwUtil * dwUtil::ms_singleton = 0;

dwUtil::dwUtil(QObject *parent) :
    QObject(parent)
{
    ms_singleton = this;
}

void dwUtil::reparent(QObject *child, QObject *parent)
{
    child->setParent(parent);
}

#include "dwroot.h"
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkReply>

QIODevice *dwUtil::getDeviceFromUrl(QUrl url)
{
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

    return device;
}

#include <QScopedPointer>
#include <QTextStream>

QString dwUtil::readTextFile(QUrl url)
{
    QIODevice * dev = getDeviceFromUrl(url);
    QScopedPointer<QIODevice> devPtr(dev);
    QTextStream stream(dev);
    return stream.readAll();
}

void dwUtil::putImageDataPixel(int r, int g, int b, int a)
{
    m_imageData.append(r);
    m_imageData.append(g);
    m_imageData.append(b);
    m_imageData.append(a);
}

void dwUtil::saveImageData(QUrl location, int w, int h )
{
    unsigned char * data = new unsigned char[m_imageData.length()];
    for(int i = 0; i < m_imageData.length(); i++)
        data[i] = m_imageData[i];

    QImage image(data, w, h, QImage::Format_RGBA8888_Premultiplied);
    image.convertToFormat(QImage::Format_RGB888).save(location.toLocalFile(), "png");

    delete[] data;
    m_imageData.clear();
}

