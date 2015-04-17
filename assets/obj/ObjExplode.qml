import QtQuick 2.0
import dw 1.0

Item {

    id: explosion
    z: field.objSfxZ

    AnimatedSprite
    {
        x: -16
        y: -16
        width: 32
        height: 32
        source: "fx/explode.png"

        frameWidth: 32
        frameHeight: 32
        frameCount: 5
        frameDuration: 100

        interpolate: false
        running: true

        scale: 1.2
    }

    Timer
    {
        running: true
        interval: 350
        onTriggered: explosion.destroy();
    }

}
