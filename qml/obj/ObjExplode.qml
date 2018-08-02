import QtQuick 2.4
import dw 1.0

Item {

    id: explosion
    z: field.objSfxZ

    DWSprite
    {
        x: -24
        y: -24
        spritesheet: resBase + "obj/obj-common.dws?explode"
        scale: 1.2

        onAnimationLooped: {explosion.visible = false; explosion.destroy();}
    }


}
