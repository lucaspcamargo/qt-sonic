import QtQuick 2.0
import dw 1.0
import ".."


DWFieldObject
{
    id: obstacle
    width: 64
    height: 8
    z: field.objAZ

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

    DWEveryFrame
    {
        id: updater
        enabled: active

        onUpdate:
        {
            if(overlapPlayerI(obstacle) && !player.playerInvincible )
            {
                player.getHit(obstacle.x + obstacle.width/2, obstacle.y + obstacle.height / 2);
            }
        }
    }

}
