import QtQuick 2.0
import dw 1.0
import ".."


Image {

    id: bumper

    width: 32
    height: 32

    property bool notStub: true
    property int managerIndex: -1
    property alias active: updater.enabled
    visible: updater.enabled
    function activate(){ objManager.objCount++; updater.enabled = true; }
    function deactivate(){ objManager.objCount--; updater.enabled = false; }

    source: "obj/bumper-32.png"


    DWSoundEffect
    {
        id: bumperSfx
        source: "sfx/bumper.wav.ogg"
    }

    DWEveryFrame
    {
        id: updater
        onUpdate:
        {
            if(overlapPlayerI(bumper))
            {
                var spd = convertGenesisSpeed(7);
                var xC = x + width/2;
                var yC = y + height/2;
                var dir = Qt.vector2d(player.x - xC, player.y - yC);
                dir = dir.normalized();
                player.xSpeed = dir.x * spd;
                player.ySpeed = dir.y * spd;
                player.playerState = DWPlayerBase.PS_AIR;
                player.playerJumping = false;
                bumperSfx.play();
                animation.restart();
                //if(!player.playerRolling)player.onAnimationChanged("hurt");
            }
        }
    }


    NumberAnimation on scale
    {
        id: animation
        running: false
        from: 1.5
        to: 1
        duration: 1500
        easing.type: Easing.OutElastic
    }
}
