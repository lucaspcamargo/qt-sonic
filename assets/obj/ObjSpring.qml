import QtQuick 2.0
import dw 1.0
import ".."

Item {

    id: spring

    width: 32
    height: 16
    z: field.objAZ

    property bool yellow: false
    property bool notStub: true
    property bool setRot: true
    property bool vertical: rotation == 0 || rotation == 180
    property bool reversed: rotation == 270 || rotation == 180

    property int openFrames: 0
    property int managerIndex: -1
    property alias active: updater.enabled
    visible: updater.enabled
    function activate(){ objManager.objCount++; updater.enabled = true; }
    function deactivate(){ objManager.objCount--; updater.enabled = false; }

    function morph( opts )
    {
        if(opts.indexOf("y") >= 0)
        {
            yellow = true;
        }
        else yellow = false;
    }

    Image
    {
        id: sprite
        source: yellow? "obj/spring-y.png" : "obj/spring.png"
        anchors.fill: parent
        visible: openFrames == 0
    }

    Image
    {
        id: openSprite
        source: yellow? "spr/spring-y-open.png" : "spr/spring-open.png"
        visible: openFrames > 0
        y: -16
    }


    DWSoundEffect
    {
        id: springSfx
        source: yellow? "sfx/spring.wav.ogg" : "sfx/spring2.wav.ogg"
    }

    DWEveryFrame
    {
        id: updater
        onUpdate:
        {

            if(openFrames > 0)
            {
                openFrames = Math.max(openFrames - 1, 0);
            }

            if(overlapPlayerI(spring) && player.currentAnimation != "spring" && height != 32)
            {
                // reset before applying our own maybe
                player.resetControlLocks();

                if(vertical)
                {
                    player.playerState = DWPlayerBase.PS_AIR;
                    player.ySpeed = convertGenesisSpeed(yellow? -10 : -16) * (reversed? -1 : 1);
                    player.gAngle = 0;
                }else
                {
                    player.setHorizontalControlLock(0.2);
                    if(player.playerState == DWPlayerBase.PS_AIR)
                        player.xSpeed = convertGenesisSpeed(yellow? 10 : 16) * (reversed? -1 : 1);
                    else
                        player.gSpeed = convertGenesisSpeed(yellow? 10 : 16) * (reversed? -1 : 1) * (player.playerQuadMode !== 0? -1 : 1);
                    player.turnedBack = reversed;

                }
                if(player.playerState == DWPlayerBase.PS_AIR)
                {
                    player.setAnimation("spring");
                }
                player.playerRolling = false;
                player.playerJumping = false;
                springSfx.play();

                openFrames = 4;
            }
        }
    }
}
