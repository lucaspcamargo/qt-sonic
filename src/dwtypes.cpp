#include "dwtypes.h"
#include <QtQml>

#include "dwanimationupdater.h"
#include "dweveryframe.h"
#include "dwcontrollerhub.h"
#include "dwcontrollerstate.h"
#include "dwimageitem.h"
#include "dwfieldbvh.h"
#include "dwfieldbvhnode.h"
#include "dwfieldobject.h"
#include "dwfophysicsbody.h"
#include "dwfieldphysicsworld.h"
#include "dwsprite.h"
#include "dwplayerbase.h"
#include "dwutil.h"

#include "fx/dwfxwater.h"

#include "dwsoundsystem.h"
#include "../thirdparty/neiasound/src/nsoundbag.h"
#include "../thirdparty/neiasound/src/nsoundbuffer.h"
#include "../thirdparty/neiasound/src/nsoundlistener.h"
#include "../thirdparty/neiasound/src/nsoundsource.h"
#include "../thirdparty/neiasound/src/nsoundstream.h"
#include "../thirdparty/neiasound/src/nsoundstreamer.h"
#include "../thirdparty/neiasound/src/nsoundstreamerplaylist.h"

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
    qmlRegisterType<dwControllerHub>(PACKAGE_VERSION "DWControllerHub");
    qmlRegisterType<dwControllerState>(PACKAGE_VERSION "DWControllerState");
    qmlRegisterType<dwEveryFrame>(PACKAGE_VERSION "DWEveryFrame");
    qmlRegisterType<dwImageItem>(PACKAGE_VERSION "DWImageItem");
    qmlRegisterType<dwFieldBVH>(PACKAGE_VERSION "DWFieldBVH");
    qmlRegisterType<dwFieldObject>(PACKAGE_VERSION "DWFieldObject");
    qmlRegisterType<dwFOPhysicsBody>(PACKAGE_VERSION "DWFOPhysicsBody");
    qmlRegisterType<dwFieldPhysicsWorld>(PACKAGE_VERSION "DWFieldPhysicsWorld");
    qmlRegisterType<dwSprite>(PACKAGE_VERSION "DWSprite");
    qmlRegisterType<dwPlayerBase>(PACKAGE_VERSION "DWPlayerBase");

    qmlRegisterType<dwFxWater>(PACKAGE_VERSION "DWFxWater");

    // SINGLETONS
    qmlRegisterSingletonType<dwUtil>( PACKAGE_VERSION "DWUtil", dwutil_singletontype_provider);

    // NON-INSTANTIABLE TYPES
    qmlRegisterUncreatableType<dwAnimationUpdater>( PACKAGE_VERSION "DWAnimationUpdater", QStringLiteral("") );
    qmlRegisterUncreatableType<dwFieldBVHNode>( PACKAGE_VERSION "DWFieldBVHNode", QStringLiteral("") );

    // SOUND STUFF
    qmlRegisterUncreatableType<dwSoundSystem>( PACKAGE_VERSION "DWSoundSystem", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundSystem>( PACKAGE_VERSION "NSoundSystem", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundBag>( PACKAGE_VERSION "NSoundBag", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundBuffer>( PACKAGE_VERSION "NSoundBuffer", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundListener>( PACKAGE_VERSION "NSoundListener", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundSource>( PACKAGE_VERSION "NSoundSource", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundStream>( PACKAGE_VERSION "NSoundStream", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundStreamer>( PACKAGE_VERSION "NSoundStreamer", QStringLiteral("") );
    qmlRegisterUncreatableType<nSoundStreamerPlaylist>( PACKAGE_VERSION "NSoundStreamerPlaylist", QStringLiteral("") );

#undef PACKAGE_VERSION

}
