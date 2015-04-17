#include "dwutil.h"


#include <QImage>
#include <QFile>


dwUtil::dwUtil(QObject *parent) :
    QObject(parent)
{
}

void dwUtil::reparent(QObject *child, QObject *parent)
{
    child->setParent(parent);
}

#include "dwroot.h"
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QScopedPointer>
#include <QTextStream>

QString dwUtil::readTextFile(QUrl url)
{
    QQmlApplicationEngine * engine = dwRoot::singleton()->appEngine();
    QNetworkAccessManager * manager = engine->networkAccessManager();
    QNetworkReply * reply = manager->get(QNetworkRequest(url));
    QScopedPointer<QNetworkReply> replyPtr(reply);
    QTextStream stream(reply);
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

