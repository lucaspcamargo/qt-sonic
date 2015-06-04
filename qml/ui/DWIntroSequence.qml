import QtQuick 2.4
import ".."
import dw 1.0

Item {
    id: titleScreen
    anchors.fill: parent


    Component.onCompleted: offscreen = false

    Rectangle
    {
        id: dwSplash
        color: "white"
        anchors.fill: parent

        Image
        {
            source: resBase + "ui/intro/dwlogo.png"

            anchors.fill: parent
            anchors.margins: parent.height/3
            fillMode: Image.PreserveAspectFit
            visible: true
            smooth: true
        }

    }

    Rectangle
    {
        id: disclaimer
        anchors.fill: parent
        color: "black"

        Image
        {
            source: resBase + "ui/intro/disclaimer.png"
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }
    }

    SequentialAnimation
    {
        running: true

        ScriptAction
        {
            script: {globalFader.opacity = 0;}
        }

        PauseAnimation {
            duration: 6000
        }
        ScriptAction
        {
            script: globalFader.opacity = 1
        }
        PauseAnimation
        {
            duration: 550
        }



        ScriptAction
        {
            script: {disclaimer.destroy(); globalFader.opacity = 0; themeSfx.play()}
        }

        PauseAnimation {
            duration: 3000
        }
        ScriptAction
        {
            script: globalFader.opacity = 1
        }
        PauseAnimation
        {
            duration: 550
        }




        ScriptAction
        {
            script: dwSplash.destroy();
        }
        ScriptAction
        {
            script:
            {
                mainContentLoader.source = Qt.resolvedUrl("../DWMainScreen.qml");
                //titleScreen.destroy();
            }
        }

    }

    DWSoundEffect
    {
        id: themeSfx
        source: resBase + "ui/intro/dwtheme.ogg"
    }
}

