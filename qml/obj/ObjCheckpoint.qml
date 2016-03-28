import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject {

    id: checkpoint

    width: 16
    height: 64

    z: field.objBZ
    property bool activated: false


    DWSprite{

        id: sprite

        spritesheet: resBase + "obj/obj-common.dws"
        sequence: activated? "checkpoint-activated" : "checkpoint"
        x: -4
        width: 24
        height: 64
    }

    DWFOPhysicsBody {
        id: collisionBody
        active: checkpoint.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(8, 32, 0, 0)
        origin: Qt.point(8, 32)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true

        onCollision:
        {
            if(!activated)
            {

                activated = true;
                fieldController.checkpoint(x + width/2, y + height - player.playerHalfHeight);

                sfx.play();

            }
        }
    }

    DWSoundEffect
    {
        id: sfx
        source: resBase + "obj/sfx/checkpoint.wav.ogg"
    }
}

