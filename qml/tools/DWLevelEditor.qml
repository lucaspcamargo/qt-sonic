import QtQuick 2.3
import dw 1.0
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

    property bool snapEnabled: true
    property int snapAmount: 8
    function changeSnapAmount() {snapAmount *= 2; if(snapAmount > 128) snapAmount = 8;}

    property int editMode: 0
    property var editModeNames: [ "OBJECTS", "TILESET" ]
    function changeEditMode() { editMode = (editMode+1)%editModeNames.length; }

    property var handlesLayer: null

    property int objCurrent: 0
    property var objShortcuts: [0,1,2,3,4,5,6,7,8,9]
    property var objLib: [
        {name: "Ring", displayImage:"obj/obj/ring.png"},
        {name: "Spring", displayImage:"obj/obj/spring.png" },
        {name: "Monitor", displayImage:"obj/obj/monitor-shield.png" },
        {name: "Spikes", displayImage:"obj/obj/spikes.png" },
        {name: "Checkpoint", displayImage:"obj/obj/checkpoint.png" },
        {name: "Bumper", displayImage:"obj/obj/bumper.png" },
        {name: "Trigger", displayImage:"obj/obj/TriggerLayerA.png" },
        {name: "Badnik", displayImage:"obj/obj/badnik.png" },
        {name: "Bridge", displayImage:"obj/obj/bridge.png" },
        {name: "RedRing", displayImage:"obj/obj/redRing.png" },
    ]

    property url tileLocation: resBase + levelData.urlPrefix + "tileset"
    property url tilePrefix: tileLocation + "/"
    property var tileFiles: DWUtil.listFiles(tileLocation)
    property int tileCurrent: 0

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

            if(mouse.button == Qt.RightButton)
            {
                if(editMode == 0)
                    placeObject();
                else
                    placeTile();
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


    Image
    {
        id: objectDisplayImage
        visible: editMode == 0
        x: cursorGuideVertical.x
        y: cursorGuideHorizontal.y
        opacity: 0.5
        source: resBase + objLib[objCurrent].displayImage
        transformOrigin: Item.TopLeft
        scale: field.viewScale/levelEditor.scale
    }

    Image
    {
        id: tileDisplayImage
        visible: editMode == 1
        x: cursorGuideVertical.x
        y: cursorGuideHorizontal.y
        opacity: 0.5
        source: tileFiles[tileCurrent]
        transformOrigin: Item.TopLeft
        scale: field.viewScale/levelEditor.scale
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
                text: "SAVE"
                onClicked: saveObjects()
                textColor: 5
            }

            EButton            {
                text: "RELOAD"
                onClicked: reloadObjects()
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
            name: objLib[objCurrent].name.toUpperCase()
            imageSource: resBase + objLib[objCurrent].displayImage
        }
        Repeater
        {
            model: 10

            EObjectDisplay
            {
                label: (index + 1) % 10
                name: objLib[objShortcuts[index]].name.toUpperCase()
                imageSource: resBase + objLib[objShortcuts[index]].displayImage
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: objCurrent = (index)
                }
            }
        }


    }

    Rectangle
    {
        id: tileSelect


        color: "#000"

        border.color: "#88aa00"
        border.width: 1
        clip: true

        width: 48
        height: parent.height - 40
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 20

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
        }

        ListView
        {
            anchors.fill: parent
            anchors.margins: 4

            spacing: 4

            model: tileFiles.length

            delegate: Image {

                source: tileFiles[index]
                width: parent.width
                height: width

                fillMode: Image.PreserveAspectFit

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: tileCurrent = index
                }

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

    function placeObject( )
    {
        // x, y, w, h, rot, xc, yc, radius, name, opts, inPrefix
        var createdIndex = field.objectManager.addObjectStub(cursorX, cursorY,
                                                             objectDisplayImage.width, objectDisplayImage.height,
                                                             0,
                                                             cursorX + objectDisplayImage.width/2, cursorY + objectDisplayImage.height/2,
                                                             64, objLib[objCurrent].name, [], false);
        field.objectManager.createObject(createdIndex);
        handlesLayer.createHandle(createdIndex);
    }

    function reloadObjects()
    {
        handlesLayer.destroyHandles();
        field.objectManager.loadObjStubs();
        handlesLayer.createHandles();
    }

    function saveObjects()
    {
        field.objectManager.saveObjStubs();
    }

    function placeTile( )
    {
        var tileFile = tileFiles[tileCurrent].substr(tileFiles[tileCurrent].lastIndexOf("/") + 1);

        var createdIndex = field.objectManager.addObjectStub(cursorX, cursorY,
                                                             tileDisplayImage.width, tileDisplayImage.height,
                                                             0,
                                                             cursorX + tileDisplayImage.width/2, cursorY + tileDisplayImage.height/2,
                                                             512, "Rage16Tile", {"tileFile": tileFile, "background": tileFile.indexOf("bg") > -1}, false);
        field.objectManager.createObject(createdIndex);
        handlesLayer.createHandle(createdIndex);
    }

    function toggleVisible()
    {
        console.log("[DWLevelEditor] editor " + (visible? "enabled" : "disabled"))

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
        else
            field.rebuildBVH();

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

        if(event.key == Qt.Key_C)
            centerOnPlayerAnim.start();

        if(event.key == Qt.Key_P)
        {
            // place player here
            field.player.x = cursorX;
            field.player.y = cursorY;
        }

        if(event.key == Qt.Key_Space)
            objectsDialog.show();

        if(event.key == Qt.Key_Delete || event.key == Qt.Key_X || event.key == Qt.Key_Backspace )
            handlesLayer.deleteSelection();

        event.accepted = true;
    }

    ParallelAnimation
    {
        id: centerOnPlayerAnim

        NumberAnimation
        {
            target: field
            property: "viewCenterAtX"
            to: field.player.x
        }

        NumberAnimation
        {
            target: field
            property: "viewCenterAtY"
            to: field.player.y
        }
    }

    Keys.onDigit0Pressed: {objCurrent = 9; event.accepted = true}
    Keys.onDigit1Pressed: {objCurrent = 0; event.accepted = true}
    Keys.onDigit2Pressed: {objCurrent = 1; event.accepted = true}
    Keys.onDigit3Pressed: {objCurrent = 2; event.accepted = true}
    Keys.onDigit4Pressed: {objCurrent = 3; event.accepted = true}
    Keys.onDigit5Pressed: {objCurrent = 4; event.accepted = true}
    Keys.onDigit6Pressed: {objCurrent = 5; event.accepted = true}
    Keys.onDigit7Pressed: {objCurrent = 6; event.accepted = true}
    Keys.onDigit8Pressed: {objCurrent = 7; event.accepted = true}
    Keys.onDigit9Pressed: {objCurrent = 8; event.accepted = true}

    Component.onCompleted:
    {
        controls.escapePressed.connect(levelEditor.toggleVisible);

        // create field surface
        var c = Qt.createComponent("editor/EHandlesLayer.qml");
        handlesLayer = c.createObject(fieldContainer);

        // read level tiles
        initTileset();
    }

    function initTileset()
    {
        console.log(("[DWLevelEditor] found %1 tiles").arg(tileFiles.length));

        tileFiles.forEach(function (tile){

        });

    }

    EDialog
    {
        id: objectsDialog

        GridView
        {
            anchors.fill: parent
            model: objLib.length
            cellHeight: 56
            cellWidth: 56

            delegate: EObjectDisplay {
                name: objLib[index].name.toUpperCase()
                imageSource: resBase + objLib[index].displayImage
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        objCurrent = (index);
                        objectsDialog.dismiss();
                    }
                }
            }
        }
    }

}

