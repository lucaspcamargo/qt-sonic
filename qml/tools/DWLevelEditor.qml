import QtQuick 2.3
import ".." 1.0
import "editor" 1.0

Item {

    anchors.fill: parent
    visible: false

    property bool cursorOnField: editorMouseArea.containsMouse
    property int cursorPreciseX: (editorMouseArea.mouseX - field.x)/field.viewScale
    property int cursorPreciseY: (editorMouseArea.mouseY - field.y)/field.viewScale
    property int cursorX: snapEnabled? Math.round(cursorPreciseX/snapAmount) * snapAmount : cursorPreciseX
    property int cursorY: snapEnabled? Math.round(cursorPreciseY/snapAmount) * snapAmount : cursorPreciseY

    property bool snapEnabled: false
    property int snapAmount: 8
    function changeSnapAmount() {snapAmount *= 2; if(snapAmount > 128) snapAmount = 8;}

    property int editMode: 0
    property var editModeNames: [ "OBJECTS", "TILES", "TILESET", "GEOMETRY" ]
    function changeEditMode() { editMode = (editMode+1)%editModeNames.length; }


    MouseArea
    {
        id: editorMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: panning? Qt.SizeAllCursor : Qt.BlankCursor

        property bool panning: false
        property int panOriginalX: 0
        property int panOriginalY: 0
        property real fieldOriginalX: 0
        property real fieldOriginalY: 0

        onPressed:
        {
            console.log(mouse.button);
            if(mouse.button == Qt.LeftButton)
            {
                panning = true;
                panOriginalX = mouse.x
                panOriginalY = mouse.y
                fieldOriginalX = field.viewCenterAtX;
                fieldOriginalY = field.viewCenterAtY;
            }

            mouse.accepted = true
        }

        onReleased:
        {
            console.log(mouse.button);
            if(mouse.button == Qt.LeftButton)
            {
                panning = false;
            }

            mouse.accepted = true
        }

        onPositionChanged:
        {
            if(panning)
            {
                field.viewCenterAtX = fieldOriginalX - (mouse.x - panOriginalX)/field.viewScale;
                field.viewCenterAtY = fieldOriginalY - (mouse.y - panOriginalY)/field.viewScale;
            }

            mouse.accepted = true
        }

        onWheel:
        {
            if(wheel.angleDelta.y < 0)
            {
                field.viewScale *= 0.5;
            }
            else
            {
                field.viewScale *= 2;
            }

            field.viewScale = Math.min(Math.max(field.viewScale, 0.125), 8);
        }
    }

    Rectangle
    {
        id: cursorGuideVertical
        height: parent.height
        width: 1
        x: Math.round(cursorX*field.viewScale + field.x)
        visible: editorMouseArea.containsMouse
    }

    Rectangle
    {
        id: cursorGuideHorizontal
        width: parent.width
        height: 1
        y: Math.round(cursorY*field.viewScale + field.y)
        visible: editorMouseArea.containsMouse
    }

    Rectangle
    {
        id: cursorGuidePixel
        width: 1
        height: 1
        x: cursorGuideVertical.x
        y: cursorGuideHorizontal.y
        color: "orange"
    }

    Rectangle
    {
        id: editorMenuBar

        height: 12
        width: parent.width

        color: "black"

        DWTextBitmap
        {
            x: 2
            y: 2
            font: "xexex-multi"
            asyncronous: false

            text: "Level Editor"
        }

        Row
        {
            spacing: 2
            anchors.right: parent.right

            EButton
            {
                text: "RELOAD"
                onClicked: changeEditMode()
            }

            EButton
            {
                text: "SAVE"
                onClicked: changeEditMode()
            }

            EButton
            {
                text: editModeNames[editMode]
                onClicked: changeEditMode()
            }

            EButton
            {
                text: snapEnabled? "SNAP" : "PRECISE"
                onClicked: snapEnabled = !snapEnabled
            }

            EButton
            {
                text: snapAmount
                visible: snapEnabled
                onClicked: changeSnapAmount()
            }

            EButton
            {
                text: "DONE"
                onClicked: toggleVisible()
            }
        }

    }


    Rectangle
    {
        id: editorStatusBar

        anchors.bottom: parent.bottom
        height: 12
        width: parent.width

        color: "black"

        DWTextBitmap
        {
            x: 2
            y: 2
            font: "xexex-multi"
            asyncronous: false

            text: cursorOnField? ("X " + cursorX + "  Y " + cursorY ): ""
        }
    }


    function toggleVisible()
    {
        visible = !visible;

        field.fieldActive = !visible;
        field.fieldEditMode = visible;
        field.viewScale = 1;

        hud.visible = !visible;
        dwLogo.visible = !visible;
        offscreen = !visible;

        if(visible) forceActiveFocus();
        else controls.keyboardHandler.forceActiveFocus();
    }

    Keys.onEscapePressed:
    {
        toggleVisible();
    }

    Keys.onPressed:
    {
        if(event.key == Qt.Key_Tab)
            changeEditMode();

        if(event.key == Qt.Key_S)
            snapEnabled = !snapEnabled;

        if(event.key == Qt.Key_A)
            changeSnapAmount();
    }
}

