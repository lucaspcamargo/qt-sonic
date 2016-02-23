import QtQuick 2.3
import dw 1.0

ShaderEffect {

    id: waterPerspective

    width: field.viewWidth
    height: Math.round(Math.abs(field.viewCenterAtY - field.waterY )/verticalFactor)

    y: field.waterY - (underwater? 0 : height)
    x: -field.x
    z: field.bgZ

    visible: !( y > ( field.viewCenterAtY + field.viewHeight ) || (y + height) < ( field.viewCenterAtY - field.viewHeight ) )

    property bool reflectionEnabled: false//!_DW_MOBILE
    opacity: 0.75
    property color coloring: Qt.darker( field.waterColor )
    property var src: ses
    property var refl: reflSrc


    property real verticalFactor: 1.3
    property real fgScale: 0.5 * field.viewWidth / imgSrc.sourceSize.width
    property real bgScale: 5 * fgScale
    property bool underwater: field.viewCenterAtY > field.waterY
    property real underwaterMix: underwater? 1 : 0
    property real displacement: field.viewCenterAtX / imgSrc.sourceSize.width + field.fieldTime / 7

    vertexShader: "
                    uniform highp mat4 qt_Matrix;
                    uniform lowp float underwaterMix;

                    attribute highp vec4 qt_Vertex;
                    attribute highp vec2 qt_MultiTexCoord0;
                    varying highp vec2 coord;
                    void main() {
                        coord = vec2(qt_MultiTexCoord0.x, mix(qt_MultiTexCoord0.y, 1.0 - qt_MultiTexCoord0.y, underwaterMix) ) ;
                        gl_Position = qt_Matrix * qt_Vertex;
                    }"

    fragmentShader: DWUtil.readTextFile(Qt.resolvedUrl(resBase + "field/water-perspective/fragment-" + (reflectionEnabled? "reflection.glsl" : "no-reflection.glsl")))

    Image
    {
        id: imgSrc
        parent: null
        source: resBase + "field/water-perspective/water-texture.png"
    }

    ShaderEffectSource
    {
        id: ses
        anchors.fill: imgSrc
        sourceItem: imgSrc
        parent: null
        wrapMode: ShaderEffectSource.Repeat
        live: false
    }

    property rect reflRect: Qt.rect(field.x + x - bg.x, field.y + y + (underwater? height : -height) - bg.y, width, height)
    ShaderEffectSource
    {
        id: reflSrc
        enabled: reflectionEnabled
        live: reflectionEnabled && waterPerspective.visible
        sourceItem: bgContainer
        sourceRect: reflRect
        textureSize: Qt.size(waterPerspective.width, _DW_MOBILE? 64 : 128)
        parent: null
        wrapMode: ShaderEffectSource.ClampToEdge
    }
}

