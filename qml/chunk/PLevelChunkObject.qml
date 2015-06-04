import QtQuick 2.4

Rectangle {

    property string chunkChildType: "objstub"

    property string objComponentName: ""
    property var objOptions: []
    property bool inPrefix: false

    // editor visuals and default props
    width: 128
    height: 16
    color: "#80ff0080"
    border.color: "#ff0080"

    Text
    {
        property string chunkChildType: "no-reparent"

        color: "white"
        styleColor: "black"
        style: Text.Outline
        text: objComponentName
        anchors.centerIn: parent
        font.pixelSize: 12
    }

}
