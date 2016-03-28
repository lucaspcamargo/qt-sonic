TEMPLATE = app

QT += qml quick network multimedia opengl
!android{ QT += widgets }

### BEGIN CONFIG


### END CONFIG

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
    src/dwtexture.cpp \
    src/dwcontrollerhub.cpp \
    src/dwcontrollerstate.cpp \
    src/dwsprite.cpp \
    src/dwspritesheet.cpp \
    src/dwspritesheetcache.cpp \
    src/fx/dwfxwater.cpp \
    src/dwanimationupdater.cpp

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
    src/dwplayerbase.h \
    src/dwutil.h \
    src/dwfieldbvh.h \
    src/dwfieldbvhnode.h \
    src/dwfieldobject.h \
    src/dwfophysicsbody.h \
    src/dwfieldphysicscontactlistener.h \
    src/dwimageitem.h \
    src/dwtexturecache.h \
    src/dwtexture.h \
    src/dwcontrollerhub.h \
    src/dwcontrollerstate.h \
    src/dwsprite.h \
    src/dwspritesheet.h \
    src/dwspritesheetcache.h \
    src/fx/dwfxwater.h \
    src/dwanimatable.h \
    src/dwanimationupdater.h

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml

RESOURCES += qml.qrc

### GENERAL

unix{
    CONFIG += link_pkgconfig
}

win32 {
    LIBS += -lopengl32
}


### LIQUIDFUN

    win32:INCLUDEPATH += $$PWD/../liquidfun/Box2D
    else:INCLUDEPATH += $$PWD/../liquidfun/liquidfun/Box2D
    DEPENDPATH += $$PWD/../liquidfun/liquidfun/Box2D

!android{
    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../liquidfun/Box2D/x64/Release/ -lliquidfun
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../liquidfun/Box2D/x64/Debug/ -lliquidfun
    else:unix: LIBS += -L$$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/ -lliquidfun

    unix: PRE_TARGETDEPS += $$PWD/../liquidfun/liquidfun/Box2D/Box2D/Release/libliquidfun.a
}

android {
    LIBS += $$PWD/../liquidfun/liquidfun/Box2D/obj/local/$${ANDROID_TARGET_ARCH}/libliquidfun_static.a
}

## OPENAL

    DEFINES+="NEIASOUND_STATIC=1"

    win32:INCLUDEPATH += $$PWD/../openal-soft/include/
    win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../openal-soft/build/Debug/ -lOpenAL32
    else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../openal-soft/build/Debug/ -lOpenAL32

!android {
    unix:LIBS += -lopenal
}

android {
    INCLUDEPATH += $$PWD/android/jni/include/
    LIBS += $$PWD/android/obj/local/$${ANDROID_TARGET_ARCH}/libOpenAL-MOB.a
    LIBS += -lOpenSLES
}


## SDL

win32{
    DEFINES+="DW_USE_SDL2=1"
    INCLUDEPATH += $$PWD/../sdl2/include/
    CONFIG(release, debug|release): LIBS += -L$$PWD/../sdl2/lib/x64/ -lSDL2
    else:CONFIG(debug, debug|release): LIBS += -L$$PWD/../sdl2/lib/x64/ -lSDL2
}

!android:unix{

    PKGCONFIG += sdl2
    DEFINES+="DW_USE_SDL2=1"
}


