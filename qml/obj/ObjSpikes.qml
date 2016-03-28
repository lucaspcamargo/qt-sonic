import QtQuick 2.4
import dw 1.0
import ".."


DWFieldObject {
    id: spikes

    rotationMatters: true
    width: 32
    height: 32
    z: field.objAZ

    property bool colliding: false

    DWFOPhysicsBody {
        id: wallsBody
        active: spikes.active
        bodyType: DWFOPhysicsBody.BT_STATIC
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_LAYERS
        shapeCollisionMask: 0xff
        shapeData: Qt.vector4d(16, 16, 0, 0)
        origin: Qt.point(16, 16)

        Component.onCompleted: rebuildBody();
    }

    DWFOPhysicsBody {
        id: collisionBody
        active: spikes.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(13, 17, 0, 0)
        origin: Qt.point(16, 16)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        collisionEndCallbackEnabled: true

        onCollision: colliding = true
        onCollisionEnd: colliding = false
    }

    DWSprite{
        spritesheet: resBase + "obj/obj-common.dws?spikes"
        running: false
    }

    Component.onCompleted: objManager.updateObjects.connect(update);
    onActivated: objManager.updateObjects.connect(update);
    onDeactivated: objManager.updateObjects.disconnect(update);
    Component.onDestruction: {
        objManager.updateObjects.disconnect(update);
    }

    function update(dt)
    {
        if(colliding && !player.playerInvincible )
        {
            player.getHit(spikes.x + spikes.width/2, spikes.y + spikes.height / 2);
            spikedSfx.play();
        }
    }

    DWSoundEffect
    {
        id: spikedSfx
        source: resBase + "obj/sfx/spiked.wav.ogg"
    }
}

