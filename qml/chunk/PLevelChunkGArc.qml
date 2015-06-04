import QtQuick 2.4

Item {

    property string chunkChildType: "geom-arc"
    property int quadrant: 0
    property bool layerA: true
    property bool layerB: true

    // editor visuals and default props
    width: 64
    height: 64

    clip: true

    Rectangle
    {
        id: arc
        property string chunkChildType: "no-reparent"
        width: parent.width * 2
        height: parent.height * 2
        color: "transparent"
        border.width: 1
        border.color: "yellow"
        radius: parent.width
        x: quadrant == 1 || quadrant == 2? 0 : -parent.width
        y: quadrant > 1 ? -parent.height : 0
    }


}
