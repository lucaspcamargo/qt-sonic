import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject{
    id: ring

    width: 32
    height: 32
    z: field.objAZ

    property bool collected: false


    DWSprite{
        spritesheet: resBase + "obj/obj-common.dws?redring"
        running: ring.visible
    }

    DWFOPhysicsBody {
        id: physicsBody
        active: ring.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_CIRCLE
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER | DWFieldPhysicsWorld.CC_DYNAMIC
        shapeData: Qt.vector4d(16, 16, 0, 0)
        origin: Qt.point(16, 16)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        onCollision: {
            if(!collected)
            {
                if(managerIndex >= 0) objManager.objectDestroyed(managerIndex);
                collected = true;
                collectedTimer.running = true;

                sfx.play();
            }
        }
    }

    DWSoundEffect
    {
        id: sfx
        source: resBase + "obj/sfx/redring.wav.ogg"
    }
    SequentialAnimation
    {
        id: collectedTimer
        running: false

        NumberAnimation {
            target: ring
            property: "scale"
            duration: 750
            from: 1
            to: 0
            easing.type: Easing.InOutQuad

        }

        ScriptAction
        {
            script:
            {

                var tmp = fieldController.redRings;

                for(var i = 0; i < tmp.length; i++)
                {
                    if(tmp[i] === false)
                    {
                        tmp[i] = true;
                        break;
                    }
                }

                fieldController.redRings = tmp;

                ring.destroy();

            }
        }
    }
}
