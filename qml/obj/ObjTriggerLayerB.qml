import QtQuick 2.4

ObjTrigger
{
    width: 16
    height: 16

    debugColor: "#0000ff"
    debugColorFill: "#800000ff"
    debugText: "B"

    onTriggered: player.playerInLayerB = true
}
