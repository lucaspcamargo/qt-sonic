import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject {
    id: tile
    z: options.z
    property var options: null
    property bool sizeMatters: true

    property bool needsUpdate: z !== field.layerAZ

    property real parallaxFactor: z === field.fgZ? 0.2 : -0.03
    property real deltaY: y + height/2 - field.viewCenterAtY

    DWImageItem {
        id: tileImage
        source: resBase + levelData.urlPrefix + "tileset/" + options.tileFile
        width: parent.width
        height: parent.height
    }

    function update()
    {
        tileImage.x = parallaxFactor * (x + width/2 - field.viewCenterAtX)
        tileImage.y = parallaxFactor * (y + height/2 - field.viewCenterAtY)
    }

    Component.onCompleted: if(needsUpdate) objManager.updateObjects.connect(update);
    onActivated: if(needsUpdate) objManager.updateObjects.connect(update);
    onDeactivated: if(needsUpdate) objManager.updateObjects.disconnect(update);
    Component.onDestruction: if(needsUpdate) objManager.updateObjects.disconnect(update);
}

