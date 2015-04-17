#include "dwtypes.h"
#include <QtQml>

#include "dweveryframe.h"
#include "dwfieldbvh.h"
#include "dwfieldbvhnode.h"
#include "dwfieldobject.h"
#include "dwfieldphysicsworld.h"
#include "dwcomponentcache.h"
#include "dwplayerbase.h"
#include "dwutil.h"

#include "sound/dwsoundsystem.h"
#include "sound/nSoundBag.h"
#include "sound/nSoundBuffer.h"
#include "sound/nSoundListener.h"
#include "sound/nSoundSource.h"
#include "sound/nSoundStream.h"
#include "sound/nSoundStreamer.h"

static QObject *dwutil_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    dwUtil *util= new dwUtil();
    return util;
}


void dwTypes::registerTypes()
{

#define PACKAGE_VERSION "dw", 1, 0,

    // INSTANTIABLE TYPES
    qmlRegisterType<dwEveryFrame>(PACKAGE_VERSION "DWEveryFrame");
    qmlRegisterType<dwFieldBVH>(PACKAGE_VERSION "DWFieldBVH");
    qmlRegisterType<dwFieldObject>(PACKAGE_VERSION "DWFieldObject");
    qmlRegisterType<dwFieldPhysicsWorld>(PACKAGE_VERSION "DWFieldPhysicsWorld");
    qmlRegisterType<dwComponentCache>(PACKAGE_VERSION "DWComponentCache");
    qmlRegisterType<dwPlayerBase>(PACKAGE_VERSION "DWPlayerBase");


    // SINGLETONS
    qmlRegisterSingletonType<dwUtil>( PACKAGE_VERSION "DWUtil", dwutil_singletontype_provider);

    // NON-INSTANTIABLE TYPES
    qmlRegisterUncreatableType<dwFieldBVHNode>( PACKAGE_VERSION "DWFieldBVHNode", QStringLiteral("") );

    qmlRegisterUncreatableType<DWSoundSystem>( PACKAGE_VERSION "DWSoundSystem", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundSystem>( PACKAGE_VERSION "NSoundSystem", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundBag>( PACKAGE_VERSION "NSoundBag", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundBuffer>( PACKAGE_VERSION "NSoundBuffer", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundListener>( PACKAGE_VERSION "NSoundListener", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundSource>( PACKAGE_VERSION "NSoundSource", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundStream>( PACKAGE_VERSION "NSoundStream", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundStreamer>( PACKAGE_VERSION "NSoundStreamer", QStringLiteral("") );
}
