TEMPLATE = app

QT += qml quick network multimedia
!android{ QT += widgets }

SOURCES += \
    src/dwroot.cpp \
    src/dwfieldphysicsworld.cpp \
    src/dwtypes.cpp \
    src/dweveryframe.cpp \
    thirdparty/neiasound/src/nsoundbag.cpp \
    thirdparty/neiasound/src/nsoundbuffer.cpp \
    thirdparty/neiasound/src/nsoundeffectparameters.cpp \
    thirdparty/neiasound/src/nsoundfilter.cpp \
    thirdparty/neiasound/src/nsoundlistener.cpp \
    thirdparty/neiasound/src/nsoundsource.cpp \
    thirdparty/neiasound/src/nsoundstream.cpp \
    thirdparty/neiasound/src/nsoundstreamer.cpp \
    thirdparty/neiasound/src/nsoundstreamerplaylist.cpp \
    thirdparty/neiasound/src/nsoundsystem.cpp \
    thirdparty/neiasound/src/util/nefxhelper.cpp \
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
    src/dwmain.cpp \
    src/dwimageitem.cpp \
    src/dwtexturecache.cpp \
    src/dwtexture.cpp




# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/dwroot.h \
    src/dwfieldphysicsworld.h \
    src/dwtypes.h \
    src/dweveryframe.h \
    thirdparty/neiasound/src/nsoundbag.h \
    thirdparty/neiasound/src/nsoundbuffer.h \
    thirdparty/neiasound/src/nsoundeffectparameters.h \
    thirdparty/neiasound/src/nsoundfilter.h \
    thirdparty/neiasound/src/nsoundformat.h \
    thirdparty/neiasound/src/nsoundlistener.h \
    thirdparty/neiasound/src/nsoundsource.h \
    thirdparty/neiasound/src/nsoundstream.h \
    thirdparty/neiasound/src/nsoundstreamer.h \
    thirdparty/neiasound/src/nsoundstreamerplaylist.h \
    thirdparty/neiasound/src/nsoundsystem.h \
    thirdparty/neiasound/src/util/efx-util.h \
    thirdparty/neiasound/src/util/nefxhelper.h \
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
    src/dwfieldphysicscontactlistener.h \
    src/dwimageitem.h \
    src/dwtexturecache.h \
    src/dwtexture.h

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
    else:unix: LIBS += -L$$PWD/../liquidfun/liquidfun/Box2D/build.local/Box2D/Release/ -lliquidfun

    win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/release/libliquidfun.a
    else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/debug/libliquidfun.a
    else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/release/liquidfun.lib
    else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/debug/liquidfun.lib
    else:unix: PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/build.local/Box2D/Release/libliquidfun.a
}

android {
    LIBS += $$PWD/../liquidfun/liquidfun/Box2D/obj/local/$${ANDROID_TARGET_ARCH}/libliquidfun_static.a
}

## OPENAL
!android {
#unix: CONFIG += link_pkgconfig
#unix: PKGCONFIG += openal
LIBS += -lopenal
}

android {
    INCLUDEPATH += $$PWD/android/jni/include
    LIBS += $$PWD/android/obj/local/$${ANDROID_TARGET_ARCH}/libOpenAL-MOB.a
    LIBS += -lOpenSLES
}

DISTFILES +=


