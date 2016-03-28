import QtQuick 2.4
import ".."
import dw 1.0

Item
{
    id: sceneTitle
    anchors.centerIn: parent
    height: 1080
    width: 1920
    scale: parent.height / height

    property int animDuration: _DW_DEBUG? 0 : 1000


    Image
    {
        id: title
        y: -1080

        source: resBase + "ui/titlecards/default-title.png" //Qt.resolvedUrl(resBase + levelData.urlPrefix + "title.png")

        Behavior on y { NumberAnimation { easing.type: Easing.InOutQuart; duration: 1.2*sceneTitle.animDuration } }
    }

    Item
    {
        id: decorationTop
        Image
        {
            source: resBase + "ui/titlecards/top.png"

            NumberAnimation on y{
                duration: 400
                from: 0
                to: -14.559
                easing.type: Easing.Linear
                running: titleAnimation.running
                loops: Animation.Infinite
            }

            NumberAnimation on x{
                duration: 400
                from: 0
                to: -166.408
                easing.type: Easing.Linear
                running: titleAnimation.running
                loops: Animation.Infinite
            }

        }

        y: -350
        x: 0
        Behavior on y { NumberAnimation { easing.type: Easing.InOutQuart; duration: sceneTitle.animDuration } }

    }

    Item
    {
        id: decorationLeft
        Image
        {
            source: resBase + "ui/titlecards/left.png"

            NumberAnimation on y{
                duration: 400
                from: -166.408
                to: 0
                easing.type: Easing.Linear
                running: titleAnimation.running
                loops: Animation.Infinite
            }

            NumberAnimation on x{
                duration: 400
                from: 14.559
                to: 0
                easing.type: Easing.Linear
                running: titleAnimation.running
                loops: Animation.Infinite
            }

        }

        y: -234
        x: -750
        Behavior on x { NumberAnimation { easing.type: Easing.InOutQuart; duration: sceneTitle.animDuration } }

    }

    /*DWTextBitmap
    {
        id: subtitle
        x: 128 + 4
        font: "xexex-multi"
        text: levelData.subtitle.toUpperCase()
        visible: false
    }*/


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
                sceneTitle.animDuration = _DW_DEBUG? 0 : 750;
                globalFader.opacity = 0;
                title.y = 0
                decorationLeft.x = -297
                decorationTop.y = -1
                sceneFader.color = "#04a"
            }
        }

        PauseAnimation {
            duration: sceneTitle.animDuration
        }

        ScriptAction {
            script:
            {
                bgmPlayer.currentBGM = titleAnimation.bgmIndexToPlay;
                bgmPlayer.resetBGM( bgmPlayer.currentBGM >= 0? bgmPlayer.currentBGM : 0 );
            }
        }


        PauseAnimation {
            duration: _DW_DEBUG? 0 : 1500
        }

        ScriptAction {
            script: { sceneFader.opacity = 0;}
        }

        PauseAnimation {
            duration: _DW_DEBUG? 0 : 500
        }

        ScriptAction {
            script:
            {
                field.fieldTime = titleAnimation.timeToResetTo;
                controls.keyboardHandler.forceActiveFocus();

                if(_DW_MOBILE) dwLogo.visible = true;

                sceneTitle.animDuration = _DW_DEBUG? 0 : 300;
            }
        }

        PauseAnimation {
            duration: _DW_DEBUG? 0 : 500
        }

        ScriptAction {
            script:
            {
                title.y = 1080
                decorationLeft.x = -750
                decorationTop.y = -350
            }
        }

        PauseAnimation {
            duration: _DW_DEBUG? 0 : sceneTitle.animDuration
        }

        ScriptAction {
            script:
            {
                sceneTitle.visible = false;
                sceneTitle.animDuration = _DW_DEBUG? 0 : 750;
                sceneFader.color = "#000"
            }
        }


    }

}

