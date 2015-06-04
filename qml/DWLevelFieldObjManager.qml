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

    property real viewCenterX: field.viewCenterAtX
    property real viewCenterY: field.viewCenterAtY
    property real instantiationDistanceSquared: Math.pow(Qt.vector2d(field.viewWidth, field.viewHeight).length() * 0.7, 2)
    property real destructionDistanceSquared: Math.pow(Qt.vector2d(field.viewWidth, field.viewHeight).length() * 1.0, 2)

    signal updateObjects(real dt);


    function addObjectStub( x, y, w, h, rot, xc, yc, radius, name, opts, inPrefix )
    {
        objStubs.push({"x": x, "y":y, "w": w, "h":h, "rot":rot, "xc":xc, "yc":yc, "radius": radius, "name": name, "options": opts, "inPrefix": inPrefix});
        objXC.push(xc);
        objYC.push(yc);
        objRadius.push(radius);
        objCreated.push(false);
        objBVHNode.push(null);
        recreateObj.push(true);

        objStubsCount++;
    }

    function warmupCaches()
    {
        for(var i = 0; i < objStubs.length; i ++)
        {
            if(recreate[i] && objCreated[i] != true)
            {
                var o = createObject(i);
                objectDestroyed(i, true);
                o.destroy();
            }
        }
    }


    function init()
    {
        for(var i = 0; i < objStubs.length; i++)
            createObject(i);
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
    }

    function objectDestroyed(index, dontRecreateLater)
    {
        objBVHNode[index].disconnectActivationSignals();

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

        var c = Qt.createComponent((objStubs[i]["inPrefix"]? prefixedPrefix : "obj/Obj" )+objStubs[i]["name"]+".qml");
        if(c)
        {
            var obj = c.createObject(field);
            if(obj)
            {
                obj.x = objStubs[i]["x"];
                obj.y = objStubs[i]["y"];
                if(obj.setSize || obj.sizeMatters)
                {
                    obj.width = objStubs[i]["w"];
                    obj.height = objStubs[i]["h"];
                }
                if(obj.setRot || obj.rotationMatters)
                {
                    obj.rotation = objStubs[i]["rot"];
                }

                if(obj.managerIndex)
                    obj.managerIndex = i;
                if(obj.morph)
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

                var bvhNode = fieldBVH.createNode(objXC[i], objYC[i], obj.radius? obj.radius : objRadius[i], fieldBVH.rootNode);
                bvhNode.activated.connect(obj.activate);
                bvhNode.deactivated.connect(obj.deactivate);
                objBVHNode[i] = bvhNode;

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
