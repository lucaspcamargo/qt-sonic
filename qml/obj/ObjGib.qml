import QtQuick 2.4
import dw 1.0

Item {

    id: gib
    width: 32
    height: 32
    z: field.objAZ

    property alias source: img.source

    Image {
        id: img
        anchors.fill: gib
    }

    DWFOPhysicsBody
    {
        id: body
        bodyType: DWFOPhysicsBody.BT_DYNAMIC
        shapeType: DWFOPhysicsBody.ST_CIRCLE
        shapeCategory: DWFieldPhysicsWorld.CC_GIB
        shapeCollisionMask: DWFieldPhysicsWorld.CC_LAYERS | DWFieldPhysicsWorld.CC_LAYERS_ONLYTOP | DWFieldPhysicsWorld.CC_DYNAMIC | DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(gib.width / 4, gib.height / 4, 0, 0)
        origin: Qt.point(gib.width/2, gib.height/2)
    }

    Component.onCompleted:
    {
        body.rebuildBody();
        body.autorebuild = true;
        body.setLinearVelocity(Qt.vector2d((Math.random()-0.5)*600, (Math.random()-0.5)*600));
        body.setAngularVelocity((Math.random()-0.5)*30);
    }


    SequentialAnimation
    {
        id: fadeAnim
        running: true


        PauseAnimation {
            duration: 2500
        }


        NumberAnimation {
            target: gib
            property: "opacity"
            duration: 1500
            easing.type: Easing.Linear
            to: 0.0
        }

        ScriptAction {
            script: gib.destroy();
        }
    }
}
