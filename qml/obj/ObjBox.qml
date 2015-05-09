import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject {
    width: 32
    height: 32
    z: field.objBZ

    Image {
        anchors.fill: parent
        source: resBase + "obj/obj/box.png"
    }

    DWFOPhysicsBody {
        id: body
        bodyType: DWFOPhysicsBody.BT_DYNAMIC
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_DYNAMIC
        shapeCollisionMask: DWFieldPhysicsWorld.CC_LAYERS | DWFieldPhysicsWorld.CC_LAYERS_ONLYTOP | DWFieldPhysicsWorld.CC_PLAYER_SENSOR | DWFieldPhysicsWorld.CC_PLAYER | shapeCategory
        shapeData: Qt.vector4d(16, 16, 0, 0)
        origin: Qt.point(16, 16)
    }

    Component.onCompleted: {
        objManager.updateObjects.connect(update);
        body.rebuildBody();
    }
    onActivated: objManager.updateObjects.connect(update);
    onDeactivated: objManager.updateObjects.disconnect(update);
    Component.onDestruction: objManager.updateObjects.disconnect(update);
}

