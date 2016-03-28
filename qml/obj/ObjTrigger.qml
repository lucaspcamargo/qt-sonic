import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject {
    id: trigger

    z: field.objAZ
    width: 32
    height: 48

    //onParentChanged: z = field.objAZ

    sizeMatters: true

    signal triggered(real dt)
    signal collisionEnded()
    property bool colliding: false
    property bool continuous: false
    property string debugText: "T"
    property color debugColorFill: "#80ff00ff"
    property color debugColor: "#ff00ff"


    Rectangle
    {
        id: editorOutline
        border.color: debugColor
        color: debugColorFill

        Text
        {
            color: "white"
            styleColor: "black"
            style: Text.Outline
            text: debugText
            anchors.centerIn: editorOutline
            font.pixelSize: 12
        }

        anchors.fill: parent
    }

    Component.onCompleted:
    {
        if(!_DW_DEBUG)
        {
            editorOutline.destroy();
        }else
        {
            editorOutline.visible = Qt.binding(function(){ return _DW_DEBUG && (_DW_DEBUG_PHYSICS_DRAW || field.fieldEditMode); });
        }
    }

    DWEveryFrame
    {
        id: updater
        enabled: active
        onUpdate:
        {

            if(overlapPlayerI(trigger))
            {
                if(!continuous && colliding) return;

                trigger.triggered(dt);
                colliding = true;
            }
            else
            {
                if(colliding)
                {
                    collisionEnded();
                    colliding = false;
                }
            }
        }
    }
}
