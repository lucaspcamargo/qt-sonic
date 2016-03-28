import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject {
    id: boss

    width: 427
    height: 240


    property bool useWalls: true
    property bool wallsOn: false

    DWFOPhysicsBody
    {
        id: wallOne
        active: useWalls && boss.active && wallsOn

        bodyType: DWFOPhysicsBody.BT_STATIC
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_LAYERS
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER

        shapeData: Qt.vector4d(16, boss.height/2, 0, 0)
        origin: Qt.point(-16, boss.height/2)

        Component.onCompleted: { rebuildBody(); autorebuild = true; }
    }

    DWFOPhysicsBody
    {
        id: wallTwo
        active: wallOne.active

        bodyType: wallOne.bodyType
        shapeType: wallOne.shapeType
        shapeCategory: wallOne.shapeCategory
        shapeCollisionMask: wallOne.shapeCollisionMask

        shapeData: Qt.vector4d(16, boss.height/2, 0, 0)
        origin: Qt.point(boss.width + 16, boss.height/2)

        Component.onCompleted: { rebuildBody(); autorebuild = true; }
    }

}

