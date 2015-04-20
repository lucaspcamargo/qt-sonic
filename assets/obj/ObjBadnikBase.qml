import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject {

    id: badnikBase

    width: 32
    height: 32
    z: field.objAZ

    property real radius: 128

    property bool gibsEnabled: false
    property int gibCount: 0
    property var gibShapes: null
    property string gibLocation: ""


    function reboundPlayer()
    {
        if((player.y > badnik.y + 16) || player.ySpeed < 0)
        {
            player.ySpeed -= convertGenesisSpeed(1) * (player.yS > 0? 1 : -1);
        }else
        {
            if(controls.aPressed)
            {
                player.ySpeed *= -1;
                if(player.playerState == DWPlayerBase.PS_AIR)
                    player.playerJumping = true;
            }
            else
            {
                player.ySpeed = Math.max(convertGenesisSpeed(-4), -player.ySpeed);
            }
        }
    }

    function playPopSound()
    {
        popSound.play();
    }

    function pop()
    {
        field.createExplosion(Math.round(x)+width/2, Math.round(y)+height/2);
        field.createFlicky(Math.round(x)+width/2, Math.round(y)+height/2);

        if(gibsEnabled)
        {
            var gibComponent = Qt.createComponent("ObjGib.qml");

            for(var i = 0; i < gibCount; i++ )
            {                
                var fileUrl = Qt.resolvedUrl(gibLocation.arg(i));
                field.createGib({x: badnikBase.x, y: badnikBase.y, source: fileUrl});
            }
        }

        popSound.play();
        if(managerIndex >= 0) objManager.objectDestroyed(managerIndex);
        badnikBase.destroy();


        hud.score += 100;
    }

    function hitPlayer()
    {
        if(!player.playerInvincible) player.getHit(x + width/2, y + height/2);
    }

    DWSoundEffect
    {
        id: popSound
        source: "sfx/pop.wav"
    }
}

