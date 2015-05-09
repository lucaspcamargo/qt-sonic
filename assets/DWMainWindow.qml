import QtQuick 2.3
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

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
            source: _DW_MOBILE? "dev/DWDevMenu.qml" : "DWLevelScene.qml"
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

        vertexShader: "
                            uniform highp mat4 qt_Matrix;
                            attribute highp vec4 qt_Vertex;
                            attribute highp vec2 qt_MultiTexCoord0;
                            varying highp vec2 texCoord;
                            void main() {
                                texCoord = qt_MultiTexCoord0;
                                gl_Position = qt_Matrix * qt_Vertex;
                            }"

        fragmentShader: "
                            const vec3 dtt = vec3(65536.0,255.0,1.0);

                            uniform highp vec2 texture_size;
                            uniform sampler2D decal;
                            varying highp vec2 texCoord;
                                int GET_RESULT(float A, float B, float C, float D)
                                {
                                int x = 0; int y = 0; int r = 0;
                                if (A == C) x+=1; else if (B == C) y+=1;
                                if (A == D) x+=1; else if (B == D) y+=1;
                                if (x <= 1) r+=1;
                                if (y <= 1) r-=1;
                                return r;
                                }

                                float reduce(vec3 color)
                                {
                                return dot(color, dtt);
                                }

                                void main()
                                {

                                // get texel size
                                vec2 ps = vec2(0.999/texture_size.x, 0.999/texture_size.y);
                                // calculating offsets, coordinates
                                vec2 dx = vec2( ps.x, 0.0);
                                vec2 dy = vec2( 0.0, ps.y);
                                vec2 g1 = vec2( ps.x,ps.y);
                                vec2 g2 = vec2(-ps.x,ps.y);
                                vec2 pixcoord = texCoord/ps;
                                vec2 fp = fract(pixcoord);
                                vec2 pC4 = texCoord-fp*ps;
                                vec2 pC8 = pC4+g1;
                                // Reading the texels
                                vec3 C0 = texture2D(decal,pC4-g1).xyz;
                                vec3 C1 = texture2D(decal,pC4-dy).xyz;
                                vec3 C2 = texture2D(decal,pC4-g2).xyz;
                                vec3 D3 = texture2D(decal,pC4-g2+dx).xyz;
                                vec3 C3 = texture2D(decal,pC4-dx).xyz;
                                vec3 C4 = texture2D(decal,pC4 ).xyz;
                                vec3 C5 = texture2D(decal,pC4+dx).xyz;
                                vec3 D4 = texture2D(decal,pC8-g2).xyz;
                                vec3 C6 = texture2D(decal,pC4+g2).xyz;
                                vec3 C7 = texture2D(decal,pC4+dy).xyz;
                                vec3 C8 = texture2D(decal,pC4+g1).xyz;
                                vec3 D5 = texture2D(decal,pC8+dx).xyz;
                                vec3 D0 = texture2D(decal,pC4+g2+dy).xyz;
                                vec3 D1 = texture2D(decal,pC8+g2).xyz;
                                vec3 D2 = texture2D(decal,pC8+dy).xyz;
                                vec3 D6 = texture2D(decal,pC8+g1).xyz;
                                vec3 p00,p10,p01,p11;
                                // reducing vec3 to float
                                float c0 = reduce(C0);float c1 = reduce(C1);
                                float c2 = reduce(C2);float c3 = reduce(C3);
                                float c4 = reduce(C4);float c5 = reduce(C5);
                                float c6 = reduce(C6);float c7 = reduce(C7);
                                float c8 = reduce(C8);float d0 = reduce(D0);
                                float d1 = reduce(D1);float d2 = reduce(D2);
                                float d3 = reduce(D3);float d4 = reduce(D4);
                                float d5 = reduce(D5);float d6 = reduce(D6);

                                if (c7 == c5 && c4 != c8) {
                                p11 = p01 = C7;
                                } else if (c4 == c8 && c7 != c5) {
                                p11 = p01 = C4;
                                } else if (c4 == c8 && c7 == c5) {
                                int r = 0;
                                r += GET_RESULT(c5,c4,c6,d1);
                                r += GET_RESULT(c5,c4,c3,c1);
                                r += GET_RESULT(c5,c4,d2,d5);
                                r += GET_RESULT(c5,c4,c2,d4);
                                if (r > 0)
                                p11 = p01 = C5;
                                else if (r < 0)
                                p11 = p01 = C4;
                                else {
                                p11 = p01 = 0.5*(C4+C5);
                                }
                                } else {
                                if (c5 == c8 && c8 == d1 && c7 != d2 && c8 != d0)
                                p11 = 0.25*(3.0*C8+C7);
                                else if (c4 == c7 && c7 == d2 && d1 != c8 && c7 != d6)
                                p11 = 0.25*(3.0*C7+C8);
                                else
                                p11 = 0.5*(C7+C8);
                                if (c5 == c8 && c5 == c1 && c4 != c2 && c5 != c0)
                                p01 = 0.25*(3.0*C5+C4);
                                else if (c4 == c7 && c4 == c2 && c1 != c5 && c4 != d3)
                                p01 = 0.25*(3.0*C4+C5);
                                else
                                p01 = 0.5*(C4+C5);
                                }
                                if (c4 == c8 && c7 != c5 && c3 == c4 && c4 != d2)
                                p10 = 0.5*(C7+C4);
                                else if (c4 == c6 && c5 == c4 && c3 != c7 && c4 != d0)
                                p10 = 0.5*(C7+C4);
                                else
                                p10 = C7;
                                if (c7 == c5 && c4 != c8 && c6 == c7 && c7 != c2)
                                p00 = 0.5*(C7+C4);
                                else if (c3 == c7 && c8 == c7 && c6 != c4 && c7 != c0)
                                p00 = 0.5*(C7+C4);
                                else
                                p00 = C4;
                                // Distributing the four products
                                if (fp.x < 0.50)
                                { if (fp.y < 0.50) p10 = p00;}
                                else
                                { if (fp.y < 0.50) p10 = p01; else p10 = p11;}
                                // OUTPUT
                                gl_FragColor = vec4(p10"+(renderScanlines?"*(0.9 + 0.2*fract(texCoord.y*texture_size.y))" : "")+", 1);
                                }"
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
        vertexShader: "
                            uniform highp mat4 qt_Matrix;
                            attribute highp vec4 qt_Vertex;
                            attribute highp vec2 qt_MultiTexCoord0;
                            varying highp vec2 coord;
                            void main() {
                                coord = qt_MultiTexCoord0;
                                gl_Position = qt_Matrix * qt_Vertex;
                            }"

        fragmentShader: waterEnabled?
                            "
                            varying highp vec2 coord;
                            uniform sampler2D src;
                            uniform lowp float waterLevel;
                            uniform lowp float time;
                            uniform lowp float invScreenWidth;
                            uniform lowp float waveYDelta;
                            uniform lowp vec4 waterColor;
                            void main() {
                                if(coord.y > waterLevel)
                                {
                                    lowp vec4 tex = texture2D(src, vec2(coord.x + cos(time+waveYDelta+10.0*coord.y)*invScreenWidth, coord.y))*waterColor;
                                    gl_FragColor = tex;
                                }else{
                                    lowp vec4 tex = texture2D(src, coord);
                                    gl_FragColor = tex;
                                }
                            }"
                            :
                            "
                            varying highp vec2 coord;
                            uniform sampler2D src;
                            void main() {
                                lowp vec4 tex = texture2D(src, coord);
                                gl_FragColor = tex;

                            }"
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
            onDoubleClicked: Qt.quit(0)
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

}
