import QtQuick 2.4
import dw 1.0
import ".."

ObjBadnikBase {

    id: badnik

    gibsEnabled: true
    gibCount: 6
    gibLocation: resBase + "obj/badnik/default/gib-%1.png"

    Image{
        id: sprite
        source: resBase + "obj/obj/badnik.png"
        smooth: false
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
            if(previousXDelta - xDelta) sprite.mirror = (previousXDelta - xDelta > 0);
            x += previousXDelta - xDelta;
            previousXDelta = xDelta;

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
