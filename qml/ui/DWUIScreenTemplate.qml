import QtQuick 2.4
import QtGraphicalEffects 1.0

FocusScope {

    property string screenLabel: ""
    property bool darkBg: false
    property var buttonInstructions: [ ['X', "Select"], ["Z", "Back"] ]
    property bool backButton: true

    Component.onCompleted: forceActiveFocus()

    Rectangle
    {
        visible: darkBg
        anchors.fill: parent
        color: Qt.rgba(0.13333333, 0.13333333, 0.13333333, 0.7);

    }

    Text
    {
        id: textLabelS
        x: 20
        y: 17
        text: screenLabel
        font.family: globalResources.dwFont.name
        font.pixelSize: 28
        color: "#222"
        renderType: Text.QtRendering
        antialiasing: false
        smooth: false
    }
    Text
    {
        id: textLabel
        x: 20
        y: 16
        text: screenLabel
        font.family: globalResources.dwFont.name
        font.pixelSize: 28
        color: "white"
        renderType: Text.QtRendering
        antialiasing: false
        smooth: false
    }

    Rectangle
    {
        id: gradientRect
        height: textLabel.height
        width: 1
        visible: false
        gradient: Gradient{
            GradientStop{
                position: 0
                color: "white"
            }

            GradientStop{
                position: 1
                color: "gray"
            }
        }
    }

    Blend
    {
        anchors.fill: textLabel
        mode: "multiply"
        source: textLabel
        foregroundSource: gradientRect
    }

}
