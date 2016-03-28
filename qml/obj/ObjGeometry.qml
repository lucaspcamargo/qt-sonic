import QtQuick 2.0
import dw 1.0

DWFieldObject{

    id: geom
    sizeMatters: true

    property var options: null
    property int prefabId: -1


    Component.onCompleted: {

        // create prefab

        if(options)
        {
            if(options.geomData)
            {
                var gd = options.geomData;
               prefabId = physicsWorld.addLevelGeomChain(gd.xC, gd.yC, gd.xPoints, gd.yPoints, options.categories? options.categories : DWFieldPhysicsWorld.CC_LAYER_A, false);
            }
        }
    }

    Component.onDestruction: {
        if(prefabId !== -1)
            physicsWorld.removeLevelGeom(prefabId);
    }

    onActiveChanged: if(prefabId !== -1) {physicsWorld.setLevelGeomActive(prefabId, active);}
}
