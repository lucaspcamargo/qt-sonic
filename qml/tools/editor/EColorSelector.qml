import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

Rectangle {

    id: selector

    property real h: 0.0
    property real s: 1.0
    property real v: 1.0
    property real a: 1.0

    property color selectedColor: Qt.hsva(h, s, v, a)

    property bool unloop: false

    onHChanged: if(!unloop) hueSlider.value = h

    color: "#333"

    border.color: "#88aa00"
    border.width: 1

    width: 250
    height: 250

    function clamp(x)
    {
        return Math.min(1.0, Math.max(0.0, x));
    }

    MouseArea { anchors.fill: parent; hoverEnabled: true }

    GridLayout {

        id: grid
        anchors.fill: parent
        anchors.margins: 10
        columns: 2

        ShaderEffect {

            width: 200
            height: 200

            property real hue: hueSlider.value

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
              uniform lowp float qt_Opacity;
              uniform lowp float hue;


                vec3 rgb2hsv(vec3 c)
                {
                    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
                    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

                    float d = q.x - min(q.w, q.y);
                    float e = 1.0e-10;
                    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
                }



                vec3 hsv2rgb(vec3 c)
                {
                    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
                    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
                    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
                }

              void main() {

                  gl_FragColor = vec4(hsv2rgb(vec3(hue, coord.x, 1.0-coord.y)), 1.0) * qt_Opacity;
              }"

            MouseArea
            {
                id: ma

                anchors.fill: parent

                onPositionChanged:
                {
                    if(pressed)
                    {
                        s = clamp(mouseX / parent.width);
                        v = clamp((parent.height - mouseY) / parent.height);
                    }
                }

            }

            Rectangle
            {
                id: cursor
                width: 6
                height: 6
                radius: 3
                color: "transparent"
                border.width: 1
                border.color: "#222"

                x: parent.width*s - 3
                y: (parent.height*(1-v)) - 3
            }

            Rectangle
            {
                id: cursor2
                width: 6
                height: 6
                radius: 3
                color: "transparent"
                border.width: 1
                border.color: "#ddd"

                x: parent.width*s - 3.5
                y: (parent.height*(1-v)) - 3.5
            }

        }

        Slider {
            id: hueSlider

            orientation: Qt.Vertical
            Layout.fillHeight: true
            onValueChanged: {unloop = true; selector.h = value; unloop = false;}
        }

        Rectangle
        {
            height: 32
            Layout.fillWidth: true

            color: selectedColor
        }
    }


}
