import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject {

    id: platformBase

    width: 64
    height: 16
    z: field.objAZ

    property real radius: 128
    property bool playerInHorizontalRange: false
    property bool playerOnTop: false

    property real deltaX: 0
    property real deltaY: 0

    property real deltaXLastUpdate: 0
    property real deltaYLastUpdate: 0

    function updatePlatform( dt )
    {
        playerInHorizontalRange = (player.x + player.playerHalfWidth > x && player.x - player.playerHalfWidth < x + width );
        playerOnTop = (player.playerState != DWPlayerBase.PS_AIR) && (Math.abs(player.y - y ) < 22) && playerInHorizontalRange;

        if(Math.abs(deltaY - deltaYLastUpdate) >= 1)
        {
            var amount = Math.floor(deltaY - deltaYLastUpdate);
            y += amount;
            if(playerOnTop) player.y += amount;
            deltaYLastUpdate += amount;
        }
    }

    DWFOPhysicsBody
    {
        id: body

        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_LAYERS_ONLYTOP
        shapeCollisionMask: DWFieldPhysicsWorld.CC_DYNAMIC
        shapeData: Qt.vector4d(platformBase.width/2, platformBase.height/2, 0, 0)
        origin: Qt.point(platformBase.width/2, platformBase.height/2)

        Component.onCompleted: rebuildBody();
    }

    DWSoundEffect
    {
        id: popSound
        source: "sfx/pop.wav"
    }
}

