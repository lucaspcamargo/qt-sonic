#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>

#include "dwroot.h"
#include "dwtypes.h"

#ifdef QT_QML_DEBUG
#include <QApplication>
#include <QMessageBox>
#include <unistd.h>
#endif

#ifdef QT_DEBUG
#include <fenv.h>
#endif

#include <QDebug>

// enable optimus! and the amd thinguie like optimus!
extern "C" {
    Q_DECL_EXPORT uint32_t NvOptimusEnablement = 0x00000001;
    Q_DECL_EXPORT int AmdPowerXpressRequestHighPerformance = 1;
}

int main(int argc, char *argv[])
{
    dwTypes::registerTypes();


#ifdef QT_QML_DEBUG
    QApplication
#else
    QGuiApplication
#endif
    app(argc, argv);

#ifdef QT_QML_DEBUG

    //QMessageBox::information(0, "PID", QString("I am %1").arg(getpid()), QMessageBox::Ok);

#endif

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
