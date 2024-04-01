import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import dw 1.0

Window {
    id: rootWindow

    title: "qt-sonic"

    visible: true
    visibility: _DW_MOBILE? Window.FullScreen : Window.Windowed
    color: "black"

    width: 1280
    height: 720

    property alias cursorShape: cursorSetter.cursorShape

    Timer
    {
        id: updateTimer
        repeat: true
        running: false
        onTriggered: DWRoot.doFrameUpdate()
        interval: 1
    }


    MouseArea
    {
        id: cursorSetter
        anchors.fill: parent
        cursorShape: Qt.BlankCursor

        onDoubleClicked: {backgroundPressed();

            if(renderShaderIndex == (renderShaders.length - 1))
                renderShaderIndex = -1;
            else renderShaderIndex++;
        }
    }


    property bool _DW_MOBILE: Qt.platform.os == "android"

    property bool _DW_DEBUG: globalDebug // set by main
    property int _DW_FRAME_COUNT: 0

    // TODO fix case when a frame update does not make screen dirty
    onFrameSwapped: {_DW_FRAME_COUNT++;}// DWRoot.doFrameUpdate(); update();}

    property bool _DW_DEBUG_FIELD_INFO: false
    property bool _DW_DEBUG_PHYSICS_DRAW: false
    property bool _DW_DEBUG_BVH_DRAW: false

    Item
    {
        id: container
        anchors.fill: parent
        focus: true

        Loader{
            id: mainContentLoader

            anchors.fill: parent

            active: false
            source: "DWLevelScene.qml"//"dev/DWDevMenu.qml"
        }

        Keys.onDigit1Pressed: renderSampleSharp = !renderSampleSharp
        Keys.onDigit2Pressed: {
            if(renderShaderIndex == (renderShaders.length - 1))
                renderShaderIndex = -1;
            else renderShaderIndex++;
        }
        Keys.onDigit3Pressed: {}
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
            else if(event.key == Qt.Key_F11) rootWindow.visibility = (rootWindow.visibility == Window.Windowed? Window.FullScreen : Window.Windowed);
            else if(event.key == Qt.Key_M) DWRoot.soundSystem.masterGain = 1 - DWRoot.soundSystem.masterGain;
        }
    }


    DWGlobalResources
    {
        id: globalResources
    }

    DWControllerHub
    {
        id: controllerHub
    }

    property var toolTilesetGenerator: null

    signal logoPressed()
    signal backgroundPressed()

    property bool offscreen: false

    property var renderShaders:[ "hq2x", "SuperEagle", "Super2xSai", "5xBR", "Phosphorish", "CRTGeomInterlacedCurved", "Dot'n'Bloom", "Calgari", "CalgariTriad", "CalgariMG", "MCGreen" ]
    property var renderShaders_scale:[ 2, 2, 2, 5, 3, 3, -1, -1, -1, -1, 1 ]
    property var renderShaders_sourceSmooth:[ false, false, false, false, false, false, false, false, false, false, false ]
    property var renderShaders_hasVP:[ false, false, false, true, false, true, true, false, false, false, false ]

    property int renderShaderIndex: _DW_MOBILE? -1 : -1
    property bool renderUseShader: renderShaderIndex >= 0
    property bool renderSampleSharp: !_DW_MOBILE

    onRenderShaderIndexChanged: {
        debugMessage.text = ("Using shader \"%1\"").arg(["NONE"].concat(renderShaders)[renderShaderIndex+1]);
    }

/*
    ShaderEffectSource
    {
        id: videoSource
        sourceItem: offscreen? mainContentLoader : null
        hideSource: true
        smooth: renderUseShader? renderShaders_sourceSmooth[renderShaderIndex] : !renderSampleSharp
        textureSize: Qt.size(rootWindow.width, rootWindow.height) //mainContentLoader.width + "x" + mainContentLoader.height

    }
    ShaderEffect
    {
        id: shaderRenderer
        property var decal: videoSource
        property vector2d texture_size: Qt.vector2d(mainContentLoader.width, mainContentLoader.height)
        visible: offscreen && renderUseShader
        blending: false


        property real shaderScale: renderShaderIndex >= 0? renderShaders_scale[renderShaderIndex] : 1
        width: shaderScale > 0? shaderScale * mainContentLoader.width : rootWindow.width
        height: shaderScale > 0? shaderScale * mainContentLoader.height : rootWindow.height

        // Compatibility properties
        property vector2d rubyInputSize: texture_size
        property vector2d rubyTextureSize: texture_size
        property var rubyTexture: decal
        property vector2d rubyOutputSize: Qt.vector2d(width, height)
        property int rubyFrameCount: _DW_FRAME_COUNT
        // End Compatibility properties

        vertexShader: (renderUseShader && renderShaderIndex>=0 && renderShaders_hasVP[renderShaderIndex])?
                          DWUtil.readTextFile(Qt.resolvedUrl("glsl/"+renderShaders[renderShaderIndex].toLowerCase()+"_vp.glsl")) :
                          DWUtil.readTextFile(Qt.resolvedUrl("glsl/generic_vp.glsl"))

        fragmentShader: (renderUseShader && renderShaderIndex>=0)?
                            DWUtil.readTextFile(Qt.resolvedUrl("glsl/"+renderShaders[renderShaderIndex].toLowerCase()+"_fp.glsl")) : ""

    }


    ShaderEffectSource
    {
        id: shaderRendererSource
        sourceItem: offscreen && renderUseShader? shaderRenderer : null
        hideSource: true
        smooth: !renderSampleSharp
    }

    ShaderEffect
    {
        id: screenRenderer
        width: parent.width
        height: parent.height * waterLevel
        visible: offscreen && height
        blending: false

        property var src: renderUseShader? shaderRendererSource : videoSource
        property bool waterEnabled: false
        property real waterLevel: 1.0
        property color waterColor: "white"

        property real time: 0
        property real invScreenWidth: 1.5 / mainContentLoader.width

        vertexShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_vp.glsl"))
        fragmentShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_fp.glsl"))
    }
    ShaderEffect
    {
        id: screenRendererWater
        width: parent.width
        height: parent.height - screenRenderer.height
        anchors.top: screenRenderer.bottom
        visible: offscreen && screenRenderer.waterEnabled && height
        blending: false

        property var src: screenRenderer.src
        property bool waterEnabled: screenRenderer.waterEnabled
        property real waterLevel: screenRenderer.waterLevel
        property color waterColor: screenRenderer.waterColor
        property real chromatic: _DW_MOBILE? 2.0 : 3.5

        property real time: screenRenderer.time
        property real invScreenWidth: screenRenderer.invScreenWidth

        vertexShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_water_vp.glsl"))
        fragmentShader: DWUtil.readTextFile(Qt.resolvedUrl("glsl/screen_renderer_water_fp.glsl"))
    }
*/
    Image {
        id: dwLogo
        visible: false

        opacity: 0.0

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
        onTriggered: {mainContentLoader.active = true;}
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

    Text
    {
        id: debugMessage
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20
        font.family: "monospace"; font.weight: Font.Bold;
        text: ""
        visible: _DW_DEBUG
        color: "lime"
        style: Text.Outline
        styleColor: "black"

        NumberAnimation on opacity
        {
            id: debugMessageAnim
            from: 1
            to: 0
            duration: 6500
        }

        onTextChanged: {
            if(_DW_DEBUG)
                debugMessageAnim.restart();
        }

        font.pixelSize: 16
    }

    function debugMsg(msg)
    {
        // force change
        debugMessage.text = "";
        debugMessage.text = msg;
    }

}
