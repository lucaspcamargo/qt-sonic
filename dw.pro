TEMPLATE = app

QT += qml quick network multimedia
!android{ QT += widgets }

SOURCES += \
    src/dwroot.cpp \
    src/dwfieldphysicsworld.cpp \
    src/dwtypes.cpp \
    src/dweveryframe.cpp \
    thirdparty/neiasound/src/nSoundBag.cpp \
    thirdparty/neiasound/src/nSoundBuffer.cpp \
    thirdparty/neiasound/src/nSoundEffectParameters.cpp \
    thirdparty/neiasound/src/nSoundListener.cpp \
    thirdparty/neiasound/src/nSoundSource.cpp \
    thirdparty/neiasound/src/nSoundStream.cpp \
    thirdparty/neiasound/src/nSoundStreamer.cpp \
    thirdparty/neiasound/src/nSoundStreamerPlaylist.cpp \
    thirdparty/neiasound/src/nSoundSystem.cpp \
    thirdparty/neiasound/src/util/nEfxHelper.cpp \
    thirdparty/neiasound/src/stb_vorbis/nvorbisstream.cpp \
    thirdparty/neiasound/src/wav/nwavestream.cpp \
    src/dwsoundsystem.cpp \
    src/dwcomponentcache.cpp \
    src/dwplayerbase.cpp \
    src/dwutil.cpp \
    src/dwfieldbvh.cpp \
    src/dwfieldbvhnode.cpp \
    src/dwfieldobject.cpp \
    src/dwfophysicsbody.cpp \
    src/dwfieldphysicscontactlistener.cpp \
    src/dwmain.cpp




# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/dwroot.h \
    src/dwfieldphysicsworld.h \
    src/dwtypes.h \
    src/dweveryframe.h \
    thirdparty/neiasound/src/nSoundBag.h \
    thirdparty/neiasound/src/nSoundBuffer.h \
    thirdparty/neiasound/src/nSoundEffectParameters.h \
    thirdparty/neiasound/src/nSoundFormat.h \
    thirdparty/neiasound/src/nSoundListener.h \
    thirdparty/neiasound/src/nSoundSource.h \
    thirdparty/neiasound/src/nSoundSourceRole.h \
    thirdparty/neiasound/src/nSoundStream.h \
    thirdparty/neiasound/src/nSoundStreamer.h \
    thirdparty/neiasound/src/nSoundStreamerPlaylist.h \
    thirdparty/neiasound/src/nSoundSystem.h \
    thirdparty/neiasound/src/util/efx-util.h \
    thirdparty/neiasound/src/util/nEfxHelper.h \
    thirdparty/neiasound/src/stb_vorbis/nvorbisstream.h \
    thirdparty/neiasound/src/wav/nwavestream.h \
    src/dwsoundsystem.h \
    src/dwcomponentcache.h \
    src/dwplayerbase.h \
    src/dwutil.h \
    src/dwfieldbvh.h \
    src/dwfieldbvhnode.h \
    src/dwfieldobject.h \
    src/dwfophysicsbody.h \
    src/dwfieldphysicscontactlistener.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

RESOURCES += qml.qrc

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
    qml/glsl/phosphorish_fp.glsl


