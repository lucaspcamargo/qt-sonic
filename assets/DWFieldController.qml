import QtQuick 2.0

Item {

    property bool paused: false

    property bool checkpointReached: false

    property real checkpointFieldTime: -1
    property int checkpointPlayerX: -1
    property int checkpointPlayerY: -1

    property int previousBGMIndex: -1
    property int drownBGMIndex: -1

    property bool playerDrowning: false

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
                    player.x = checkpointPlayerX;
                    player.y = checkpointPlayerY;
                    titleAnimation.timeToResetTo = checkpointFieldTime;
                }else
                {
                    player.x = levelData.playerX;
                    player.y = levelData.playerY;
                    field.fieldTime = 0;
                }
                player.reset();

                hud.ringsValue = 0;
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
}
