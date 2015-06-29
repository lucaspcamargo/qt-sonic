import QtQuick 2.3
import ".." 1.0
import "editor" 1.0

Item {

    id: levelEditor

    width: parent.width/levelEditor.scale
    height: parent.height/levelEditor.scale
    scale: Math.max(0.5, parent.width / rootWindow.width)
    anchors.centerIn: parent
    visible: false

    property bool cursorOnField: editorMouseArea.containsMouse
    property int cursorPreciseX: (editorMouseArea.mouseX*levelEditor.scale - field.x)/field.viewScale
    property int cursorPreciseY: (editorMouseArea.mouseY*levelEditor.scale - field.y)/field.viewScale
    property int cursorX: snapEnabled? Math.round(cursorPreciseX/snapAmount) * snapAmount : cursorPreciseX
    property int cursorY: snapEnabled? Math.round(cursorPreciseY/snapAmount) * snapAmount : cursorPreciseY

    property bool snapEnabled: false
    property int snapAmount: 8
    function changeSnapAmount() {snapAmount *= 2; if(snapAmount > 128) snapAmount = 8;}

    property int editMode: 0
    property var editModeNames: [ "OBJECTS", "TILES", "TILESET", "GEOMETRY" ]
    function changeEditMode() { editMode = (editMode+1)%editModeNames.length; }

    property var handlesLayer: null

    property var objLib: [
        {name: "Ring", },
    ]

    MouseArea
    {
        id: editorMouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.AllButtons
        cursorShape: panning? Qt.SizeAllCursor : Qt.BlankCursor

        property bool panning: false
        property bool selectingRect: false
        property int selectX: 0
        property int selectY: 0
        property int originalX: 0
        property int originalY: 0
        property real fieldOriginalX: 0
        property real fieldOriginalY: 0

        onPressed:
        {
            if(mouse.button == Qt.LeftButton)
            {
                handlesLayer.selectAt(cursorX, cursorY);
            }

            if(mouse.button == Qt.MiddleButton)
            {
                panning = true;
                originalX = mouse.x
                originalY = mouse.y
                fieldOriginalX = field.viewCenterAtX;
                fieldOriginalY = field.viewCenterAtY;
            }

            mouse.accepted = true
        }

        onReleased:
        {
            if(mouse.button === Qt.LeftButton)
            {
                if(selectingRect)
                {
                    handlesLayer.selectRect();
                    handlesLayer.selectionRect.set(false);
                    selectingRect = false;
                }
            }

            if(mouse.button === Qt.MiddleButton)
            {
                panning = false;
            }

            mouse.accepted = true
        }

        onPositionChanged:
        {
            if(selectingRect)
            {
                handlesLayer.selectionRect.set(true, Qt.point(cursorX, cursorY), Qt.point(selectX, selectY));
            }

            if(!selectingRect && (mouse.buttons & Qt.LeftButton))
            {
                selectingRect = true;
                selectX = cursorX;
                selectY = cursorY;
            }

            if(panning)
            {
                field.viewCenterAtX = fieldOriginalX - (mouse.x - originalX)/field.viewScale;
                field.viewCenterAtY = fieldOriginalY - (mouse.y - originalY)/field.viewScale;
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
        x: Math.round( cursorX * field.viewScale + field.x)/levelEditor.scale
        visible: editorMouseArea.containsMouse
    }

    Rectangle
    {
        id: cursorGuideHorizontal
        width: parent.width
        height: 1
        y: Math.round(cursorY*field.viewScale + field.y)/levelEditor.scale
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

        height: 14
        width: parent.width

        color: "black"

        MouseArea        {
            //intercept
            anchors.fill: parent
            hoverEnabled: true
        }

        DWTextBitmap        {
            x: 2
            y: 2
            font: "xexex-multi"
            asyncronous: false

            text: "Level Editor"
        }

        Row        {
            spacing: 2
            anchors.right: parent.right

            EButton            {
                text: "RELOAD"
                onClicked: changeEditMode()
            }

            EButton            {
                text: "SAVE"
                onClicked: changeEditMode()
            }

            EButton            {
                text: editModeNames[editMode]
                onClicked: changeEditMode()
            }

            EButton            {
                text: snapEnabled? "SNAP" : "PRECISE"
                onClicked: snapEnabled = !snapEnabled
            }

            EButton            {
                text: snapAmount
                visible: snapEnabled
                onClicked: changeSnapAmount()
            }

            EButton            {
                text: "DONE"
                onClicked: toggleVisible()
            }
        }

    }

    Row
    {
        id: objShortcutsRow

        x: 2
        y: 16

        spacing: 2

        EObjectDisplay
        {
            id: objDisplayCurrent

            label: "CURR"
            name: "RING"
        }
        Repeater
        {
            model: 10

            EObjectDisplay
            {
                label: (index + 1) % 10
                name: "RING"
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

        MouseArea
        {
            //intercept
            anchors.fill: parent
            hoverEnabled: true
        }

        DWTextBitmap
        {
            x: 2
            y: 2
            font: "xexex-multi"
            asyncronous: false

            text: cursorOnField? ("X " + cursorX + "  Y " + cursorY ): ""
        }
    }

    function addObject( historyIndex )
    {
        if(!historyIndex)
        {

        }
    }


    function toggleVisible()
    {
        fieldController.paused = false;

        visible = !visible;

        if(visible) forceActiveFocus();
        else controls.getFocus();

        field.fieldActive = !visible;
        field.fieldEditMode = visible;
        field.viewScale = 1;

        hud.visible = !visible;
        offscreen = !visible;
        dwLogo.visible = !visible;
        editorCheckerboard.visible = visible;

        if(visible)
            field.objectManager.resetObjects();

        if(visible)
            handlesLayer.createHandles();
        else
            handlesLayer.destroyHandles();
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

        if(event.key == Qt.Key_Delete || event.key == Qt.Key_X || event.key == Qt.Key_Backspace )
            handlesLayer.deleteSelection();

        event.accepted = true;
    }

    Keys.onSpacePressed:
    {
        addObject();
    }

    Component.onCompleted:
    {
        controls.escapePressed.connect(levelEditor.toggleVisible);

        // create field surface
        var c = Qt.createComponent("editor/EHandlesLayer.qml");
        handlesLayer = c.createObject(fieldContainer);
    }
}

