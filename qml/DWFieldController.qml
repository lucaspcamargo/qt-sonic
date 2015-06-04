import QtQuick 2.4

Item {

    id: fieldController

    property bool paused: false

    property int rings: 0

    property bool checkpointReached: false

    property real checkpointFieldTime: -1
    property int checkpointPlayerX: -1
    property int checkpointPlayerY: -1

    property int previousBGMIndex: -1
    property int drownBGMIndex: -1

    property bool playerDrowning: false

    property var redRingsRef: []
    property var redRings: [false, false, false, false, false]

    property bool hasHundredRingRedRing: false

    onRingsChanged: {

        if(!hasHundredRingRedRing)
        {
            if(rings >= 100)
            {
                hasHundredRingRedRing = true;
                var buf = redRings;
                buf[redRings.length-1] = true;
                redRings = buf;
                redRingSfx.play();
            }
        }
    }

    Component.onCompleted:
    {
        controls.enterPressed.connect(togglePause);
        rootWindow.logoPressed.connect(togglePause);
        drownBGMIndex = bgmPlayer.addBGM("field-drowning.ogg", false, false);
    }

    function togglePause()
    {
        paused = !paused;
    }

    onPausedChanged:
    {
        var bgm = bgmPlayer.getBGM(bgmPlayer.currentBGM);

        if(paused)
            bgm.pause();
        else
            bgm.play();

        pauseSfx.play();

        field.fieldActive = !paused;
    }

    function checkpoint(x, y)
    {
        checkpointReached = true;
        checkpointFieldTime = field.fieldTime;
        checkpointPlayerX = x;
        checkpointPlayerY = y;
    }

    function playerDied()
    {
        deathAnimation.running = true;

        if(playerDrowning)
        {
            bgmPlayer.getBGM(bgmPlayer.currentBGM).pause();
        }
    }

    SequentialAnimation
    {
        id: deathAnimation


        // give player some time to fall down
        PauseAnimation {
            duration: 2500
        }

        // player is out of screen
        // start fade and stop music
        // clear drowning state
        ScriptAction
        {
            script:
            {
                controls.keyboardHandler.focus = false;
                sceneFader.opacity = 1.0
                playerDrowning = false;
                previousBGMIndex = bgmPlayer.currentBGM;
                bgmPlayer.currentBGM = -1;
            }
        }

        // wait for fades
        PauseAnimation {
            duration: 1500
        }

        // all black, lets reset
        ScriptAction
        {
            script:
            {

                if(checkpointReached)
                {
                    field.player.x = checkpointPlayerX;
                    field.player.y = checkpointPlayerY;
                    titleAnimation.timeToResetTo = checkpointFieldTime;
                }else
                {
                    field.player.x = levelData.playerX;
                    field.player.y = levelData.playerY;
                    field.fieldTime = 0;
                }
                field.player.reset();
                field.reset();

                fieldController.rings = 0;
                titleAnimation.bgmIndexToPlay = previousBGMIndex;
                titleAnimation.running = true;
                drownOverlay.opacity = 0;
            }
        }
    }

    onPlayerDrowningChanged: {

        if(playerDrowning)
        {
            drownOverlayAnim.start();
            previousBGMIndex = bgmPlayer.currentBGM;
            bgmPlayer.currentBGM = drownBGMIndex;
        }else{
            drownOverlayAnim.stop();
            if(!deathAnimation.running)drownOverlay.opacity = 0;
            bgmPlayer.getBGM(drownBGMIndex).stop();
            bgmPlayer.currentBGM = previousBGMIndex;
            bgmPlayer.getBGM(drownBGMIndex).rewind();
        }
    }

    Rectangle {
        id: pauseOverlay
        parent: hud

        color: "#80000000"
        anchors.fill: parent
        visible: paused && !_DW_DEBUG

        Image {
            source: resBase + "field/fx/drown-overlay.png"
            anchors.fill: parent
        }

        DWTextBitmap
        {
            anchors.centerIn: parent
            text: "PAUSE"
            spacing: 2
        }

    }

    onRedRingsChanged: redRingsDisplayAnim.start();

    Item {
        id: redRingsDisplay
        parent: hud
        z: 10

        width: 7 + 17 * redRings.length
        height: 22

        Rectangle {color: "#A0000000"; opacity: 1.0; anchors.fill: parent; radius: height/2; border.color: "white"; border.width: 1 }

        Row {
            anchors.fill: parent
            anchors.margins: 5
            anchors.topMargin: 4
            anchors.bottomMargin: 4
            spacing: 3

            Repeater
            {
                id: rrr
                model: redRings.length

                Image {

                    property bool collected: redRings[index]
                    source: resBase + "ui/hud/red-ring" + (collected? ".png" : "-gray.png")
                }
            }
        }

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: paused? 8 : topMarginProxy

        property real topMarginProxy: -22

        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        SequentialAnimation
        {
            id: redRingsDisplayAnim

            PauseAnimation {
                duration: 500
            }

            ScriptAction {
                script: redRingsDisplay.topMarginProxy = 8
            }

            PauseAnimation {
                duration: 4500
            }

            ScriptAction {
                script: redRingsDisplay.topMarginProxy = -22
            }

        }

    }



    DWSoundEffect {
        id: pauseSfx
        source: resBase + "field/sfx/pause.ogg"
    }

    DWSoundEffect
    {
        id: redRingSfx
        source: resBase + "obj/sfx/redring.wav.ogg"
    }


}
