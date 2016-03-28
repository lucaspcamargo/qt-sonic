import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {

    id: root
    height: 32

    property string label: ""
    property var settings: ["DEFAULT"]
    property int currentSetting: 0
    property bool isLast: Positioner.isLastItem

    property color bgColor: "#222"

    ColorAnimation{
        target: root
        property: "bgColor"
        from: "#cf0"
        to: "#8a0"
        duration: 200
        running: root.focus
        loops: Animation.Infinite
        easing.type: Easing.SineCurve
        onRunningChanged: {if(!running) bgColor = "#222"; }
    }

    onActiveFocusChanged: if(!focus) changeSfx.play();

    RadialGradient
    {
        anchors.fill: parent
        opacity: 0.5
        gradient: Gradient {

            GradientStop{
                position: 0
                color: bgColor
            }

            GradientStop{
                position: 1
                color: "#00222222"
            }

        }

        horizontalRadius: width/2
        verticalRadius: height
        verticalOffset: 8
    }

    Rectangle
    {
        anchors.verticalCenter: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.width
        width: 0.5
        rotation: 90

        gradient: Gradient {

            GradientStop{
                position: 0
                color: "#00ffffff"
            }

            GradientStop{
                position: 0.5
                color: "#80ffffff"
            }

            GradientStop{
                position: 1
                color: "#00ffffff"
            }

        }
    }

    Rectangle
    {
        visible: isLast
        anchors.verticalCenter: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.width
        width: 0.5
        rotation: 90

        gradient: Gradient {

            GradientStop{
                position: 0
                color: "#00ffffff"
            }

            GradientStop{
                position: 0.5
                color: "#80ffffff"
            }

            GradientStop{
                position: 1
                color: "#00ffffff"
            }

        }

    }

    Text
    {
        text: label

        width: parent.width/2
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: "white"
        font.family: "OpenSans"
        font.weight: Font.Light
        font.pixelSize: 12

    }

    Text
    {
        text: currentSetting < 0? "" : settings[currentSetting]

        width: parent.width/2
        x: width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: "white"
        font.family: "OpenSans"
        font.italic: true
        font.pixelSize: 12

    }

    Keys.onPressed:
    {
        if(event.key === Qt.Key_X || event.key === Qt.Key_Right || event.key === Qt.Key_Return)
        {
            change(false);
            event.accepted = true;
            return;
        }
        if(event.key === Qt.Key_Left)
        {
            change(true);
            event.accepted = true;
            return;
        }
    }

    function change(backwards)
    {
        if(!backwards)
            currentSetting = (currentSetting + 1) % settings.length;
        else
        {
            if(currentSetting == 0)
                currentSetting = settings.length - 1;
            else
                currentSetting -= 1;
        }

        changeSfx.play();
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: change()
    }

}

