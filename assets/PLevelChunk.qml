import QtQuick 2.0
import dw 1.0

Item {
    id: chunk
    width: 256
    height: 256

    property string chunkChildType: "chunk"
    property var fixtureRefs: []

    function process()
    {
        flattenVisualHierarchy(children);
        processGeometry();
    }

    function isObjStub(child)
    {
        return (!child.chunkChildType) && child.source && String(child.source).indexOf("/obj/")>0 && !child.notStub;
    }

    function flattenVisualHierarchy(childrenList)
    {

        if(_DW_DEBUG) console.log("CHUNK processing "+childrenList.length+" children");

        var forReparenting = [];
        var forReparentingX = [];
        var forReparentingY = [];

        for( var i = 0; i < childrenList.length; i ++)
        {
            var child = childrenList[i];

            if(child.doNotFlatten) continue;
            if(!child.chunkChildType) continue;
            for( var j = 0; j < child.children.length; j ++)
            {
                var grandson = child.children[j];
                if((!grandson.chunkChildType) || (grandson.chunkChildType !== "no-reparent"))
                {
                    forReparenting.push(grandson);
                    forReparentingX.push(child.x);
                    forReparentingY.push(child.y);
                }
            }
        }

        for(var k = 0; k < forReparenting.length; k++)
        {
            var _grandson = forReparenting[k];

            DWUtil.reparent(_grandson, chunk);
            _grandson.parent = chunk;
            _grandson.x += forReparentingX[k];
            _grandson.y += forReparentingY[k];
        }

        if(forReparenting.length > 0) flattenVisualHierarchy(forReparenting); // repeat for new children
    }


    function processGeometry()
    {
        var forDestruction = [];
        var forReparenting = [];
        var objStubs = [];

        if(_DW_DEBUG) console.log(("CHUNK processing %1 child elements").arg(children.length));

        for(var i = 0; i < children.length; i++)
        {
            var child = children[i];

            var cX = x + child.x + child.width/2;
            var cY = y + child.y + child.height/2;

            var categories = (child.layerA? DWFieldPhysicsWorld.CC_LAYER_A : 0x00) | (child.layerB? DWFieldPhysicsWorld.CC_LAYER_B : 0x00);
            if(child.onlyBottomSensors) categories = categories * 4;

            if(child.chunkChildType === "geom-arc")
            {
                cX = x + child.x + (child.quadrant === 1 || child.quadrant === 2? child.width : 0);
                cY = y + child.y + (child.quadrant > 1? 0 : child.height);

                fixtureRefs.push(physicsWorld.addLevelGeomArc(cX, cY, child.width, child.rotation, child.quadrant, categories));
                forDestruction.push(child);
            }
            else if(child.chunkChildType === "geom-rect")
            {
                fixtureRefs.push(physicsWorld.addLevelGeomRect(cX, cY, child.width/2, child.height/2, child.rotation, categories));
                forDestruction.push(child);
            }
            else if(child.chunkChildType === "geom-ramp")
            {
                fixtureRefs.push(physicsWorld.addLevelGeomEdge(x + child.x, y + child.y + (child.reversed? 0 : child.height), x + child.x + child.width, y + child.y + (child.reversed? child.height : 0), categories));
                forDestruction.push(child);
            }
            else if(child.chunkChildType === "visual")
            {
                if(child.ownsQtObjects || child.children.length !== 0)
                {
                    forReparenting.push(child);
                }
                else
                {
                    forDestruction.push(child);
                    visManager.addVisStub(x + child.x, y + child.y, x + child.x + child.width/2, y + child.y + child.height/2,
                                          Qt.vector2d(child.width/2, child.height/2).length(), child.source, child.layerB, child.visualBg, 0);
                }

            }
            else if(child.chunkChildType === "objstub")
            {
                objStubs.push(child);
            }
            else {
                // misc objects go to field, in default z order
                forReparenting.push(child);
            }
        }


        for(var i = 0; i < forReparenting.length; i++)
        {
            var child = forReparenting[i];

            if( isObjStub(child) )
            {
                // is object stub
                objStubs.push(child);
            }else
            {
                child.parent = field;
                DWUtil.reparent(child, field);
                child.x += x;
                child.y += y;
                if(child.chunkChildType === "visual")
                {
                    // fix z ordering
                    child.z = child.visualBg? field.visualBgZ : (child.layerB? field.layerBZ : field.layerAZ);
                }
            }
        }

        if(_DW_DEBUG) console.log("CHUNK processing "+objStubs.length + " object stubs");
        for(var i = 0; i < objStubs.length; i++)
        {

            var child = objStubs[i];
            forDestruction.push(child);

            if(child.chunkChildType === "objstub")
            {
                var objName = child.objComponentName;
                var objOptions = child.objOptions;
            }else
            {
                var urlStr = String(child.source);
                var comps = urlStr.split("/");
                var nameBase = comps[comps.length-1].split(".")[0];
                var parts = nameBase.split("-");
                var objName = parts[0].toUpperCase()[0] + parts[0].slice(1);
                var objOptions = parts.slice(1);
            }

            objManager.addObjectStub(x + child.x, y + child.y, child.width, child.height, child.rotation, x + child.x + child.width/2, y + child.y + child.height/2, Qt.vector2d(child.width/2, child.height/2).length() + 16, objName, objOptions, child.inPrefix? true : false);
        }

        if(_DW_DEBUG) console.log("CHUNK destroying "+forDestruction.length + " loose objects");
        for(var k = 0; k < forDestruction.length; k++)
        {
            forDestruction[k].destroy();
        }
    }

}



