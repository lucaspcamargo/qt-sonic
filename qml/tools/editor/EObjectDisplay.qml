import QtQuick 2.4
import "../../"
import dw 1.0

Rectangle {
    width: 48
    height: 48

    color: "#000"

    border.color: "#88aa00"
    border.width: 1
    clip: true

    property alias label: labelText.text
    property alias name: nameText.text
    property alias sprite: spr.spritesheet

    DWSprite
    {
        id: spr
        anchors.centerIn: parent
    }

    DWTextBitmap
    {
        id: labelText
        x: 2
        y: 2
        font: "xexex-multi"
    }

    DWTextBitmap
    {
        id: nameText
        x: 2
        y: 38
        font: "xexex-multi"
    }


}

