import QtQuick 2.0
import QtMultimedia 5.0
import ".."
import dw 1.0

Item
{
    id: ssScene
    anchors.fill: parent


    Image
    {
        anchors.fill: parent
        source: resBase + "../etc/transparent.png"
        fillMode: Image.Tile
    }

    Item
    {
        id: ssField
        property int viewAtX: 0
        property int viewAtY: 0
        property int viewAtZ: 0

        x: Math.round(-viewAtX + parent.width / 2)
        y: Math.round(-viewAtY + parent.height / 2)

        DWSSPlayer
        {
            id: testItem

            DWEveryFrame
            {
                onUpdate:
                {
                    testItem.itemX += controls.directionValueX * dt * 128;
                    testItem.itemY -= controls.directionValueY * dt * 128;
                    if(controls.aPressed) testItem.itemZ += dt * 128;
                    if(controls.bPressed) testItem.itemZ -= dt * 128;
                    testItem.itemZ = Math.max(testItem.itemZ, 0);
                }
            }
        }
    }

    Audio
    {
        source: resBase + "../music/pseudo-paradise-s0lv0.ogg"
        autoPlay: true
    }


    DWLevelHud
    {
        id: hud
    }

    DWControls
    {
        id: controls
        anchors.centerIn: parent
        height: 900
        width: height * parent.width/parent.height
        scale: parent.height / height
        //visible: Qt.platform.os == "android"
    }

    Component.onCompleted:
    {
        globalFader.opacity = 0;
        controls.keyboardHandler.forceActiveFocus();
    }
}
