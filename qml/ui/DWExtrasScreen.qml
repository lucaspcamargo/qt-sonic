import QtQuick 2.4

DWUIScreenTemplate {

    screenLabel: "Extras"
    darkBg: false


    Rectangle
    {
        id: shadowCont
        NumberAnimation on width
        {
            from: 64
            to: 128
            duration: 20000
            loops: Animation.Infinite
            easing.type: Easing.SineCurve
        }
        height: 64

        anchors.verticalCenter: parent.verticalCenter
        color: "#222"
        opacity: 0.7
    }

    Image {

        id: ribbon
        width: 64
        height: 64
        opacity: shadowCont.opacity
        source: resBase + "ui/main/ribbon-terminator.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: shadowCont.right

    }

    Image {

        id: ribbon2
        width: 64
        height: 64
        opacity: shadowCont.opacity
        source: resBase + "ui/main/ribbon-terminator.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ribbon.right
        anchors.leftMargin: 100
        mirror: true
    }


    Rectangle
    {
        id: shadowCont2
        height: 64

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ribbon2.right
        anchors.right: parent.right
        color: "#222"
        opacity: 0.7
    }


    // BEGIN CONTENT
}

