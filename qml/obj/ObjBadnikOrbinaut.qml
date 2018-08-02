import QtQuick 2.4
import dw 1.0
import ".."

ObjBadnikBase {

    id: badnik

    gibsEnabled: true
    gibCount: 6
    gibLocation: resBase + "obj/badnik/default/gib-%1.png"

    property real masterAngle: 0

    DWSprite{
        id: sprite
        spritesheet: resBase + "obj/badniks-common.dws?orbinaut-body"
        running: badnik.visible
    }


    DWSprite{
        id: b1
        spritesheet: resBase + "obj/badniks-common.dws?orbinaut-spike"
        running: badnik.visible
    }

    DWSprite{
        id: b2
        spritesheet: resBase + "obj/badniks-common.dws?orbinaut-spike"
        running: badnik.visible
    }

    DWSprite{
        id: b3
        spritesheet: resBase + "obj/badniks-common.dws?orbinaut-spike"
        running: badnik.visible
    }

    DWSprite{
        id: b4
        spritesheet: resBase + "obj/badniks-common.dws?orbinaut-spike"
        running: badnik.visible
    }

    DWFOPhysicsBody {
        id: physicsBody
        active: badnik.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER | DWFieldPhysicsWorld.CC_DYNAMIC
        shapeData: Qt.vector4d(16, 16, 0, 0)
        origin: Qt.point(16, 16)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        onCollision: {
            colliding = true;
        }

        collisionEndCallbackEnabled: true
        onCollisionEnd: {
            colliding = false;
        }
    }

    property bool colliding: false

    DWEveryFrame
    {
        id: updater
        enabled: badnik.active
        onUpdate:
        {

            masterAngle += dt

            var xc = 10
            var yc = 10

            var b1a = masterAngle
            var b2a = masterAngle + Math.PI * 0.5
            var b3a = masterAngle + Math.PI
            var b4a = masterAngle + Math.PI * 1.5

            b1.x = xc + Math.cos(b1a)*20 - 8
            b1.y = yc + Math.sin(b1a)*20 - 8
            b1.rotation = 10*Math.sin(4*masterAngle)

            b2.x = xc + Math.cos(b2a)*20 - 8
            b2.y = yc + Math.sin(b2a)*20 - 8
            b2.rotation = 10*Math.sin(5*masterAngle+1)

            b3.x = xc + Math.cos(b3a)*20 - 8
            b3.y = yc + Math.sin(b3a)*20 - 8
            b3.rotation = 10*Math.sin(4*masterAngle+2)

            b4.x = xc + Math.cos(b4a)*20 - 8
            b4.y = yc + Math.sin(b4a)*20 - 8
            b4.rotation = 10*Math.sin(5*masterAngle+3)

            if(colliding)
            {
                if(player.playerRolling || player.playerHarmful)
                {
                    reboundPlayer();
                    pop();
                }
                else
                {
                    hitPlayer();
                }
            }
        }
    }

    property real xDelta: 0
    property real previousXDelta: 0

    SequentialAnimation on xDelta
    {
        loops: Animation.Infinite
        NumberAnimation { to: -32; duration: 1750 + Math.random()*250; }
        NumberAnimation { to: +32; duration: 1750 + Math.random()*250; }
    }
}
