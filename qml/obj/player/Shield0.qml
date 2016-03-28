import QtQuick 2.4
import dw 1.0

DWSprite
{
    id: shield
    spritesheet: resBase + "obj/player/fx.dws?shield-0"
    running: visible
    width: 48
    height: 48
    visible: false

    opacity: visible? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 100 } }

    scale: visible? 1 : 3
    Behavior on scale { NumberAnimation { duration: 100 } }

    x: -24
    y: -24
    z: 1

}
