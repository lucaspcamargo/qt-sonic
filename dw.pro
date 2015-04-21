TEMPLATE = app

QT += qml quick widgets network multimedia

SOURCES += \
    src/dwroot.cpp \
    src/main.cpp \
    src/dwfieldphysicsworld.cpp \
    src/dwtypes.cpp \
    src/dweveryframe.cpp \
    src/sound/nSoundBag.cpp \
    src/sound/nSoundBuffer.cpp \
    src/sound/nSoundEffectParameters.cpp \
    src/sound/nSoundListener.cpp \
    src/sound/nSoundScriptMetatypes.cpp \
    src/sound/nSoundSource.cpp \
    src/sound/nSoundStream.cpp \
    src/sound/nSoundStreamer.cpp \
    src/sound/nSoundStreamerPlaylist.cpp \
    src/sound/nSoundSystem.cpp \
    src/sound/util/nEfxHelper.cpp \
    src/sound/dwsoundsystem.cpp \
    src/dwcomponentcache.cpp \
    src/dwplayerbase.cpp \
    src/dwutil.cpp \
    src/dwfieldbvh.cpp \
    src/dwfieldbvhnode.cpp \
    src/dwfieldobject.cpp \
    src/dwfophysicsbody.cpp \
    src/dwfieldphysicscontactlistener.cpp \
    src/sound/stb_vorbis/nvorbisstream.cpp \
    src/sound/wav/nwavestream.cpp

RESOURCES +=

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/dwroot.h \
    src/dwfieldphysicsworld.h \
    src/dwtypes.h \
    src/dweveryframe.h \
    src/sound/nSoundBag.h \
    src/sound/nSoundBuffer.h \
    src/sound/nSoundEffectParameters.h \
    src/sound/nSoundFormat.h \
    src/sound/nSoundListener.h \
    src/sound/nSoundScriptMetatypes.h \
    src/sound/nSoundSource.h \
    src/sound/nSoundSourceRole.h \
    src/sound/nSoundStream.h \
    src/sound/nSoundStreamer.h \
    src/sound/nSoundStreamerPlaylist.h \
    src/sound/nSoundSystem.h \
    src/sound/util/efx-util.h \
    src/sound/util/nEfxHelper.h \
    src/sound/dwsoundsystem.h \
    src/dwcomponentcache.h \
    src/dwplayerbase.h \
    src/dwutil.h \
    src/dwfieldbvh.h \
    src/dwfieldbvhnode.h \
    src/dwfieldobject.h \
    src/dwfophysicsbody.h \
    src/dwfieldphysicscontactlistener.h \
    src/sound/stb_vorbis/nvorbisstream.h \
    src/sound/wav/nwavestream.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml


### LIQUIDFUN

    INCLUDEPATH += $$PWD/../liquidfun/liquidfun/Box2D
    DEPENDPATH += $$PWD/../liquidfun/liquidfun/Box2D

!android{
    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/release/ -lliquidfun
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/debug/ -lliquidfun
    else:unix: LIBS += -L$$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/ -lliquidfun

    win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/release/libliquidfun.a
    else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/debug/libliquidfun.a
    else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/release/liquidfun.lib
    else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/debug/liquidfun.lib
    else:unix: PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/libliquidfun.a
}


android {
    LIBS += $$PWD/../liquidfun/liquidfun/Box2D/obj/local/armeabi-v7a/libliquidfun_static.a
}


## OPENAL
!android {
unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += openal
}

android {
    INCLUDEPATH += $$PWD/android/jni/include
    LIBS += $$PWD/android/obj/local/armeabi/libOpenAL-MOB.a
    LIBS += -lOpenSLES
}

DISTFILES += \
    assets/*.qml \
    assets/obj/*.qml \
    assets/obj/player/*.qml \
    assets/field/*.qml \
    assets/field/water-perspective/*.glsl \
    assets/ss/*.qml \
    assets/etc/*.qml \
    assets/mm/*.qml \
    assets/mm/*.json \
    assets/oz/*.qml \
    assets/oz/*.json \
    assets/mm/obj/*.qml \
    assets/tools/*.qml \
    assets/tools/editor/*.qml \
    assets/ui/DWMainMenu.qml \
    assets/DWMainScreen.qml \
    assets/DWGlobalResources.qml \
    assets/ui/DWConfigScreen.qml \
    assets/ui/DWUIButtonInstruction.qml \
    assets/ui/DWUIScreenTemplate.qml \
    assets/ui/DWUIButton.qml \
    assets/ui/DWExtrasScreen.qml \
    assets/ui/DWUICSetting.qml \
    assets/ui/DWTitleScreen.qml \
    assets/obj/ObjMovingPlatformBase.qml \
    assets/obj/ObjMovingPlatform.qml \
    assets/obj/ObjHarmfulBase.qml \
    assets/obj/ObjBox.qml \
    assets/obj/ObjGib.qml


