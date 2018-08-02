import QtQuick 2.4

Item {

    id: fieldController

    property bool paused: false

    property int score: 0
    property int rings: 0

    property bool checkpointReached: false

    property real checkpointFieldTime: 0
    property int checkpointPlayerX: levelData.playerX
    property int checkpointPlayerY: levelData.playerY

    property int previousBGMIndex: -1
    property int drownBGMIndex: -1

    property bool playerDead: false
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
        if(paused)
            paused = false;
        else
            if(!playerDead)
                paused = true;
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

        if(paused)
            dwAnimationUpdater.disableDomain(1); // field domain
        else
            dwAnimationUpdater.enableDomain(1); // field domain
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
        playerDead = true;
        deathAnimation.running = true;

        if(playerDrowning)
        {
            bgmPlayer.getBGM(bgmPlayer.currentBGM).pause();
        }
    }

    SequentialAnimation
    {
        id: deathAnimation

        // stop animations
        ScriptAction {
            script: dwAnimationUpdater.disableDomain(1); //field domain
        }

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
                playerDead = false;

                if(checkpointReached)
                {
                    field.player.x = checkpointPlayerX;
                    field.player.y = checkpointPlayerY;
                    field.viewCenterAtX = checkpointPlayerX;
                    field.viewCenterAtY = checkpointPlayerY;
                    titleAnimation.timeToResetTo = checkpointFieldTime;
                }else
                {
                    field.player.x = levelData.playerX;
                    field.player.y = levelData.playerY;
                    field.viewCenterAtX = levelData.playerX;
                    field.viewCenterAtY = levelData.playerY;
                    field.fieldTime = 0;
                }

                field.player.reset();
                field.reset();

                rings = 0;
                titleAnimation.bgmIndexToPlay = previousBGMIndex;
                titleAnimation.running = true;
                drownOverlay.opacity = 0;

                // reenable animations
                dwAnimationUpdater.enableDomain(1); // field domain
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

    }

    onRedRingsChanged: redRingsDisplayAnim.start();

    Item {
        id: redRingsDisplay
        parent: hud
        z: 10

        width: 84 * redRings.length - 20
        height: 22

        Row {
            anchors.fill: parent
            anchors.margins: 5
            anchors.topMargin: 4
            anchors.bottomMargin: 4
            spacing: 20

            Repeater
            {
                id: rrr
                model: redRings.length

                Image {

                    property bool collected: redRings[index]
                    source: resBase + "ui/hud/red-ring" + (collected? ".png" : "-gray.png")
                    width: 64
                    height: 64
                }
            }
        }

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: paused? 48 : topMarginProxy

        property real topMarginProxy: -32

        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

        opacity: Math.max(anchors.topMargin, 0.0) / 32

        SequentialAnimation
        {
            id: redRingsDisplayAnim

            PauseAnimation {
                duration: 500
            }

            ScriptAction {
                script: redRingsDisplay.topMarginProxy = 48
            }

            PauseAnimation {
                duration: 4500
            }

            ScriptAction {
                script: redRingsDisplay.topMarginProxy = -64
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
