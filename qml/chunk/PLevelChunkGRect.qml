import QtQuick 2.4

Rectangle {

    property string chunkChildType: "geom-rect"
    property bool onlyBottomSensors: false
    property bool layerA: true
    property bool layerB: true

    // editor visuals and default props
    width: 128
    height: 16
    color: onlyBottomSensors? "#8000ffff" : "#80ffff00"
    border.color: onlyBottomSensors? "transparent" : "yellow"

    Rectangle
    {
        property string chunkChildType: "no-reparent"
        color: "yellow"
        visible: onlyBottomSensors
        width: parent.width
        height: 2
    }

}
