import QtQuick 2.0
import ".."
import dw 1.0

DWFieldObject {

    id: dash
    width: 16
    height: 64

    property bool cooldown: false

    DWSprite {

        id: front
        spritesheet: resBase + "obj/obj-common.dws?dashring-front"

    }

    DWSprite {

        id: back
        spritesheet: resBase + "obj/obj-common.dws?dashring-back"
        parent: field
        x: dash.x
        y: dash.y
        z: field.objBZ
        rotation: dash.rotation
        scale: front.scale
    }

    DWSprite {

        id: frontGhost
        spritesheet: resBase + "obj/obj-common.dws?dashring-front"
        opacity: 0.5*(2.0-scale)
        scale: 2
    }

    DWSprite {

        id: backGhost
        spritesheet: resBase + "obj/obj-common.dws?dashring-back"
        parent: field
        x: dash.x
        y: dash.y
        z: field.objBZ
        rotation: dash.rotation
        scale: frontGhost.scale
        opacity: frontGhost.opacity
    }

    NumberAnimation {
        id: dashAnim
        target: front
        property: "scale"
        duration: 2000
        easing.type: Easing.OutElastic
        from: 0.5
        to: 1
    }

    SequentialAnimation
    {
        id: ghostAnim

        NumberAnimation {
            target: frontGhost
            property: "scale"
            duration: 150
            easing.type: Easing.Linear
            from: 1
            to: 3
        }

    }

    DWFOPhysicsBody {
        id: physicsBody
        active: dash.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER | DWFieldPhysicsWorld.CC_DYNAMIC
        shapeData: Qt.vector4d(1, 16, 0, 0)
        origin: Qt.point(8, 32)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        onCollision: {
            fling();
        }
    }

    function fling()
    {
        if(player.playerState == DWPlayerBase.PS_AIR)
        {
            player.xSpeed = Math.max(player.xSpeed, 10*60);
            player.ySpeed = 0;
        }
        else
        {
            player.gSpeed = Math.max(player.gSpeed, 10*60);
        }

        dashAnim.start();
        ghostAnim.start();
        sfx.play();
        sfx2.play();
    }


    DWSoundEffect
    {
        id: sfx
        source: resBase + "obj/sfx/zipper.wav.ogg"
    }


    DWSoundEffect
    {
        id: sfx2
        source: resBase + "obj/sfx/bumper-cd.wav.ogg"
    }

    Timer {
        running: cooldown
        interval: 300
        onTriggered: cooldown = false
    }
}
