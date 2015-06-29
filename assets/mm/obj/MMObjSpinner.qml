import QtQuick 2.0
import dw 1.0
import "qrc:/core/qml/obj"

ObjHarmfulBase
{
    id: obstacle
    width: 64
    height: 8

    AnimatedSprite
    {
        source: "spr/spinner.png"
        anchors.fill: parent
        frameWidth: width
        frameHeight: height
        frameCount: 5
        frameDuration: 3000.0 * (1.0/60.0)
        interpolate: false
    }

    Component.onCompleted: buildPhysicsBody()

}
