import QtQuick 2.4
import dw 1.0
import ".."


DWFieldObject {
    id: spikes
    property int prefabId: -1

    rotationMatters: true
    width: 32
    height: 32
    z: field.objAZ


    property bool vertical: rotation == 0 || rotation == 180
    property bool reversed: rotation == 270 || rotation == 180

    Item
    {
        id: collision
        x: parent.x + (vertical? (reversed? -2 : 2) : 0)
        y: parent.y + (!vertical? (reversed? -2 : 2) : 0)
        width: vertical? 27 : 32
        height: vertical? 32 : 27
    }

    DWImageItem{
        source: resBase + "obj/obj/spikes-hd.png"
        width: 32
        height: 32
    }

    Component.onCompleted: objManager.updateObjects.connect(update);
    onActivated: objManager.updateObjects.connect(update);
    onDeactivated: objManager.updateObjects.disconnect(update);
    Component.onDestruction: {
        objManager.updateObjects.disconnect(update);
        if(prefabId > 0) physicsWorld.removeLevelGeom(prefabId);
    }

    function update(dt)
    {

        if(prefabId < 0)
        {
            if(vertical)
                prefabId = physicsWorld.addLevelGeomRect(x + 15.5, y + (reversed? -2 : 2) + 15, 15.5, 15, 0, DWFieldPhysicsWorld.CC_LAYER_A | DWFieldPhysicsWorld.CC_LAYER_B);
            else
                prefabId = physicsWorld.addLevelGeomRect(x + (reversed? -2 : 2) + 15, y + 15.5, 15, 15.5, 0, DWFieldPhysicsWorld.CC_LAYER_A | DWFieldPhysicsWorld.CC_LAYER_B);
        }

        if(overlapPlayerI(collision) && !player.playerInvincible )
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

