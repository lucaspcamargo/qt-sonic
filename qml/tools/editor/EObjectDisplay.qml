import QtQuick 2.4
import "../../"

Rectangle {
    width: 48
    height: 48

    color: "#000"

    border.color: "#88aa00"
    border.width: 1

    property alias label: labelText.text
    property alias name: nameText.text

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
        anchors.horizontalCenter: parent.horizontalCenter
        y: 38
        font: "xexex-multi"
    }


}

