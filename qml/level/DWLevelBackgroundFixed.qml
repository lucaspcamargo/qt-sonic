import QtQuick 2.0

Image {

    property var args: null

    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop

    source: args? resBase + levelData.urlPrefix + "bg/" + args.bgName : ""
}
