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

            property int index: -1
            property var ref: null
            property var stubRef: null
            property bool selected: false

            color: selected? Qt.rgba(1,1,0,0.3) : Qt.rgba(1,0,1,0.25)
            border.color: selected? "yellow" : "magenta"
            border.width: 1

            function setup()
            {
                x = ref.x;
                y = ref.y;
                width = ref.width;
                height = ref.height;
            }

            function deleteObject()
            {
                field.objectManager.removeObjStub(index);
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
            var obj = objMan.objs[i];
            if(obj)
            {
                var h = handleComponent.createObject(handlesLayer);
                h.index = i;
                h.ref = obj;
                h.setup();

                handles.push(h);
            }
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
    }

    function selectAt(x, y)
    {
        clearSelection();

        var child = childAt(x, y);
        if(child)
        {
            if(child === selectionRect) return;

            child.selected = true;
            selectedHandles.push(child);
        }
    }
}

