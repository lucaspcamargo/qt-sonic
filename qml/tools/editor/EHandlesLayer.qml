import QtQuick 2.4

Item {

    id: handlesLayer
    visible: levelEditor.visible
    x: field.x
    y: field.y
    scale: field.scale

    property var handles: []

    Component {
        id: handleComponent

        Rectangle {

            id: handle
            property var ref: null
            property var stubRef: null

            color: Qt.rgba(1,0,1,0.25)
            border.color: "magenta"
            border.width: 1

            function setup()
            {
                x = ref.x;
                y = ref.y;
                width = ref.width;
                height = ref.height;
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
                h.ref = obj;
                h.setup();

                handles.push(h);
            }
        }
    }

    function destroyHandles() {

        while(handles.length) handles.pop().destroy();

    }

    property var selectionRect: Rectangle {
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
}

