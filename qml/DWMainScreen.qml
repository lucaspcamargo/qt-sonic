import QtQuick 2.3
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import "ui"

Item {

    id: mainScreen
    anchors.fill: parent

    MouseArea
    {
        id: mouseSetter2
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor
        anchors.fill: parent
    }

    // BEGIN BACKGROUND

    Image
    {
        id: mainMenuBg

        source: resBase + "ui/main/bg.png"
        anchors.fill: parent

        fillMode: Image.Stretch
    }

    Image
    {
        id: mainMenuBgDetail

        source: resBase + "ui/main/bg-detail.png"

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        opacity: 0.3

        NumberAnimation on scale
        {
            from: 1
            to: 1.2
            duration: 20000
            loops: Animation.Infinite
            easing.type: Easing.SineCurve
        }
    }

    Image
    {
        id: mainMenuBgThrob

        source: resBase + "ui/main/bg-throb.png"
        anchors.fill: parent

        fillMode: Image.Stretch

        NumberAnimation on opacity
        {
            from: 0
            to: 0.3
            duration: 10000
            loops: Animation.Infinite
            easing.type: Easing.SineCurve
        }
    }

    Repeater{

        model: 2

        ParticleSystem
        {
            anchors.fill: parent
            opacity: 0.25 + 0.5* mainMenuBgThrob.opacity

            Emitter
            {
                width: parent.width
                height: 32

                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height

                lifeSpan: 3000
                lifeSpanVariation: 1000

                size: 4
                sizeVariation: 2

                emitRate: 15
            }

            Gravity
            {
                magnitude: -200
            }

            Wander
            {
                xVariance: 30
                pace: 50
            }

            /*
            ImageParticle
            {
                sprites: [Sprite{source: resBase + "ui/main/particle.png"; frameWidth: 100; frameHeight: 100; frameX: 100*(index%5); frameY: (index>=5? 100 : 0); frameCount: 1; frameDuration:2000}]
            }*/

            ImageParticle
            {
                source: resBase + ("ui/main/particle-%1.png").arg(index)
                scale: 1.1
            }
        }

    }


    Item
    {
        id: bgTextContainer
        anchors.fill: parent
        visible: false // offscreen

        Text
        {
            id: bgText
            text: "SONIC THE HEDGEHOG DW · SONIC THE HEDGEHOG DW · "
            font.family: globalResources.dwFont.name
            font.pixelSize: 64
            color: "#0dffffff"

            y: 156-8


            NumberAnimation {
                target: bgText
                property: "x"
                duration: 10000
                easing.type: Easing.Linear
                from: 0
                to: -bgText.width/2
                loops: Animation.Infinite
                running: true
            }

        }

        Text
        {
            id: bgText2
            text: "HEDGEHOG DW · SONIC THE HEDGEHOG DW · SONIC THE "
            font.family: globalResources.dwFont.name
            font.pixelSize: 96
            color: "#0affffff"

            y: 32-8


            NumberAnimation {
                target: bgText2
                property: "x"
                duration: 9000
                easing.type: Easing.Linear
                from: 0
                to: -bgText2.width/2
                loops: Animation.Infinite
                running: true
            }

        }
        Text
        {
            id: bgText3
            text: "HOG DW · SONIC THE HEDGEHOG DW · SONIC THE HEDGE"
            font.family: globalResources.dwFont.name
            font.pixelSize: 128
            color: "#10ffffff"

            y: 64-8


            NumberAnimation {
                target: bgText3
                property: "x"
                duration: 30000
                easing.type: Easing.Linear
                from: 0
                to: -bgText3.width/2
                loops: Animation.Infinite
                running: true
            }

        }

    }

    FastBlur
    {
        anchors.fill: parent
        source: bgTextContainer
        radius: 16
    }

    Audio
    {
        id: mainScreenBgm
        source: resBase + "music/main-alt.ogg"
        loops: Audio.Infinite
        Behavior on volume { NumberAnimation { easing.type: Easing.Linear; duration: 800; } }

    }

    Audio
    {
        id: titleBgm

        source: resBase + "music/title.ogg"
        loops: Audio.Infinite
        autoPlay: true

    }


    // END BACKGROUND
    // BEGIN CONTENT


    StackView
    {
        id: mainStackView

        anchors.fill: parent
        initialItem: Qt.resolvedUrl("ui/DWTitleScreen.qml")

        onCurrentItemChanged: if(currentItem) currentItem.forceActiveFocus();

    }

    // back button
    DWUIButton
    {
        text: "Back"

        opacity: ( _DW_MOBILE && (mainStackView.depth > 2) && mainStackView.currentItem.backButton)? 1 : 0
        Behavior on opacity { NumberAnimation{}}
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16

        onClicked: goBack()
    }


    Row
    {
        height: 12
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 13
        anchors.leftMargin: 20
        visible: true

        Repeater
        {
            model: (_DW_MOBILE)? 0 : mainStackView.currentItem.buttonInstructions.length

            DWUIButtonInstruction
            {
                button: mainStackView.currentItem.buttonInstructions[index][0]
                label: mainStackView.currentItem.buttonInstructions[index][1]
            }
        }
    }

    Component.onCompleted:
    {
        dwLogo.visible = true
        offscreen = false;
        globalFader.opacity = 0
        forceActiveFocus()
    }

    DWSoundEffect
    {
        id: selectSfx
        source: resBase + "ui/sfx/select.wav.ogg"
    }

    DWSoundEffect
    {
        id: cancelSfx
        source: resBase + "ui/sfx/cancel.wav.ogg"
    }

    DWSoundEffect
    {
        id: changeSfx
        source: resBase + "ui/sfx/change.wav.ogg"
    }

    function stack(url, details)
    {
        mainStackView.push(url, details);
    }

    function fade()
    {

        globalFader.opacity = 1;
        mainScreenBgm.volume = 0;
        fadeTimer.running = true;
    }

    Timer
    {
        id: fadeTimer
        interval: 1000
        repeat: false
        onTriggered: fadeAction()
    }

    property var fadeAction: null

    Keys.onEscapePressed: {goBack(); event.accepted = true;}
    Keys.onBackPressed: {goBack(); event.accepted = true;}
    Keys.onPressed: { if(event.key !== Qt.Key_Z) return; goBack(); event.accepted = true; }

    function goBack(){

        if(mainStackView.depth > 2)
        {
            mainStackView.pop();
            cancelSfx.play();
        }


    }

}

