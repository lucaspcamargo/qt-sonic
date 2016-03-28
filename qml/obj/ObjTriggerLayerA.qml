import QtQuick 2.4

ObjTrigger
{
    width: 16
    height: 16

    debugColor: "#ff0000"
    debugColorFill: "#80ff0000"
    debugText: "A"

    onTriggered: player.playerInLayerB = false

}
