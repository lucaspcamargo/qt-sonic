import QtQuick 2.0

Item {
    id: titleScreen
    anchors.fill: parent

    Rectangle
    {
        id: splash
        color: "white"
        anchors.fill: parent

        Image
        {
            source: "titlescreen/newicon-wide.png"
            width: 528/2
            height: 150/2
            anchors.centerIn: parent
            visible: true
        }

        Image
        {
            source: "titlescreen/title.png"
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            visible: true
            smooth: true
        }

    }

    SequentialAnimation
    {
        running: true

        ScriptAction
        {
            script: {globalFader.opacity = 0; themeSfx.play()}
        }

        PauseAnimation {
            duration: 2500
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
            script: splash.destroy();
        }
        ScriptAction
        {
            script:
            {
                mainContentLoader.source = Qt.resolvedUrl("DWMainScreen.qml");
                //titleScreen.destroy();
            }
        }

    }

    DWSoundEffect
    {
        id: themeSfx
        source: "dw/theme.wav.ogg"
    }
}

