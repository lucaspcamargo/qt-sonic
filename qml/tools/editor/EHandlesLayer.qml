import QtQuick 2.4

Item {

    id: handlesLayer
    visible: levelEditor.visible
    x: field.x
    y: field.y
    scale: field.scale

    property var handles: []
    property var selectedHandles: []

    Component {
        id: handleComponent

        Rectangle {

            id: handle

            property int idx: -1
            property var ref: null
            property var stubRef: null
            property bool selected: false

            color: selected? Qt.rgba(1,1,0,0.3) : Qt.hsla(Math.random(),1,0.5,0.2)
            border.color: selected? "yellow" : "gray"
            border.width: 1

            function setup()
            {
                x = ref.x;
                y = ref.y;
                width = ref.width;
                height = ref.height;

                stubRef = field.objectManager.objStubs[idx]

                if(field.objectManager.objStubs[idx].name === "Geometry")
                {
                    Qt.createComponent("EGeomDrawer.qml").createObject(this, {color: "#f6f"}).setupFromGeomData(ref.options.geomData);
                }
            }

            function deleteObject()
            {
                field.objectManager.removeObjStub(idx);
                destroy();
            }

            MouseArea {
                anchors.fill: handle
            }
        }

    }

    function createHandles() {
        var objMan = field.objectManager;

        for( var i = 0; i < objMan.objStubsCount; i++ )
        {
            createHandle(i);
        }
    }

    function createHandle(stubIdx)
    {
        var obj = field.objectManager.objs[stubIdx];
        if(obj)
        {
            var h = handleComponent.createObject(handlesLayer);
            h.idx = stubIdx;
            h.ref = obj;
            h.setup();

            handles.push(h);
        }
    }

    function destroyHandles() {

        while(handles.length) handles.pop().destroy();

    }

    property Rectangle selectionRect: Rectangle {
        parent: handlesLayer
        visible: false
        color: Qt.rgba(0,1,1,0.5)
        border.color: "cyan"
        border.width: 1

        function set(vis, p1, p2) {

            if(vis)
            {
                visible = true;
                x = Math.min(p1.x, p2.x);
                y = Math.min(p1.y, p2.y);

                width = Math.abs(p1.x - p2.x);
                height = Math.abs(p1.y - p2.y);

            }
            else {

                visible = false;
            }

        }
    }

    function clearSelection()
    {
        for(var i = 0; i < selectedHandles.length; i++)
        {
            selectedHandles[i].selected = false;
        }

        selectedHandles = [];
    }

    function deleteSelection()
    {
        for(var i = 0; i < selectedHandles.length; i++)
        {
            handles.splice(handles.indexOf(selectedHandles[i]), 1);
            selectedHandles[i].deleteObject();
        }

        selectedHandles = [];
    }

    function selectRect()
    {
        clearSelection();

        for(var i = 0; i < handlesLayer.children.length; i++)
        {
            var child = handlesLayer.children[i];
            if(child === selectionRect) continue;
            var childOverlaps = field.overlapI(selectionRect, child);
            if(childOverlaps)
            {
                child.selected = true;
                selectedHandles.push(child);
            }
        }

        selectedHandles = selectedHandles;
    }

    function selectAt(x, y)
    {
        var prevSelected = null;
        if(selectedHandles.length == 1)
            prevSelected = selectedHandles[0];

        clearSelection();
        selectionRect.x = x;
        selectionRect.y = y;
        selectionRect.width = selectionRect.height = 0;
        selectRect();

        if(selectedHandles.length > 0)
        {
            var selectedItem = selectedHandles[0];

            // do selection cycling
            if(prevSelected && selectedHandles.indexOf(prevSelected) >= 0)
                selectedItem = selectedHandles[(selectedHandles.indexOf(prevSelected)+1)%selectedHandles.length];

            clearSelection();
            selectedItem.selected = true;
            selectedHandles  = [selectedItem];
        }

    }

    function getSelectedIds()
    {
        var ret = [];
        for(var handle in selectedHandles)
        {
            ret.push(selectedHandles[handle].idx);
        }

        return ret;
    }
}

