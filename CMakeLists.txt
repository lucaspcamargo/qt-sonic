cmake_minimum_required(VERSION 2.8.12)
project( dw LANGUAGES CXX C ) 

option( DW_USE_SDL2 "Use SDL2 for joystick support" ON )




set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)



add_executable(${PROJECT_NAME} 
    src/dwroot.cpp 
    src/dwfieldphysicsworld.cpp 
    src/dwtypes.cpp 
    src/dweveryframe.cpp 
    thirdparty/neiasound/src/nsoundbag.cpp
    thirdparty/neiasound/src/nsoundbuffer.cpp 
    thirdparty/neiasound/src/nsoundeffectparameters.cpp 
    thirdparty/neiasound/src/nsoundfilter.cpp
    thirdparty/neiasound/src/nsoundlistener.cpp
    thirdparty/neiasound/src/nsoundsource.cpp
    thirdparty/neiasound/src/nsoundstream.cpp
    thirdparty/neiasound/src/nsoundstreamer.cpp
    thirdparty/neiasound/src/nsoundstreamerplaylist.cpp
    thirdparty/neiasound/src/nsoundsystem.cpp
    thirdparty/neiasound/src/util/nefxhelper.cpp
    thirdparty/neiasound/src/stb_vorbis/nvorbisstream.cpp
    thirdparty/neiasound/src/wav/nwavestream.cpp
    src/dwsoundsystem.cpp
    src/dwplayerbase.cpp
    src/dwutil.cpp
    src/dwfieldbvh.cpp
    src/dwfieldbvhnode.cpp
    src/dwfieldobject.cpp
    src/dwfophysicsbody.cpp
    src/dwfieldphysicscontactlistener.cpp
    src/dwmain.cpp
    src/dwimageitem.cpp
    src/dwtexturecache.cpp
    src/dwtexture.cpp
    src/dwcontrollerhub.cpp
    src/dwcontrollerstate.cpp
    src/dwsprite.cpp
    src/dwspritesheet.cpp
    src/dwspritesheetcache.cpp
    src/fx/dwfxwater.cpp
    src/dwanimationupdater.cpp
    
    qml.qrc
    )

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick box2d openal GL )

if(DW_USE_SDL2)
target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Quick box2d openal GL SDL2 )
    target_compile_definitions( ${PROJECT_NAME} PRIVATE DW_USE_SDL2=1 )
endif(DW_USE_SDL2)
