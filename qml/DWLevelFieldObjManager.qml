import QtQuick 2.3
import dw 1.0

QtObject
{
    property bool countActiveObjects: _DW_DEBUG

    property var objStubs: []
    property var objs: []
    property var objXC: []
    property var objYC: []
    property var objRadius: []
    property var objCreated: []
    property var objBVHNode: []
    property var recreateObj: []

    property int objStubsCount: 0
    property int objCount: 0

    signal updateObjects(real dt);


    function addObjectStub( x, y, w, h, rot, xc, yc, radius, name, opts, inPrefix )
    {
        objStubs.push({"name": name, "x": x, "y":y, "w": w, "h":h, "rot":rot, "xc":xc, "yc":yc, "radius": radius, "options": opts, "inPrefix": inPrefix});
        objXC.push(xc);
        objYC.push(yc);
        objRadius.push(radius);
        objCreated.push(false);
        objBVHNode.push(null);
        recreateObj.push(true);

        objStubsCount++;
        return objStubsCount-1;
    }

    function cloneStubSlow(stub)
    {
        return {
            name: stub.name,
            x: stub.x,
            y: stub.y,
            w: stub.w,
            h: stub.h,
            rot: stub.rot,
            xc: stub.xc,
            yc: stub.yc,
            radius: stub.radius,
            options: JSON.parse(JSON.stringify(stub.options)),
            inPrefix: stub.inPrefix,
        };
    }

    function init()
    {
        if(!loadObjStubs())
            resetObjects();
    }

    function removeObjStub(index)
    {
        if(objs[index])
        {
            objs[index].destroy();
            objectDestroyed(index, false);

            if(objBVHNode[index])
            {
                objBVHNode.markForDeletion();
            }
        }

        objStubs[index] = null;
    }

    function removeAllObjStubs()
    {
        for(var i = 0; i < objStubsCount; i++)
        {
            removeObjStub(i);
        }

        objStubs = [];
        objXC = [];
        objYC = [];
        objRadius = [];
        objCreated = [];
        objBVHNode = [];
        recreateObj = [];

        objStubsCount = 0;
        objCount = 0;
    }

    function loadObjStubs()
    {
        if(!levelData.objStubs) return;
        removeAllObjStubs();

        var levelFile = resBase + levelData.urlPrefix + levelData.objStubs;
        var newObjStubs = (JSON.parse(DWUtil.readTextFile(levelFile)));

        if(newObjStubs)
        {
            objStubs = newObjStubs;

            for(var i = 0; i < objStubs.length; i++)
            {
                if(objStubs[i])
                {
                    objXC.push(objStubs[i].xc);
                    objYC.push(objStubs[i].yc);
                    objRadius.push(objStubs[i].radius);
                    objCreated.push(false);
                    objBVHNode.push(null);
                    recreateObj.push(true);
                }
                else
                {
                    objStubs.splice(i, 1);
                    i--;
                }
            }

            objStubsCount = objStubs.length;
            resetObjects();

            return true; //objects were reset
        }

        return false; // nothing much happened
    }

    function saveObjStubs()
    {
        var levelFile = resBase + levelData.urlPrefix + levelData.objStubs;
        var success = DWUtil.writeTextFile(levelFile, JSON.stringify(objStubs, null, 2));

        debugMsg(success? "Level saved successfully" : "Error saving level");
    }

    function update(dt)
    {
        updateObjects(dt);
    }

    function fieldReset()
    {
        resetObjects();
    }

    function resetObjects()
    {
        for(var i = 0; i < objStubsCount; i++)
            createObject(i);

        fieldBVH.rebuildBVH();
    }

    function objectDestroyed(index, dontRecreateLater)
    {
        if(objBVHNode[index])
        {
            objBVHNode[index].disconnectActivationSignals();
            objBVHNode[index].markForDeletion();
            objBVHNode[index] = null;
        }

        objCreated[index] = false;
        objs[index] = null;
        recreateObj[index] = (dontRecreateLater? false : true);
        objCount--;
    }


    property string prefixedPrefix: resBase + levelData.urlPrefix + "obj/" + levelData.prefix.toUpperCase() + "Obj"

    function createObject(i)
    {
        if(objCreated[i]) return;
        if(!recreateObj[i]) return;
        if(!objStubs[i]) return;

        var c = Qt.createComponent((objStubs[i]["inPrefix"]? prefixedPrefix : "obj/Obj" )+objStubs[i]["name"]+".qml");
        if(c)
        {
            var args = {
                x: objStubs[i]["x"],
                y: objStubs[i]["y"],
                options: objStubs[i].options};

            var obj = c.createObject(field, args);
            if(obj)
            {
                if(obj.setSize || obj.sizeMatters)
                {
                    obj.width = objStubs[i]["w"];
                    obj.height = objStubs[i]["h"];
                }

                obj.rotation = objStubs[i]["rot"];


                if(obj.managerIndex)
                    obj.managerIndex = i;
                if(obj.morph && objStubs[i]["options"])
                    obj.morph( objStubs[i]["options"] );

                objs[i] = obj;
                objCreated[i] = true;
                if(countActiveObjects)
                {
                    objCount ++;
                    if(obj.onActivated)
                        obj.onActivated.connect(increaseActiveObjectCount);
                    if(obj.onDeactivated)
                        obj.onDeactivated.connect(decreaseActiveObjectCount);

                }


                var bvhNode = objBVHNode[i];

                if(!bvhNode)
                {
                    bvhNode = fieldBVH.createNode(objXC[i], objYC[i], obj.radius? obj.radius : objRadius[i], fieldBVH.rootNode);
                    objBVHNode[i] = bvhNode;
                }

                bvhNode.active = true;

                if(obj.nodeConnect)
                    obj.nodeConnect(bvhNode);
                else
                {
                    bvhNode.activated.connect(obj.activate);
                    bvhNode.deactivated.connect(obj.deactivate);
                }

                return obj;
            }
            else console.log("Can't create object: " + objStubs[i]["name"]);
        }
        else console.log("Can't create component: " + objStubs[i]["name"]);
    }

    function increaseActiveObjectCount()
    {
        objCount++;
    }

    function decreaseActiveObjectCount()
    {
        objCount--;
    }

}
