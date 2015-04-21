import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject {

    id: monitor

    width: 28
    height: 32
    z: field.objBZ

    property string type: "rings"
    property string effect: type
    property int prefabId: -1

    function morph( opts )
    {
        if(opts.length)
        {
            type = opts[0];
        }
    }

    AnimatedSprite
    {
        id: sprite
        source: "obj/monitor-"+type+".png"
        anchors.fill: parent
        running: visible
    }

    AnimatedSprite
    {
        id: blinker
        source: "spr/monitor-blink.png"
        visible: type != "destroyed"
        width: 28
        height: 32
        frameWidth: width
        frameHeight: height
        frameCount: 6
        frameDuration: 32
        interpolate: false
        running: visible
    }

    Image
    {
        id: effectIcon
        width: 16
        height: 14
        parent: field
        x: monitor.x + 6
        y: monitor.y + 4
        z: field.fgZ

        visible: false

        Behavior on y {NumberAnimation{duration: 500}}
        Behavior on opacity {SequentialAnimation{PauseAnimation{duration: 500+200} NumberAnimation{duration: 500}}}

        source: effect != "destroyed"? "spr/monitor-icon-"+effect+".png" : ""

        transform: Rotation
        {
            id: effectIconRotation
            //origin: Qt.vector3d(0, height/2, 0)
            axis: Qt.vector3d(1, 0, 0)
            angle: 0
            Behavior on angle {NumberAnimation{duration: 500}}

        }
    }


    DWSoundEffect
    {
        id: popSfx
        source: "sfx/pop.wav.ogg"
    }
    DWSoundEffect
    {
        id: ringSfx
        source: "sfx/ring.wav.ogg"
    }
    DWSoundEffect
    {
        id: shieldSfx
        source: "sfx/shield.wav.ogg"
    }
    DWSoundEffect
    {
        id: eshieldSfx
        source: "sfx/eshield.wav.ogg"
    }
    DWSoundEffect
    {
        id: fshieldSfx
        source: "sfx/fshield.wav.ogg"
    }

    DWEveryFrame
    {
        id: updater
        enabled: active

        onUpdate:
        {
            if( prefabId < 0 && type != "destroyed" )
            {
                prefabId = physicsWorld.addLevelGeomRect(x + 14, y + 16, 12, 16, 0, DWFieldPhysicsWorld.CC_OBJ_NOT_ROLLING);
            }

            if(overlapPlayerI(monitor) && type != "destroyed" && player.playerRolling /*&& player.ySpeed >= 0*/ )
            {
                field.createExplosion(x+14, y+16);

                if((player.y > monitor.y + 16) || player.ySpeed < 0)
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

                effect = type; // unbind
                effectAnimation.running = true;

                popSfx.play();
                type = "destroyed";
                if( prefabId >= 0 )
                {
                    physicsWorld.removeLevelGeom(prefabId);
                }
            }
        }
    }

    SequentialAnimation
    {
        id: effectAnimation
        running: false

        ScriptAction
        {
            script:
            {
                effectIcon.visible = true;
                effectIcon.opacity = 0;
                effectIcon.y -= 32;
                effectIconRotation.angle = 360
            }
        }

        PauseAnimation {
            duration: 500
        }

        ScriptAction
        {
            script:
            {

                if( effect == "rings" )
                {
                    ringSfxPlayer.start();
                }else if( effect == "shield" )
                {
                    player.shieldType = 0;
                    player.hasShield = true;
                    shieldSfx.play();
                }else if( effect == "eshield" )
                {
                    player.shieldType = 1;
                    player.hasShield = true;
                    eshieldSfx.play();
                }else if( effect == "hshield" )
                {
                    player.shieldType = 2;
                    player.hasShield = true;
                    shieldSfx.play();
                }else if( effect == "fshield" )
                {
                    player.shieldType = 3;
                    player.hasShield = true;
                    fshieldSfx.play();
                }
            }
        }
    }

    SequentialAnimation
    {
        id: ringSfxPlayer
        loops: 10
        ScriptAction
        {
            script: {ringSfx.play(); hud.ringsValue++}
        }

        PauseAnimation {
            duration: 50
        }

    }

}
