import QtQuick 2.0
import ".."

Rectangle {
    width: 100
    height: 62

    color: "white"

    Image {

        source: "title/newicon-wide.png"

        anchors.fill: parent
        anchors.margins: parent.height / 3
        fillMode: Image.PreserveAspectFit

    }

    SequentialAnimation {
        running: true

        ScriptAction
        {
            script: {
                dwSfx.play()
                globalFader.opacity = 0
            }
        }


        PauseAnimation {
            duration: 4000
        }
        ScriptAction
        {
            script: {
                globalFader.opacity = 1
            }
        }


        PauseAnimation {
            duration: 600
        }

        ScriptAction
        {
            script: {
                mainContentLoader.source = Qt.resolvedUrl("../DWMainScreen.qml");
            }
        }

    }

    DWSoundEffect {
        id: dwSfx
        source: "../dw/theme.wav.ogg"
    }

}

