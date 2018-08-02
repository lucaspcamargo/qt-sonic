import QtQuick 2.5
import dw 1.0
import ".." 1.0
import "editor" 1.0

Item {

    id: levelEditor

    anchors.fill: parent
    anchors.centerIn: parent
    visible: false

    function mapToFieldX(x)
    {
        var screenX = x * levelEditor.scale;
        var containerX = screenX / fieldContainer.scale;
        return (containerX - field.x) / field.viewScale;
    }

    function mapToFieldY(y)
    {
        var screenY = y * levelEditor.scale;
        var containerY = screenY / fieldContainer.scale;
        return (containerY - field.y) / field.viewScale;
    }

    function mapToScreenX(x)
    {
        return (x * field.viewScale + field.x) * fieldContainer.scale / levelEditor.scale;
    }

    function mapToScreenY(y)
    {
        return (y * field.viewScale + field.y) * fieldContainer.scale / levelEditor.scale;
    }

    property bool cursorOnField: editorMouseArea.containsMouse
    property real fieldScale: (field.viewScale * fieldContainer.scale)
    property int cursorPreciseX: mapToFieldX(editorMouseArea.mouseX)
    property int cursorPreciseY: mapToFieldY(editorMouseArea.mouseY)
    property int cursorX: snapEnabled? Math.round(cursorPreciseX/snapAmount) * snapAmount : cursorPreciseX
    property int cursorY: snapEnabled? Math.round(cursorPreciseY/snapAmount) * snapAmount : cursorPreciseY

    property bool snapEnabled: true
    property int snapAmount: 8
    function changeSnapAmount() {snapAmount *= 2; if(snapAmount > 128) snapAmount = 8;}

    property int editMode: 0
    property var editModeNames: [ "OBJECTS", "TILESET", "GEOMETRY" ]
    function changeEditMode() { editMode = (editMode+1)%editModeNames.length; currRotation = 0; geomLast = null; geomDrawer.clear(); }

    property var handlesLayer: null

    property int objCurrent: 0
    property var objShortcuts: [0,1,2,3,4,5,6,7,8,9]
    property var objLib: [
        {name: "Ring", sprite:"obj/obj-common.dws?ring"},
        {name: "Spring", sprite:"obj/obj-common.dws?spring", options:[ {name: "yellow", type: "Boolean"} ] },
        {name: "Monitor", sprite:"obj/obj-common.dws?monitor"},
        {name: "Spikes", sprite:"obj/obj-common.dws?spikes"},
        {name: "Checkpoint", sprite:"obj/obj-common.dws?checkpoint"},
        {name: "DashRing", sprite:"obj/obj-common.dws?dashring-front"},
        {name: "Trigger", sprite:"obj/obj-common.dws?ring"},
        {name: "BadnikOrbinaut", sprite:"obj/badniks-common.dws?orbinaut-body"},
        {name: "Bridge", sprite:"obj/badniks-common.dws?orbinaut-spike"},
        {name: "RedRing", sprite:"obj/obj-common.dws?redring"},
        {name: "Ring", sprite:"obj/badniks-common.dws?orbinaut-blink"},
        {name: "Ring", sprite:"obj/badniks-common.dws?orbinaut-spike"},
        {name: "Ring", sprite:"obj/obj-common.dws?ring"},
        {name: "Ring", sprite:"obj/obj-common.dws?ring"},
    ]

    property url tileLocation: resBase + levelData.urlPrefix + "tileset"
    property url tilePrefix: tileLocation + "/"
    property var tileFiles: DWUtil.listFiles(tileLocation)
    property int tileCurrent: 0
    property var tileAttachment: {"null": [] }

    property real currRotation: 0

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
                if(editMode == 2 && geomDrawer.hasLine())
                    geomFinish();
                else
                {
                    handlesLayer.selectAt(cursorX, cursorY);
                }
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
                else if(editMode == 1)
                    placeTile();
                else if(editMode == 2)
                    geomPlace();
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
                field.viewCenterAtX = fieldOriginalX - (mouse.x - originalX)/fieldScale;
                field.viewCenterAtY = fieldOriginalY - (mouse.y - originalY)/fieldScale;
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
        x: Math.round( mapToScreenX(cursorX) )
        visible: editorMouseArea.containsMouse
    }

    Rectangle
    {
        id: cursorGuideHorizontal
        width: parent.width
        height: 1
        y: Math.round( mapToScreenY(cursorY) )
        visible: editorMouseArea.containsMouse
    }


    DWSprite
    {
        id: objectDisplayImage
        visible: editMode == 0
        x: cursorGuideVertical.x
        y: cursorGuideHorizontal.y
        opacity: 0.5
        spritesheet: resBase + objLib[objCurrent].sprite
        transform: [

             Scale{
                 xScale: yScale
                 yScale:  fieldScale/levelEditor.scale
             },

             Rotation
             {
                 origin.x: objectDisplayImage.width / 2 * fieldScale/levelEditor.scale
                 origin.y: objectDisplayImage.height / 2 * fieldScale/levelEditor.scale
                 angle: currRotation
             }

         ]
    }

    DWImageItem
    {
        id: tileDisplayImage
        visible: editMode == 1
        x: cursorGuideVertical.x
        y: cursorGuideHorizontal.y
        opacity: 0.5
        source: tileFiles[tileCurrent]

        transform: [

            Scale{
                xScale: yScale
                yScale:  0.25 * fieldScale/levelEditor.scale
            },

            Rotation
            {
                origin.x: tileDisplayImage.width / 2 * 0.25 * fieldScale/levelEditor.scale
                origin.y: tileDisplayImage.height / 2 * 0.25 * fieldScale/levelEditor.scale
                angle: currRotation
            }

        ]
    }

    Text
    {
    }

    DWTextBitmap {
        id: geomModeDisplay
        visible: editMode == 2
        x: cursorGuideVertical.x + 2
        y: cursorGuideHorizontal.y + 2
        font: "xexex-multi"
        text: "LINES"
        offset: 95 * 6
    }

    EGeomDrawer
    {
        id: geomDrawer
        parent: fieldContainer
        x: field.x
        y: field.y
        scale: field.scale
    }

    Rectangle
    {
        id: editorMenuBar

        height: 14
        width: parent.width

        color: "#ee000000"

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
                text: "SET ATTACHMENT"
                onClicked: setTileAttachment()
                textColor: 1
            }

            Item{width: 5; height: 5;}

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
        visible: editMode == 0

        x: 2
        y: 16

        spacing: 2

        EObjectDisplay
        {
            id: objDisplayCurrent

            label: "CURR"
            name: objLib[objCurrent].name.toUpperCase()
            sprite: resBase + objLib[objCurrent].sprite
        }
        Repeater
        {
            model: 10

            EObjectDisplay
            {
                label: (index + 1) % 10
                name: objLib[objShortcuts[index]].name.toUpperCase()
                sprite: resBase + objLib[objShortcuts[index]].sprite
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
        visible: editMode == 1


        color: "#000"

        border.color: "#88aa00"
        border.width: 1
        clip: true

        width: parent.width - 40
        height: 48
        anchors.left: parent.left
        anchors.leftMargin: 20
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

            orientation: Qt.Horizontal

            spacing: 4

            model: tileFiles.length

            delegate: Image {

                source: tileFiles[index]
                height: 40
                width: 40

                fillMode: Image.PreserveAspectFit

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: tileCurrent = index
                }

            }

        }

    }

    EPropertyPane
    {
        id: propPane
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

        EButton            {
            text: "HELP ME PLS"
            onClicked: helpDialog.show()
            anchors.right: parent.right
            anchors.rightMargin: 2
            textColor: 6

            transformOrigin: Item.BottomRight
            scale: 2
        }
    }

    function placeObject( )
    {
        // x, y, w, h, rot, xc, yc, radius, name, opts, inPrefix
        var createdIndex = field.objectManager.addObjectStub(cursorX, cursorY,
                                                             objectDisplayImage.width, objectDisplayImage.height,
                                                             currRotation,
                                                             cursorX + objectDisplayImage.width/2, cursorY + objectDisplayImage.height/2,
                                                             64, objLib[objCurrent].name, null, false);
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
        DWUtil.writeTextFile(resBase+levelData.urlPrefix+"tilesetAttachment.json", JSON.stringify(tileAttachment, null, 2));
    }

    function placeTile( )
    {
        var tileFile = tileFiles[tileCurrent].substr(tileFiles[tileCurrent].lastIndexOf("/") + 1);

        var x = cursorX;
        var y = cursorY;
        var w = tileDisplayImage.width*0.25;
        var h = tileDisplayImage.height*0.25;
        var xC = x + tileDisplayImage.width*0.125;
        var yC = y + tileDisplayImage.height*0.125;
        var createdIndex = field.objectManager.addObjectStub(x, y, w, h, currRotation, xC, yC, Math.max(w, h), "Tile", {"tileFile": tileFile, "z": tileFile.indexOf("bg-b-")!==-1? field.layerBZ : (tileFile.indexOf("fg-f-")!==-1? field.fgZ :field.layerAZ)}, false);
        field.objectManager.createObject(createdIndex);
        handlesLayer.createHandle(createdIndex);

        //now for the attachments
        var atts = tileAttachment[tileFile];
        if(atts)
            for(var k in atts)
            {
                var aStub = atts[k];
                var stub = field.objectManager.cloneStubSlow(aStub); // we clone because of the options object

                console.log(JSON.stringify(stub));

                createdIndex = field.objectManager.addObjectStub(stub.x + x, stub.y + y, stub.w, stub.h, stub.rot, stub.xc + x, stub.yc + y, stub.radius,
                                                                 stub.name, stub.options, stub.inPrefix);
                field.objectManager.createObject(createdIndex);
                handlesLayer.createHandle(createdIndex);

            }
    }

    function setTileAttachment( )
    {
        var selectedIds = handlesLayer.getSelectedIds();

        if(selectedIds.length)
        {
            // find which one is a tile
            var tileIndex = -1;
            var tileArea = 0;
            console.log(JSON.stringify(selectedIds));
            for(var i in selectedIds)
            {
                var id = selectedIds[i];
                var stub = field.objectManager.objStubs[id];
                var obj = field.objectManager.objs[id];

                // we want to know the largest tile in selection
                if(stub.name == "Tile")
                {
                    var area = obj.width*obj.height;
                    if(area >= tileArea)
                    {
                        tileIndex = id;
                        tileArea = area;
                    }
                }
            }

            if(tileIndex >= 0)
            {
                var tileStub = field.objectManager.objStubs[tileIndex];
                var tileObj = field.objectManager.objs[tileIndex];

                // let's create the attachments
                var atts = [];

                for(var i in selectedIds)
                {
                    id = selectedIds[i];

                    if(id === tileIndex) continue;

                    stub = field.objectManager.objStubs[id];
                    obj = field.objectManager.objs[id];

                    var nStub = field.objectManager.cloneStubSlow(stub);
                    nStub.x -= tileStub.x;
                    nStub.y -= tileStub.y;
                    nStub.xc -= tileStub.x;
                    nStub.yc -= tileStub.y;

                    atts.push(nStub);
                }

                tileAttachment[tileStub.options.tileFile] = atts;

                debugMsg(atts.length +  " attachments for tile "+tileStub.options.tileFile+ " were set.")
            }
            else debugMsg("No tile is selected.");
        }
        else debugMsg("Nothing is selected.");
    }

    property var geomLast: null
    function geomPlace()
    {
        if(geomLast)
            geomDrawer.addLine({start: geomLast, end: Qt.point(cursorX, cursorY)});

        geomLast = Qt.point(cursorX, cursorY);
    }

    function geomFinish()
    {
        geomLast = null;

        var finalLines = geomDrawer.compile();


        if(finalLines)
        {
            var gd = geomDrawer.makeGeomData(finalLines);

            // create geom obj
            var createdIndex = field.objectManager.addObjectStub(gd.minX, gd.minY,
                                                                 gd.maxX - gd.minX, gd.maxY - gd.minY,
                                                                 0,
                                                                 gd.xC, gd.yC,
                                                                 gd.radius * 2, "Geometry", {geomData: gd }, false);
            field.objectManager.createObject(createdIndex);
            handlesLayer.createHandle(createdIndex);
        }

        geomDrawer.clear();
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
        bgContainer.visible = !visible;

        hud.visible = !visible;
        //offscreen = !visible;
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

        if(event.key == Qt.Key_R)
            currRotation = (currRotation+22.5)%360;

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

        var tileAttachmentStr = DWUtil.readTextFile(resBase + levelData.urlPrefix+"tilesetAttachment.json");

        if(tileAttachmentStr)
        {
            tileAttachment = JSON.parse(tileAttachmentStr);
        }

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
                sprite: resBase + objLib[index].sprite
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

    EDialog
    {
        id: helpDialog

        EButton            {
            text: "OK, GOT IT"
            onClicked: helpDialog.dismiss()
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 2

            transformOrigin: Item.BottomRight
            scale: 2
        }
    }
}

