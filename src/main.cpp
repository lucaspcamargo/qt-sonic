#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "dwroot.h"
#include "dwtypes.h"

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

    applicationEngine.rootContext()->setContextProperty("globalDebug", isDebug);

    dwRoot root(&applicationEngine);


    QString resourceBase =

#ifdef ANDROID
                                    "assets:/dw";
#else
                                    "assets";
#endif


    applicationEngine.load(QUrl(resourceBase + "/main.qml"));

    root.onLoaded();

    return app.exec();
}
