import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject {

    id: monitor

    width: 28
    height: 32
    z: field.objBZ

    property string originalType: "rings"
    property string type: "rings"
    property string effect: type
    property bool solid: type !== "destroyed"

    function morph( opts )
    {
        if(opts.length)
        {
            type = opts[0];
            originalType = type;
        }
    }

    function reset()
    {
        type = originalType;
        effectIcon.x = monitor.x + 6
        effectIcon.y = monitor.y + 4
        effectIcon.opacity = 1
        effectIcon.visible = false
        effectIconRotation.angle = 0
    }

    Component.onCompleted: field.resetted.connect(reset);
    //Component.onDestroyed: field.resetted.disconnect(reset);

    DWSprite
    {
        id: sprite
        spritesheet: resBase + "obj/obj-common.dws?monitor"
        sequence: solid? "monitor" : (Math.random() > 0.5? "monitor-destroyed1" : "monitor-destroyed2")
        anchors.fill: parent
        running: false
    }

    DWImageItem
    {
        id: screen
        width: 16
        height: 14
        x: 6
        y: 4

        visible: type != "destroyed"

        source: solid? resBase + "obj/monitor/monitor-"+effect+".png" : ""
    }


    DWSprite
    {
        id: blinker
        spritesheet: resBase + "obj/obj-common.dws?monitor-blink"
        visible: type != "destroyed"
        width: 16
        height: 14
        x: 6
        y: 4
        running: monitor.visible
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
        Behavior on scale {NumberAnimation{duration: 500}}

        source: effect != "destroyed"? resBase + "obj/monitor/monitor-"+effect+".png" : ""

        transform: Rotation
        {
            id: effectIconRotation
            //origin: Qt.vector3d(0, height/2, 0)
            axis: Qt.vector3d(1, 0, 0)
            angle: 0
            Behavior on angle {NumberAnimation{duration: 500}}

        }
    }

    property bool colliding: false


    DWFOPhysicsBody {
        id: wallsBody
        active: monitor.active && solid
        bodyType: DWFOPhysicsBody.BT_STATIC
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_OBJ_NOT_ROLLING
        shapeCollisionMask: 0xff
        shapeData: Qt.vector4d(14, 16, 0, 0)
        origin: Qt.point(14, 16)

        Component.onCompleted: rebuildBody();
    }

    DWFOPhysicsBody {
        id: collisionBody
        active: monitor.active && solid
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(13, 15, 0, 0)
        origin: Qt.point(14, 16)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        collisionEndCallbackEnabled: true

        onCollision: colliding = true
        onCollisionEnd: colliding = false
    }


    DWSoundEffect
    {
        id: popSfx
        source: resBase + "obj/sfx/pop.wav.ogg"
    }
    DWSoundEffect
    {
        id: ringSfx
        source: resBase + "obj/sfx/ring.wav.ogg"
    }
    DWSoundEffect
    {
        id: shieldSfx
        source: resBase + "obj/sfx/shield.wav.ogg"
    }
    DWSoundEffect
    {
        id: eshieldSfx
        source: resBase + "obj/sfx/eshield.wav.ogg"
    }
    DWSoundEffect
    {
        id: fshieldSfx
        source: resBase + "obj/sfx/fshield.wav.ogg"
    }

    DWEveryFrame
    {
        id: updater
        enabled: active

        onUpdate:
        {

            if(colliding && solid && player.playerRolling /*&& player.ySpeed >= 0*/ )
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
                effectIcon.scale = 1.25
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
            script: {ringSfx.play(); fieldController.rings++}
        }

        PauseAnimation {
            duration: 50
        }

    }

}
