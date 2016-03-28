import QtQuick 2.4

DWSSFieldItem {
    width: 24
    height: 48

    AnimatedSprite
    {
        source: resBase + "player/cd-ss.png"
        frameX: 44
        frameY: 280
        frameWidth: 24
        frameHeight: 48
        height: frameHeight
        width: frameWidth
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        frameCount: 1

    }
}

