import QtQuick 2.4
import ".."
import dw 1.0

Item
{
    id: sceneTitle
    anchors.fill: parent

    property int animDuration: 750

    Image
    {
        id: titleDecoration
        source: resBase + "ui/titlecards/tile.png"
        height: parent.height * 20
        fillMode: Image.TileVertically

        x: -width
        Behavior on x { NumberAnimation { easing.type: Easing.InOutQuart; duration: sceneTitle.animDuration } }


        NumberAnimation on y{
            duration: 400
            from: 0
            to: -24
            easing.type: Easing.Linear
            running: true
            loops: Animation.Infinite
        }

    }

    Rectangle
    {
        id: titleShadow
        width: parent.width
        height: 96 + (levelData.subtitle? 8 : 0 )

        y: 240
        color: "#222"
        opacity: 0.7

        Behavior on y { NumberAnimation { easing.type: Easing.InOutQuart; duration: sceneTitle.animDuration } }

    }

    DWTextBitmap
    {
        id: subtitle
        x: 128 + 4
        anchors.bottom: titleShadow.bottom
        anchors.bottomMargin: 6
        font: "xexex-multi"
        text: levelData.subtitle
    }

    Image
    {
        id: title
        x: 427
        anchors.verticalCenter: parent.verticalCenter

        source: Qt.resolvedUrl(resBase + levelData.urlPrefix + "title.png")

        Behavior on x { NumberAnimation { easing.type: Easing.InOutQuart; duration: sceneTitle.animDuration } }
    }

    property SequentialAnimation titleAnimation: SequentialAnimation {

        id: titleAnimation

        property int bgmIndexToPlay: 0
        property real timeToResetTo: 0

        running: false

        ScriptAction {
            script:
            {
                field.fieldActive = true;

                sceneTitle.visible = true;
                sceneTitle.animDuration = 750;
                globalFader.opacity = 0;
                title.x = 128 + 4
                titleDecoration.x = 0
                titleShadow.y = 120 - 48
            }
        }

        PauseAnimation {
            duration: sceneTitle.animDuration
        }

        ScriptAction {
            script:
            {
                bgmPlayer.currentBGM = titleAnimation.bgmIndexToPlay;
                bgmPlayer.resetBGM( bgmPlayer.currentBGM );
            }
        }


        PauseAnimation {
            duration: 1500
        }

        ScriptAction {
            script: { sceneFader.opacity = 0;}
        }

        PauseAnimation {
            duration: 500
        }

        ScriptAction {
            script:
            {
                field.fieldTime = titleAnimation.timeToResetTo;
                controls.keyboardHandler.forceActiveFocus();

                if(_DW_MOBILE) dwLogo.visible = true;

                sceneTitle.animDuration = 300;
            }
        }

        PauseAnimation {
            duration: 500
        }

        ScriptAction {
            script:
            {
                title.x = 427
                titleDecoration.x = -titleDecoration.width
                titleShadow.y = 240
            }
        }

        PauseAnimation {
            duration: sceneTitle.animDuration
        }

        ScriptAction {
            script:
            {
                sceneTitle.visible = false;
                sceneTitle.animDuration = 750;
            }
        }


    }

}

