import QtQuick 2.0
import ".."
import "../.."

AnimatedSprite
{
    id: shield
    source: "fx/shield-1.png"
    interpolate: false
    running: visible
    width: 48
    height: 48
    frameWidth: width
    frameHeight: height
    frameCount: 12
    frameDuration: 2*16.66666666
    smooth: false
    visible: false

    opacity: visible? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 100 } }

    scale: visible? 1 : 3
    Behavior on scale { NumberAnimation { duration: 100 } }


    x: - ( player.x - Math.round(player.x)) - width/2
    y: - ( player.y - Math.round(player.y)) - height/2
    z: 1

    onCurrentFrameChanged: if(currentFrame == 0) z = -z;

    transform: Rotation{
        origin.x: shield.width/2
        origin.y: shield.height
        axis{ x:0; y:1; z:0 }
        angle: ( shield.z < 0 )? 0 : 180
    }

/*
    NumberAnimation on opacity
    {
        id: shieldFlasherAnimation
        running: false

        duration: 500
        from: 1.0
        to: 0.75
    }
*/

    function action()
    {
        parent.ySpeed = convertGenesisSpeed(-5.5);
        eshieldUseSfx.play();
        //shieldFlasherAnimation.running = true;

        sparkAnimRunning = false;
        sparkAnimRunning = true;
    }

    function playWaterLossSfx()
    {
        eshieldWaterSfx.play();
    }

    DWSoundEffect
    {
        id: eshieldUseSfx
        source: "../sfx/eshield-use.wav"
    }

    DWSoundEffect
    {
        id: eshieldWaterSfx
        source: "../sfx/eshield-water.wav"
        gain: 50
    }

    property bool sparkAnimRunning: false

    Repeater
    {
        model: 4
        AnimatedSprite
        {
            id: sparkSprite

            source: "fx/shield-1-spark.png"
            interpolate: false
            running: visible
            width: 16
            height: 16
            frameWidth: width
            frameHeight: height
            frameCount: 2
            frameDuration: 16
            visible: parent == field
            opacity: 0.75

            SequentialAnimation
            {
                running: sparkAnimRunning

                ScriptAction
                {
                    script:
                    {
                        sparkSprite.parent = field;
                        sparkSprite.x = player.x - 8;
                        sparkSprite.y = player.y;
                    }
                }

                ParallelAnimation
                {

                    NumberAnimation {
                        target: sparkSprite
                        property: "x"
                        duration: 300
                        to: player.x - 8 + (index > 1? 64: -64)
                    }

                    NumberAnimation {
                        target: sparkSprite
                        property: "y"
                        duration: 300
                        to: player.y + (index % 3? 96: -16)
                    }
                }


                ScriptAction
                {
                    script:
                    {
                        sparkSprite.parent = shield;
                    }
                }
            }

        }
    }
}

