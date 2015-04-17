import QtQuick 2.0
import dw 1.0

ShaderEffect {
    property string chunkChildType: "visual"

    property bool layerB: false
    property bool visualBg: false
    property bool doNotFlatten: false
    property bool ownsQtObjects: false

    property alias source: sourceImage.source
    property alias asynchronous: sourceImage.asynchronous

    property int paletteIndex: 0
    property var visSampler: sourceImage
    property var paletteSampler: visManager.getPaletteSource(paletteIndex)
    property real paletteCoordY: 0
    width: sourceImage.sourceSize.width
    height: sourceImage.sourceSize.height

    function activate()
    {
        visible = true;
        visManager.visCount ++;
    }

    function deactivate()
    {
        visible = false;
        visManager.visCount --;
    }

    DWEveryFrame
    {
        enabled: visible
        onUpdate:
        {
            paletteCoordY = visManager.paletteCoordY;
        }
    }

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
                        uniform sampler2D visSampler;
                        uniform sampler2D paletteSampler;
                        uniform lowp float paletteCoordY;
                        void main() {
                                lowp vec4 tex = texture2D(visSampler, coord);
                                gl_FragColor = texture2D(paletteSampler, vec2(tex.r, paletteCoordY)) * tex.b;

                        }
                    "

    Image
    {
        id: sourceImage
        parent: null // no visual parent, no rendering, no problem
        smooth: false
    }

}
