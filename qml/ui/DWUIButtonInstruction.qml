import QtQuick 2.4

Item {

    property string button: ""
    property string label: ""

    width: 100
    height: 13

    Row
    {
        anchors.fill: parent
        spacing: 4

        Rectangle
        {
            width: parent.height
            height: width

            radius: width/2

            color: "#80ffffff"


            Text
            {
                text: button
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                color: "#80222222"
                font.pixelSize: 8
                font.family: "OpenSans"
                font.weight: Font.Bold
            }
        }

        Text
        {
            text: label
            color: "white"
            font.pixelSize: 10
            font.family: "OpenSans"
            font.weight: Font.Light
            verticalAlignment: Text.AlignVCenter
            height: parent.height
        }

    }
}

