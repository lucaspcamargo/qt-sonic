import QtQuick 2.0
import dw 1.0

ObjTrigger
{
    width: 16
    height: 16

    property real strength: 1
    property bool setRot: true

    debugColor: "#00ff00"
    debugColorFill: "#8000ff00"
    debugText: "»"
    continuous: true

    onTriggered:
    {
        player.playerQuadModeLocked = true;

        if(player.playerState != DWPlayerBase.PS_AIR && (player.gAngle > 315 || player.gAngle < 45) )
        {
            player.x += Math.cos(rotation / 180 * Math.PI) * strength * dt/0.016666;
            player.y += Math.sin(rotation / 180 * Math.PI) * strength * dt/0.016666;
        }
    }

    onCollisionEnded:
    {
        player.playerQuadModeLocked = false;
    }
}
