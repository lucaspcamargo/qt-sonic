import QtQuick 2.4
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
        if(player.playerState != DWPlayerBase.PS_AIR )
        {
            player.gSpeed = Math.max(player.gSpeed, 60);
            if(player.gSpeed < 120)
                player.gSpeed += dt;
        }
    }

}
