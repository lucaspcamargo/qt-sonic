import QtQuick 2.3
import QtMultimedia 5.0
import dw 1.0
import "level"
import "field"

Item {
    id: scene
    anchors.fill: parent

    property url levelFile: resBase + "oz/oz.json"
    property var levelData: (JSON.parse(DWUtil.readTextFile(levelFile)))

    Item
    {
        id: fieldContainer

        height: 240
        scale: parent.height / height
        width: height * parent.width/parent.height
        anchors.centerIn: parent

        Rectangle
        {
            id: bgColor
            z: field.bgZ - 1
            anchors.fill: parent
            visible: levelData.bgColor? true : false
            Component.onCompleted:
            {
                if(visible)
                    color = levelData.bgColor;
                else
                    bgColor.destroy();
            }
        }

        Item
        {
            id: bgContainer
            anchors.fill: parent

            DWLevelBackground {
                id: bg
                inPrefix: true
            }

        }


        Image
        {
            id: editorCheckerboard
            anchors.fill: parent
            source: resBase + "etc/transparent.png"
            fillMode: Image.Tile
            visible: false
        }

        DWLevelField {
            id: field
        }


        DWFieldController
        {
            id: fieldController
        }


        Image
        {
            id: hurtOverlay
            source: resBase + "field/fx/hurt-overlay.png"
            anchors.fill: parent
            opacity: 0

            function playAnimation(){ hurtOverlayAnim.start() }

            SequentialAnimation
            {
                id: hurtOverlayAnim
                running: false

                PropertyAction
                {
                    target: hurtOverlay
                    property: "opacity"
                    value: 0.75
                }

                PropertyAnimation
                {
                    target: hurtOverlay
                    property: "opacity"
                    to: 0.0
                }

            }
        }

        Image
        {
            id: drownOverlay
            source: resBase + "field/fx/drown-overlay.png"
            anchors.fill: parent
            opacity: 0

            Behavior on opacity { NumberAnimation {} }

            property real originalChromatic: 0
            Component.onCompleted: originalChromatic = screenRendererWater.chromatic;
            onOpacityChanged: screenRendererWater.chromatic = originalChromatic + 5 * opacity;

            SequentialAnimation
            {
                id: drownOverlayAnim
                running: false

                PropertyAnimation
                {
                    target: drownOverlay
                    property: "opacity"
                    to: 1.0
                    duration: 12000
                }

            }
        }

    }

    DWControls
    {
        id: controls
        anchors.fill: parent
        focus: true
        visible: _DW_MOBILE
        opacity: 0.8

        dPadMode: true
    }

    DWLevelHud
    {
        id: hud
        anchors.fill: parent

        //z: field.hudZ

        showScore: true
        scoreValue: fieldController.score
        timeValue: field.fieldTime
        ringsValue: fieldController.rings
    }

    Rectangle
    {
        id: sceneFader
        color: "black"
        anchors.fill: parent
        visible: (!_DW_DEBUG) && opacity != 0

        Behavior on opacity { NumberAnimation{duration: 500}}
        Behavior on color { ColorAnimation{ duration: 600 } }
    }

    DWLevelTitlecard
    {
        id: sceneTitle
    }

    property alias titleAnimation: sceneTitle.titleAnimation


    DWLevelBGMPlayer
    {
        id: bgmPlayer
    }

    property var levelEditor: null

    Component.onCompleted:
    {
        // create bgms
        bgmPlayer.init();

        //create backgrounds
        for(var i = 0; i < levelData.bgs.length; i++)
        {
            var bgArgs = levelData.bgs[i];

            if(bgArgs.bgType === "fixed")
            {
                var c = Qt.createComponent("level/DWLevelBackgroundFixed.qml");
                c.createObject(bgContainer, {args:bgArgs});
            }
        }

        // render to texture
        offscreen = true;

        //setup editor
        if(_DW_DEBUG) {
            var c = Qt.createComponent("tools/DWLevelEditor.qml");
            levelEditor = c.createObject(this);
        }
        else
        {
            editorCheckerboard.destroy();
        }

        // init field
        field.init();
        titleAnimation.running = true;
    }

}
