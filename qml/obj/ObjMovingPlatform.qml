import QtQuick 2.4
import dw 1.0

ObjMovingPlatformBase {

    id: platform

    Image {
        id: img
        source: resBase + "obj/obj/movingPlatform.png"
        y: playerOnTop? 0 : -2
    }

    Component.onCompleted: objManager.updateObjects.connect(update);
    onActivated: objManager.updateObjects.connect(update);
    onDeactivated: objManager.updateObjects.disconnect(update);
    Component.onDestruction: objManager.updateObjects.disconnect(update);

    function update(dt)
    {
        deltaY = Math.sin((field.fieldTime % 6)*2*Math.PI/6)*64;
        updatePlatform(dt);

    }


}

