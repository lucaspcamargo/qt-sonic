import QtQuick 2.3
import dw 1.0
import ".."

Item
{
    property alias enabled: updater.enabled

    property real minSpeed: 600
    property real hasWaterWalk: Math.abs(player.xSpeed) > minSpeed
    property int waterYMirror: field.waterY

    property int prefabId: -1

    onHasWaterWalkChanged:
    {
        if(hasWaterWalk)
        {
            if(prefabId < 0)
                prefabId = physicsWorld.addLevelGeomRect((levelData.minBoundaryX + levelData.maxBoundaryX)/2, field.waterY + 8, - levelData.minBoundaryX + levelData.maxBoundaryX, 8, 0, DWFieldPhysicsWorld.CC_WATER_EDGE );
        }else
        {
            if(prefabId >= 0)
            {
                physicsWorld.removeLevelGeom(prefabId);
                prefabId = -1;
            }
        }
    }

    onWaterYMirrorChanged:
    {
        if(prefabId >= 0) physicsWorld.setLevelGeomTransform(prefabId, (levelData.minBoundaryX + levelData.maxBoundaryX)/2, field.waterY + 8);
    }

    DWEveryFrame
    {
        id: updater

        onUpdate:
        {
            if(canSplash && hasWaterWalk && Math.abs(player.y + player.playerHalfHeight - field.waterY ) <= 1 && player.playerState == DWPlayerBase.PS_GROUND)
            {
                var splash = field.createWaterSplash(player.x);
                splash.transformOrigin = Item.Bottom;
                splash.scale = 0.6;
                sfx.play();
                canSplash = false;
            }
        }
    }

    property bool canSplash: true

    Timer
    {
        running: field.fieldActive && updater.enabled
        interval: 40
        repeat: true

        onTriggered: canSplash = true
    }

    DWSoundEffect
    {
        id: sfx
        source: "water-walk/water-walk.wav.ogg"
        gain: 0.25
    }
}

