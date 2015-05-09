import QtQuick 2.0

Item {
    width: 100
    height: 62

    x: Math.round(itemX - width/2)
    y: Math.round(itemY - width/2 - itemZ)

    property real itemX: 0
    property real itemY: 0
    property real itemZ: 0



    property bool hasShadow: true

    Image
    {
        id: shadow
        visible: hasShadow
        width: parent.width
        height: parent.width/2
        y: parent.height + itemZ - height/2
        z: -1
        source: resBase + "common/shadow.png"
        smooth: false
        opacity: 0.5
        scale: Math.max(0.3, 1 - itemZ / 200)
    }

}

