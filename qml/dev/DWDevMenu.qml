import QtQuick 2.4
import ".."
import dw 1.0

Item {
    width: 427
    height: 240

    DWDevBG
    {

    }


    DWImageItem
    {
        id: testImage
        source: "bg/bayonetta.jpg"
        opacity: 0.3
        anchors.fill: parent
    }

    DWDevText
    {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 16
        text: "DW DEV MENU"
    }

    FocusScope {
        id: menuFocus
        width: parent.width - 64
        anchors.horizontalCenter: parent.horizontalCenter
        y: 64

        Grid {
            anchors.fill: parent
            columnSpacing: 8
            rowSpacing: columnSpacing
            columns: 2

            DWDevButton {
                id: i00
                focus: true
                text: "Intro Sequence"
                onClicked: mainContentLoader.source =  Qt.resolvedUrl("../ui/DWIntroSequence.qml")
                KeyNavigation.right: i01
                KeyNavigation.down:  i10
            }

            DWDevButton {
                id: i01
                text: "Test Level"
                onClicked: mainContentLoader.source =  Qt.resolvedUrl("../DWLevelScene.qml")
                KeyNavigation.down:  i11
            }

            DWDevSwitch {
                id: i10
                description: "Debug"
                prop: "_DW_DEBUG"
                KeyNavigation.right: i11
                KeyNavigation.down:  i20
            }

            DWDevSwitch {
                id: i11
                description: "Mobile"
                prop: "_DW_MOBILE"
                KeyNavigation.down: i21
            }

            DWDevSwitch {
                id: i20
                description: "Master Gain"
                prop: "DWRoot.soundSystem.masterGain"
                KeyNavigation.right: i21
            }

            DWDevButton {
                id: i21
                text: "Level Select"
                onClicked: mainContentLoader.source =  Qt.resolvedUrl("../DWLevelScene.qml")
            }
        }
    }

    DWDevText {

        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - 16
        text: "Lucas Camargo - cmakeshift - " + globalBuildDate

    }

    DWLevelBGM {
        id: bgm
        mainId: "dev.ogg"
        volume: 0.2
    }

    Component.onCompleted: {
        globalFader.opacity = 0;
        menuFocus.forceActiveFocus();
    }

    Timer {
        running: true
        interval: 32
        onTriggered: bgm.play()
    }

}

