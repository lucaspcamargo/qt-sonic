import QtQuick 2.4
import ".."
import "../.."

import dw 1.0

DWSprite
{
    id: shield
    spritesheet: resBase + "obj/player/fx.dws?shield-3-fg"
    running: visible
    width: 48
    height: 48
    visible: false

    opacity: visible? 0.75 : 0
    Behavior on opacity { NumberAnimation { duration: 100 } }

    scale: visible? 1 : 3
    Behavior on scale { NumberAnimation { duration: 100 } }

    z: 1


    DWSprite
    {
        id: shieldBg
        spritesheet: resBase + "obj/player/fx.dws?shield-3-bg"
        parent: player
        running: shield.running
        width: 48
        height: 48
        visible: shield.visible
        opacity: shield.opacity
        scale: shield.scale
        z: -1
    }


    function update()
    {
        x = - ( player.x - Math.round(player.x)) - width/2;
        y = - ( player.y - Math.round(player.y)) - height/2;
        shieldBg.x = - ( player.x - Math.round(player.x)) - width/2;
        shieldBg.y = - ( player.y - Math.round(player.y)) - height/2;
    }

    function action()
    {
        player.xSpeed = convertGenesisSpeed(player.turnedBack? -10 : 10);
        player.ySpeed = 0;

        fshieldUseSfx.play();
        flare.visible = true;
    }

    function playWaterLossSfx()
    {
        fshieldWaterSfx.play();
    }

    DWSoundEffect
    {
        id: fshieldUseSfx
        source: resBase + "obj/sfx/fshield-use.wav.ogg"
    }

    DWSoundEffect
    {
        id: fshieldWaterSfx
        source: resBase + "obj/sfx/fshield-water.wav.ogg"
        gain: 50
    }

    DWSprite
    {
        id: flare
        spritesheet: resBase + "obj/player/fx.dws?shield-3-flare"
        running: visible
        width: 80
        height: 48
        visible: false

        opacity: 1
        scale: 1.2

        x: -16

        Timer
        {
            running: flare.visible
            interval: 250
            onTriggered: flare.visible = false;
        }

        onVisibleChanged: if(visible) shield.z = 1;
    }

    transform: Rotation{

        origin.x: sprite.width/2
        origin.y: sprite.height
        axis{ x:0; y:1; z:0 }
        angle: (player.turnedBack )? 180 : 0
    }

}

