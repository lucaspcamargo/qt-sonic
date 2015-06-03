import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import dw 1.0

Window {
    id: rootWindow

    title: "dw"

    visible: true
    visibility: _DW_MOBILE? Window.FullScreen : Window.Windowed
    color: "black"

    width: 854
    height: 480

    //flags: Qt.FramelessWindowHint

    property alias cursorShape: cursorSetter.cursorShape

    MouseArea
    {
        id: cursorSetter
        anchors.fill: parent
        cursorShape: Qt.BlankCursor

        onDoubleClicked: backgroundPressed()
    }

    Item
    {
        id: container
        anchors.fill: parent
        focus: true

        Loader{
            id: mainContentLoader

            height: 240
            scale: parent.height / height
            width: Math.ceil(height * parent.width/parent.height)
            anchors.centerIn: parent

            active: false
            source: (!_DW_MOBILE)? "dev/DWDevMenu.qml" : "ui/DWIntroSequence.qml"
        }

        Keys.onDigit1Pressed: renderSampleSharp = !renderSampleSharp
        Keys.onDigit2Pressed: renderSuper2xSai = !renderSuper2xSai
        Keys.onDigit3Pressed: renderScanlines = !renderScanlines
        Keys.onDigit4Pressed: offscreen = !offscreen
        Keys.onDigit9Pressed: mainContentLoader.source = Qt.resolvedUrl("ui/DWIntroSequence.qml")
        Keys.onDigit0Pressed: mainContentLoader.source = Qt.resolvedUrl("dev/DWDevMenu.qml")
        Keys.onPressed:
        {
            if(event.key == Qt.Key_F1) _DW_DEBUG = !_DW_DEBUG;
            else if(event.key == Qt.Key_F2) _DW_DEBUG_FIELD_INFO = !_DW_DEBUG_FIELD_INFO;
            else if(event.key == Qt.Key_F3) _DW_DEBUG_PHYSICS_DRAW = !_DW_DEBUG_PHYSICS_DRAW;
            else if(event.key == Qt.Key_F4) _DW_DEBUG_BVH_DRAW = !_DW_DEBUG_BVH_DRAW;
            else if(event.key == Qt.Key_F10)
            {
                if(toolTilesetGenerator)toolTilesetGenerator.visible = !toolTilesetGenerator.visible;
                else
                {
                    var c = Qt.createComponent("tools/DWPalettedTilesetGenerator.qml");
                    toolTilesetGenerator = c.createObject(null);
                }
            }
            else if(event.key == Qt.Key_M) DWRoot.soundSystem.masterGain = 1 - DWRoot.soundSystem.masterGain;
        }
    }

    property var toolTilesetGenerator: null

    property bool _DW_MOBILE: Qt.platform.os == "android"
    // set by main
    property bool _DW_DEBUG: globalDebug //Qt.platform.os != "android"

    property bool _DW_DEBUG_FIELD_INFO: false
    property bool _DW_DEBUG_PHYSICS_DRAW: false
    property bool _DW_DEBUG_BVH_DRAW: false
    signal logoPressed()
    signal backgroundPressed()

    property bool offscreen: false
    property bool renderSampleSharp: !(renderSuper2xSai)
    property bool renderSuper2xSai: Qt.platform.os != "android"
    property bool renderScanlines: true


    ShaderEffectSource
    {
        id: videoSource
        sourceItem: offscreen? mainContentLoader : null
        hideSource: true
        smooth: renderSuper2xSai? false : !renderSampleSharp
        textureSize: mainContentLoader.width + "x" + mainContentLoader.height

    }
    ShaderEffect
    {
        id: super2XSai
        property variant decal: videoSource
        property vector2d texture_size: Qt.vector2d(mainContentLoader.width, mainContentLoader.height)
        visible: offscreen && renderSuper2xSai
        blending: false

        opacity: 1.0

        width: 2 * mainContentLoader.width
        height: 2 * mainContentLoader.height

        vertexShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/2xsai_vp.glsl"))
        fragmentShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/2xsai_"+(renderScanlines? "scanlines_": "")+"fp.glsl"))
    }

    ShaderEffectSource
    {
        id: super2XSaiSource
        sourceItem: offscreen && renderSuper2xSai? super2XSai : null
        hideSource: true
        smooth: !renderSampleSharp
    }

    ShaderEffect
    {
        id: screenRenderer
        anchors.fill: parent
        visible: offscreen
        blending: false

        property var src: renderSuper2xSai? super2XSaiSource : videoSource
        property bool waterEnabled: false
        property real waterLevel: 1.0
        property color waterColor: "white"
        property real time: 0
        property real waveYDelta: 0
        property real invScreenWidth: 1.5 / mainContentLoader.width
        vertexShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_vp.glsl"))

        fragmentShader: waterEnabled? DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_water_fp.glsl")) :
                                      DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_fp.glsl"))
    }

    //    Colorize
    //    {
    //        source: screenRenderer
    //        anchors.fill: screenRenderer

    //        NumberAnimation on hue { running: true; loops: Animation.Infinite; from: 0; to: 1; }

    //        saturation: 1


    //    }

    Image {
        id: dwLogo
        visible: false

        opacity: 0.4

        source: "ui/icon.png"
        width: sourceSize.width * parent.height/1500
        height: sourceSize.height * parent.height/1500
        anchors.top: parent.top
        anchors.topMargin: width / 2
        anchors.right: parent.right
        anchors.rightMargin: anchors.topMargin


        MouseArea
        {
            scale: 2
            anchors.fill: parent
            onClicked: rootWindow.logoPressed()
            onDoubleClicked: {

                var devMenu = Qt.resolvedUrl("dev/DWDevMenu.qml");

                if(mainContentLoader.source != devMenu)
                    mainContentLoader.source = devMenu;
                else
                    Qt.quit();
            }
        }
    }

    Item
    {
        id: globalFader
        opacity: 1
        anchors.fill: parent

        property bool light: false

        Behavior on opacity { NumberAnimation{duration: globalFader.light? 200 : 500}}

        onOpacityChanged: visible = !opacity == 0;

        Rectangle
        {
            anchors.fill: parent
            color: globalFader.light? "yellow" : "darkblue"
        }

        Rectangle
        {
            anchors.fill: parent
            color: globalFader.light? "white" : "black"
        }
    }


    Timer
    {
        id: loadTriggerTimer
        interval: 16
        running: true
        repeat: false
        onTriggered: {console.log("Loading main screen"); mainContentLoader.active = true;}
    }

    Rectangle {
        id: animationEnforcer
        width: 10
        height: 1
        color: "red"
        visible: false
        NumberAnimation on y {
            from: 0
            to: 10
            duration: 50
            loops: Animation.Infinite
        }
    }

    DWGlobalResources
    {
        id: globalResources
    }

    Text
    {
        id: fpsCounter
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        font.family: "monospace"; font.weight: Font.Bold
        text: visible? DWRoot.profilerFPS.toFixed(2) : ""
        visible: _DW_DEBUG
        color: "white"
        style: Text.Outline
        styleColor: "black"

        font.pixelSize: 16
    }

    Text
    {
        id: worstFpsCounter
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        anchors.bottomMargin: 40
        font.family: "monospace"; font.weight: Font.Bold
        color: (visible && DWRoot.profilerWorstFrameTime > 0.010)? "#ff8033" : "#ffff33"
        text: visible? (DWRoot.profilerWorstFrameTime * 1000).toFixed(2) : ""
        visible: _DW_DEBUG
        style: Text.Outline
        styleColor: "black"

        font.pixelSize: 16
    }

    Text
    {
        id: frameTimeCounter
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20
        anchors.bottomMargin: 60
        font.family: "monospace"; font.weight: Font.Bold;
        text: visible? (DWRoot.profilerFrameTime * 1000).toFixed(2) : ""
        visible: _DW_DEBUG
        color: "white"
        style: Text.Outline
        styleColor: "black"

        font.pixelSize: 16
    }
}
