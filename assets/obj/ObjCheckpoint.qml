import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject {

    id: checkpoint

    width: 16
    height: 64

    z: field.objBZ
    property bool activated: false


    AnimatedSprite{

        id: sprite

        source: "spr/checkpoint-new.png"
        x: -4
        width: 24
        height: 64
        frameWidth: width
        frameHeight: height
        frameCount: 1
        frameDuration: convertGenesisTime(4) * 1000
        interpolate: false
    }

    DWEveryFrame
    {
        enabled: active

        onUpdate:
        {
            if(!activated)
            {
                if( overlapI( checkpoint, playerCollision ) )
                {
                    activated = true;
                    fieldController.checkpoint(x + width/2, y + height - player.playerHalfHeight);

                    sfx.play();
                }
            }

        }
    }

    SequentialAnimation
    {
        running: activated

        ScriptAction
        {
            script: sprite.frameCount = 8;
        }


        PauseAnimation {
            duration: 8 * sprite.frameDuration
        }

        ScriptAction
        {
            script: { sprite.frameCount = 2; sprite.frameX = 8 * 24; }
        }
    }

    DWSoundEffect
    {
        id: sfx
        source: "sfx/checkpoint.wav.ogg"
    }
}

