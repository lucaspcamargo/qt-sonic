import QtQuick 2.4

Item {

    id: button
    width: 177
    height: 24

    property alias text: label.text
    property alias colorIndex: label.colorIndex
    signal clicked

    Rectangle {
        anchors.fill: parent
        color: "#50000000"

        DWDevText {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            x: 8
        }

        MouseArea {
            anchors.fill: parent
            onClicked: button.clicked()
        }

        Rectangle {
            visible: (!_DW_MOBILE) && button.activeFocus
            width: parent.width
            height: 2
            y: 22
            color: "#a0ff00"
        }

    }

    Keys.onSpacePressed: clicked();
    Keys.onReturnPressed: clicked();
}

