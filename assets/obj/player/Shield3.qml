import QtQuick 2.0
import ".."
import "../.."

AnimatedSprite
{
    id: shield
    source: "fx/shield-3-fg.png"
    interpolate: false
    running: visible
    width: 48
    height: 48
    frameWidth: width
    frameHeight: height
    frameCount: 9
    frameDuration: 32
    visible: false

    opacity: visible? 0.75 : 0
    Behavior on opacity { NumberAnimation { duration: 100 } }

    scale: visible? 1 : 3
    Behavior on scale { NumberAnimation { duration: 100 } }


    x: - ( player.x - Math.round(player.x)) - width/2
    y: - ( player.y - Math.round(player.y)) - height/2
    z: 1


    AnimatedSprite
    {
        id: shieldBg
        source: "fx/shield-3-bg.png"
        parent: player
        interpolate: false
        running: shield.running
        width: 48
        height: 48
        frameWidth: width
        frameHeight: height
        frameCount: 9
        frameDuration: 32
        visible: shield.visible
        opacity: shield.opacity
        scale: shield.scale

        x: - ( player.x - Math.round(player.x)) - width/2
        y: - ( player.y - Math.round(player.y)) - height/2
        z: -1
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
        source: "../sfx/fshield-use.wav"
    }

    DWSoundEffect
    {
        id: fshieldWaterSfx
        source: "../sfx/fshield-water.wav"
        gain: 50
    }

    AnimatedSprite
    {
        id: flare
        source: "fx/shield-3-flare.png"
        interpolate: false
        running: visible
        width: 80
        height: 48
        frameWidth: width
        frameHeight: height
        frameCount: 5
        frameDuration: 50
        smooth: false
        visible: false

        opacity: 1
        scale: 1.2

        x: -16

        Timer
        {
            running: flare.visible
            interval: flare.frameCount*flare.frameDuration
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

