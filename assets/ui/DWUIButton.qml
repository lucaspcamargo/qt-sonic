import QtQuick 2.4
import ".."

Rectangle {

    id: button

    color: mouseArea.pressed? "#680" : "#8a0"

    width: Math.max(64, bitmapText.implicitWidth)
    height: 24

    property string text: "DEFAULT"
    signal clicked()

    DWTextBitmap
    {
        id: bitmapText
        text: button.text
        font: "xexex-multi"
        anchors.centerIn: parent
        visible: offscreen
    }

    Text
    {
        id: curveText
        text: button.text
        color: "white"
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 9
        visible: !offscreen
    }

    Rectangle
    {
        color: mouseArea.pressed? "#cf0" : Qt.darker(parent.color)
        width: parent.width
        height: 2
        anchors.bottom: parent.bottom
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked()
    }
}

