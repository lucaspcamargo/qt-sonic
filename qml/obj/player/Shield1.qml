import QtQuick 2.4
import ".."
import "../.."
import dw 1.0

DWSprite
{
    id: shield
    spritesheet: resBase + "obj/player/fx.dws?shield-1"
    running: visible
    width: 48
    height: 48
    visible: false

    opacity: visible? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 100 } }

    scale: visible? 1 : 3
    Behavior on scale { NumberAnimation { duration: 100 } }


    x: - 24
    y: - 24
    z: 1

    onAnimationLooped: z = -z;

    transform: Rotation{
        origin.x: shield.width/2
        origin.y: shield.height
        axis{ x:0; y:1; z:0 }
        angle: ( shield.z < 0 )? 0 : 180
    }


    function action()
    {
        parent.ySpeed = convertGenesisSpeed(-5.5);
        eshieldUseSfx.play();

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
        source: resBase + "obj/sfx/eshield-use.wav.ogg"
    }

    DWSoundEffect
    {
        id: eshieldWaterSfx
        source: resBase + "obj/sfx/eshield-water.wav.ogg"
        gain: 50
    }

    property bool sparkAnimRunning: false

    Repeater
    {
        model: 4
        DWSprite
        {
            id: sparkSprite

            spritesheet: resBase + "obj/player/fx.dws?shield-1-spark"
            running: visible
            width: 16
            height: 16
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

