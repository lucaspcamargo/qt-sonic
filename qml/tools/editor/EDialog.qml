import QtQuick 2.0

Rectangle {

    id: dialog

    color: Qt.rgba(0,0,0,0.8)

    anchors.fill: parent

    default property alias data: container.data

    visible: opacity != 0
    opacity: 0

    Behavior on opacity{ NumberAnimation{ } }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.AllButtons

        onClicked: dismiss()
        onWheel: wheel.accepted = true
    }


    Rectangle
    {
        width: parent.width - 128

        height: parent.height - 64

        anchors.centerIn: parent

        color: "black"

        border.color: "green"
        border.width: 1

        Item
        {
            id: container
            anchors.fill: parent
            anchors.margins: 8
            clip: true
        }
    }

    function show()
    {
        dialog.opacity = 1;
    }

    function dismiss()
    {
        dialog.opacity = 0;
    }

}
