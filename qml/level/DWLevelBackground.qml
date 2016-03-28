import QtQuick 2.4
import dw 1.0
import ".."

ShaderEffect
{
    id: parallaxEffect

    z: field.bgZ

    property int bgIndex: 0
    property bool inPrefix: true

    property url bgSource: resBase + (inPrefix? levelData.urlPrefix + "bg/bg" + bgIndex + ".png" : "bgs/bg" + bgIndex + ".png")
    property url bgParallaxSource: resBase + (inPrefix? levelData.urlPrefix + "bg/bg" + bgIndex + "-parallax.png" : "bgs/bg" + bgIndex + ".png")

    width: parent.width
    height: sourceImg.height
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: Math.round(verticalOffset - field.viewCenterAtY * verticalFactor)
    blending: false

    property real parallaxFactor: 0.3
    property real parallaxTimeFactor: 50
    property real verticalFactor: 0.12 * (height/768) * (height/768)
    property real verticalOffset: 0

    property real wobblePhase: 2
    property real wobbleAmplitude: 1
    property real wobbleTimeFactor: 0.1

    property var src: source
    property var parallaxSource: parallaxRef
    property real parallax: field.viewCenterAtX


    property real parallaxTime: field.fieldTime * parallaxTimeFactor
    property real parallaxFactorR: parallaxFactor/width
    property real widthStretch: (width/height)/(sourceImg.width/sourceImg.height)
    property real invWidth: 1/width
    property real invHeight: 1/height

    opacity: 1.0

    vertexShader: "
                    uniform highp mat4 qt_Matrix;
                    attribute highp vec4 qt_Vertex;
                    attribute highp vec2 qt_MultiTexCoord0;
                    varying highp vec2 coord;
                    void main() {
                        coord = qt_MultiTexCoord0;
                        gl_Position = qt_Matrix * qt_Vertex;
                    }"
                fragmentShader: "
                    varying highp vec2 coord;
                    uniform sampler2D src;
                    uniform sampler2D parallaxSource;
                    uniform highp float parallax;
                    uniform highp float parallaxFactorR;
                    uniform highp float parallaxTime;
                    uniform highp float widthStretch;
                    uniform highp float invHeight;
                    uniform highp float invWidth;
                    uniform highp float wobblePhase;
                    uniform highp float wobbleAmplitude;
                    uniform highp float wobbleTimeFactor;
                    void main() {
                        lowp vec4 parallaxRef = texture2D( parallaxSource, coord );
                        lowp vec4 tex = texture2D(src, vec2(widthStretch, 1)*vec2(coord) + vec2((parallaxRef.r*parallax + parallaxRef.g*parallaxTime)*parallaxFactorR + wobbleAmplitude*parallaxRef.b*cos(parallaxTime*wobbleTimeFactor + coord.y/invHeight/wobblePhase)*invWidth, 0));
                        gl_FragColor = tex;
                    }"


    ShaderEffectSource
    {
        id: source
        sourceItem: sourceImg
        hideSource: true
        live: false
        wrapMode: ShaderEffectSource.Repeat
        smooth: false
    }

    Image {
        id: sourceImg
        source: bgSource
        asynchronous: true
        onStatusChanged: {if(status == Image.Ready) source.scheduleUpdate();}

    }

    Image {
        id: parallaxRef
        source: bgParallaxSource
        asynchronous: true
        smooth: false
        visible: false
    }
}
