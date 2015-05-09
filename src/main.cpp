#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "dwroot.h"
#include "dwtypes.h"

#ifdef QT_DEBUG
#include <fenv.h>
#endif

int main(int argc, char *argv[])
{
    dwTypes::registerTypes();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine applicationEngine;

#ifdef QT_DEBUG
    const bool isDebug = true;
#else
    const bool isDebug = false;
#endif
    QString buildDate = QString::fromLocal8Bit(__DATE__);

    applicationEngine.rootContext()->setContextProperty("globalDebug", QVariant(isDebug));
    applicationEngine.rootContext()->setContextProperty("globalBuildDate", QVariant(buildDate));

    dwRoot root(&applicationEngine);


    QString resourceBase =

#ifdef ANDROID
                                    "assets:/dw";
#else
                                    "assets";
#endif

    applicationEngine.rootContext()->setContextProperty("resBase", QUrl(resourceBase + "/"));


    applicationEngine.load(QUrl(resourceBase + "/DWMainWindow.qml"));

    root.onLoaded();

    return app.exec();
}
