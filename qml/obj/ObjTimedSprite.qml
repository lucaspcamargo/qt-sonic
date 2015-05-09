import QtQuick 2.0
import dw 1.0
import ".."

AnimatedSprite
{
    id: sprite

    z: field.objSfxZ

    interpolate: false
    running: true

    frameX: 0
    frameY: 0

    Timer
    {
        running: true
        interval: sprite.frameCount * sprite.frameDuration - 16
        onTriggered: sprite.destroy();
    }

}
