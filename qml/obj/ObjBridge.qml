import QtQuick 2.4
import dw 1.0
import ".."


Item {
    id: bridge
    property bool notStub: true
    property bool setSize: true
    property int prefabId: -1
    property int managerIndex: -1
    property alias active: updater.enabled
    visible: updater.enabled
    function activate(){ objManager.objCount++; updater.enabled = true; }
    function deactivate(){ objManager.objCount--; updater.enabled = false; }

    property int logCount: Math.round(width/16)
    property real depressionAmount: 0
    property real depressionAlpha: playerOnTop? 1 : 0
    property bool playerOnTop: false
    property real alpha: 0

    Behavior on depressionAlpha { id: depressionAlphaAnim; enabled: false; NumberAnimation { easing.type: Easing.InOutQuart } }

    onPlayerOnTopChanged:
    {
        depressionAlphaAnim.enabled = !playerOnTop;
        if(playerOnTop) player.y += depressionAmount;
    }

    height: 16
    width:  12*16

    Repeater
    {
        model: logCount
        Image
        {
            source: resBase + "obj/spr/bridge-log.png"
            property real myAlpha: (index + 0.5)/logCount
            x: index*16
            y: Math.round(depressionAmount * depressionAlpha * (myAlpha < alpha? Math.sin(myAlpha/alpha * Math.PI / 2) : Math.sin((1 - (myAlpha-alpha)/(1-alpha)) * Math.PI / 2)))
        }
    }

    z: field.objAZ

    Item
    {
        id: collision
        x: parent.x
        y: parent.y + 32
        width: 0
        height: 0
    }

    Image
    {
        id: stump1
        source: resBase + "obj/spr/bridge-stump.png"
        x: -width
        y: -height
    }

    Image
    {
        id: stump2
        source: resBase + "obj/spr/bridge-stump.png"
        x: bridge.width
        y: -height
        mirror: true
    }

    DWEveryFrame
    {
        id: updater
        onUpdate:
        {
            if(prefabId < 0)
            {
                prefabId = physicsWorld.addLevelGeomRect( x + width/2, y + 8, width/2, 8, 0, DWFieldPhysicsWorld.CC_LAYER_A_ONLYTOP | DWFieldPhysicsWorld.CC_LAYER_B_ONLYTOP )
            }

            if(false && overlapPlayerI(collision) && !player.playerInvincible )
            {
                player.getHit(spikes.x + spikes.width/2, spikes.y + spikes.height / 2);
            }


            alpha = Math.max(Math.min(1, (player.x - x) / (width)), 0);

            depressionAmount =  2 * (0.5 - Math.abs(0.5-alpha)) * logCount;
            if(player.playerState != DWPlayerBase.PS_AIR && Math.abs(player.y - y - depressionAmount*depressionAlpha) < 22)
            {
                playerOnTop = true;
            }
            else playerOnTop = false;

            physicsWorld.setLevelGeomTransform(prefabId, x+width/2, y + 8 + depressionAmount*depressionAlpha , 0);

        }
    }

    Component.onDestruction:
    {
        // destroy prefab
        if(prefabId > 0) physicsWorld.removeLevelGeom(prefabId);
    }

}

