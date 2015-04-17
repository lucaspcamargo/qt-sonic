import QtQuick 2.0
import dw 1.0
import ".."


DWFieldObject
{
    id: obstacle
    width: 48
    height: 48
    z: field.objAZ

    Image
    {
        source: "obj/obstacle.png"
        anchors.centerIn: parent
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
