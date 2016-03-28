import QtQuick 2.0
import dw 1.0

Item
{
    anchors.centerIn: parent
    height: 960
    width: 1706
    scale: parent.height / height

    DWImageItem
    {
        id: sky

        anchors.fill: parent
        source: "bg0-sky.jpg"
    }


    DWImageItem
    {
        id: moon
        source: "bg0-moon.png"

        x: 1400 + (-field.viewCenterAtX * 0.01 * 4 - field.fieldTime*0.1)
        y: 100
        opacity: 0.5

    }

    DWImageItem
    {
        id: clouds
        source: "bg0-clouds.png"

        x: (-field.viewCenterAtX * 0.015 * 4 - field.fieldTime*10) % width
        y: 100 + (-field.viewCenterAtY * 0.007 * 4)

    }
    DWImageItem
    {
        source: "bg0-clouds.png"
        anchors.top: clouds.top
        anchors.left: clouds.right
    }
    DWImageItem
    {
        source: "bg0-clouds.png"
        anchors.top: clouds.top
        anchors.right: clouds.left
    }


    DWImageItem
    {
        id: mountainsA
        source: "bg0-mountains-a.png"

        x: (-field.viewCenterAtX * 0.03 * 4) % (width-100)
        y: 500 + (-field.viewCenterAtY * 0.015 * 4)

    }
    DWImageItem
    {
        source: "bg0-mountains-a.png"
        anchors.top: mountainsA.top
        anchors.left: mountainsA.right
        anchors.leftMargin: -100
    }
    DWImageItem
    {
        source: "bg0-mountains-a.png"
        anchors.top: mountainsA.top
        anchors.right: mountainsA.left
        anchors.rightMargin: -100
    }

    DWImageItem
    {
        id: mountainsB
        source: "bg0-mountains-b.png"

        x: (-field.viewCenterAtX * 0.04 * 4) % (width-100)
        y: 510 + (-field.viewCenterAtY * 0.02 * 4)

    }
    DWImageItem
    {
        source: "bg0-mountains-b.png"
        anchors.top: mountainsB.top
        anchors.left: mountainsB.right
        anchors.leftMargin: -100
    }
    DWImageItem
    {
        source: "bg0-mountains-b.png"
        anchors.top: mountainsB.top
        anchors.right: mountainsB.left
        anchors.rightMargin: -100
    }

    DWImageItem
    {
        id: mountainsC
        source: "bg0-mountains-c.png"

        x: (-field.viewCenterAtX * 0.06 * 4) % (width-100)
        y: 480 + (-field.viewCenterAtY * 0.03 * 4)

    }
    DWImageItem
    {
        source: "bg0-mountains-c.png"
        anchors.top: mountainsC.top
        anchors.left: mountainsC.right
        anchors.leftMargin: -100
    }
    DWImageItem
    {
        source: "bg0-mountains-c.png"
        anchors.top: mountainsC.top
        anchors.right: mountainsC.left
        anchors.rightMargin: -100
    }

    DWImageItem
    {
        id: ground
        source: "bg0-ground.png"

        x: (-field.viewCenterAtX * 0.08 * 4) % (width-200)
        y: 800 + (-field.viewCenterAtY * 0.04 * 4)

    }
    DWImageItem
    {
        source: "bg0-ground.png"
        anchors.top: ground.top
        anchors.left: ground.right
        anchors.leftMargin: -200
    }
    DWImageItem
    {
        source: "bg0-ground.png"
        anchors.top: ground.top
        anchors.right: ground.left
        anchors.rightMargin: -200
    }

    DWImageItem
    {
        id: fg
        source: "bg0-fg.png"

        x: (-field.viewCenterAtX * 0.1 * 4) % width
        y: 940 + (-field.viewCenterAtY * 0.05 * 4)
        opacity: 1
    }
    DWImageItem
    {
        source: "bg0-fg.png"
        anchors.top: fg.top
        anchors.left: fg.right
        anchors.leftMargin: 0
        opacity: 1
    }
    DWImageItem
    {
        source: "bg0-ground.png"
        anchors.top: fg.top
        anchors.right: fg.left
        anchors.rightMargin: 0
        opacity: 1
    }
}
