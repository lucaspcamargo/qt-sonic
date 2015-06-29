import QtQuick 2.4
import dw 1.0


DWFieldObject
{
    id: harmful
    width: 64
    height: 64
    sizeMatters: true
    z: field.objAZ

    Component.onCompleted: objManager.updateObjects.connect(update);
    onActivated: objManager.updateObjects.connect(update);
    onDeactivated: objManager.updateObjects.disconnect(update);
    Component.onDestruction: objManager.updateObjects.disconnect(update);

    DWFOPhysicsBody {
        id: physicsBody
        active: harmful.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(harmful.width/2, harmful.height/2, 0, 0)
        origin: Qt.point(harmful.width/2, harmful.height/2)

        collisionCallbackEnabled: true

        onCollision: {

            if(collider)
                if(collider.fieldObject)
                    if(!collider.fieldObject.playerInvincible)
                        collider.fieldObject.getHit(harmful.x + harmful.width/2, harmful.y + harmful.height / 2);

        }
    }

    function buildPhysicsBody()
    {
        physicsBody.rebuildBody();
    }

}
