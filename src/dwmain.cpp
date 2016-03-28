#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>

#include "dwroot.h"
#include "dwtypes.h"

#ifdef QT_DEBUG
#include <fenv.h>
#endif

#include <QDebug>

int main(int argc, char *argv[])
{
    dwTypes::registerTypes();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine * applicationEngine = new QQmlApplicationEngine();

#ifdef QT_DEBUG
    const bool isDebug = true;
#else
    const bool isDebug = false;
#endif
    QString buildDate = QString::fromLocal8Bit(__DATE__);

    applicationEngine->rootContext()->setContextProperty("globalDebug", QVariant(isDebug));
    applicationEngine->rootContext()->setContextProperty("globalBuildDate", QVariant(buildDate));

    dwRoot * root = new dwRoot(applicationEngine);


    QUrl resourceBase =

#ifdef ANDROID
                                    QUrl("assets:/dw/");
#else
                                    QUrl::fromLocalFile( QDir::currentPath() + QStringLiteral("/assets/") );
#endif
    qDebug() << "[main] resource base is " << resourceBase.toString();
    applicationEngine->rootContext()->setContextProperty("resBase", resourceBase);

    applicationEngine->load(QUrl("qrc:/core/qml/DWMainWindow.qml"));

    root->onLoaded();

    int ret = app.exec();

    delete applicationEngine;
    //delete root; application engine deletes root somewhat

    return ret;
}
