import QtQuick 2.0

Image {

    property string chunkChildType: "geom-ramp"
    property bool onlyBottomSensors: false
    property bool reversed: false
    property bool layerA: true
    property bool layerB: true

    // editor visuals and default props
    width: 64
    height: 64
    mirror: reversed
    source: resBase + "editor/ramp.png"
}
