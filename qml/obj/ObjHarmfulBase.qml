import QtQuick 2.4
import dw 1.0


DWFieldObject
{
    id: harmful
    width: 64
    height: 64
    sizeMatters: true
    z: field.objAZ


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
