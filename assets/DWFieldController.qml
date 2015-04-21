import QtQuick 2.0

Item {

    property bool paused: false

    property bool checkpointReached: false

    property real checkpointFieldTime: -1
    property int checkpointPlayerX: -1
    property int checkpointPlayerY: -1

    property int previousBGMIndex: -1
    property int drownBGMIndex: -1

    Component.onCompleted:
    {
        controls.enterPressed.connect(togglePause);
        rootWindow.logoPressed.connect(togglePause);
        drownBGMIndex = bgmPlayer.addBGM("field-drowning-sa.mp3.ogg", false);
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
    }    

    SequentialAnimation
    {
        id: deathAnimation

        PauseAnimation {
            duration: 2000
        }

        ScriptAction
        {
            script:
            {
                controls.keyboardHandler.focus = false;
                sceneFader.opacity = 1.0
                previousBGMIndex = bgmPlayer.currentBGM;
                bgmPlayer.currentBGM = -1;
            }
        }


        PauseAnimation {
            duration: 1500
        }

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
            }
        }
    }
}

