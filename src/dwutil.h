#ifndef DWUTIL_H
#define DWUTIL_H

#include <QObject>
#include <QVariantList>
#include <QUrl>

class QIODevice;

class dwUtil : public QObject
{
    Q_OBJECT
public:
    explicit dwUtil(QObject *parent = 0);

    inline static dwUtil * singleton(){ return ms_singleton; }

signals:

public slots:
    void reparent(QObject * child, QObject * parent);

    QIODevice * getDeviceFromUrl(QUrl url);
    QString readTextFile(QUrl url);

    void putImageDataPixel( int r, int g, int b, int a );
    void saveImageData(QUrl location, int w, int h );

private:
    QList<int> m_imageData;

    static dwUtil *ms_singleton;

};

#endif // DWUTIL_H
