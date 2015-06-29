import QtQuick 2.4
import dw 1.0

Item {

    anchors.fill: parent

    ShaderEffect
    {

        id: plasmaBg
        anchors.fill: parent

        property real u_time: 0
        property vector2d u_k: Qt.vector2d(16, 9);


        function update(dt)
        {
            u_time = (u_time + dt) % (12 * Math.PI)
        }

        fragmentShader: "
        #define PI 3.1415926535897932384626433832795

        uniform float u_time;
        uniform vec2 u_k;
        varying vec2 qt_TexCoord0;

        void main() {
            float v = 0.0;
            vec2 c = (qt_TexCoord0 + vec2(-0.5, -0.5)) * u_k - u_k/2.0;
            v += sin((c.x+u_time));
            v += sin((c.y+u_time)/2.0);
            v += sin((c.x+c.y+u_time)/2.0);
            c += u_k/2.0 * vec2(sin(u_time/3.0), cos(u_time/2.0));
            v += sin(sqrt(c.x*c.x+c.y*c.y+1.0)+u_time);
            v = v/2.0;
            vec3 col = vec3(cos(PI*v)/2.0, sin(PI*v), 0.4);
            gl_FragColor = vec4(col*.1/* + .5*/, 1);
        }"
    }

    DWEveryFrame {
        enabled: true
        onUpdate: plasmaBg.update(dt)
    }

/*
    Image {
        id: pattern
        source: resBase + "bg/pattern.png"

        width: 3*parent.width
        height: 3*parent.height
        x: -parent.width
        y: -parent.height

        fillMode: Image.Tile



        NumberAnimation on x {

            from: -pattern.parent.width
            to: -pattern.parent.width + pattern.sourceSize.width

            running: true
            loops: Animation.Infinite
            duration: 500
        }
    }

    DWImageItem
    {
        anchors.fill: parent
        opacity: 0.2
        source: "bg/bayonetta.jpg"
    }
*/

    MouseArea
    {
        hoverEnabled: true
        anchors.fill: parent
    }

}

