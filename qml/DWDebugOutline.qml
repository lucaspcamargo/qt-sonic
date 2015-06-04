import QtQuick 2.4

Rectangle {
    anchors.fill: parent
    color: "transparent"
    border.width: 1
    border.color: "yellow"
    visible: _DW_DEBUG && _DW_DEBUG_PHYSICS_DRAW

    Component.onCompleted: if(!_DW_DEBUG) destroy();
}
