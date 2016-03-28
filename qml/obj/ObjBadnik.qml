import QtQuick 2.4
import dw 1.0
import ".."

ObjBadnikBase {

    id: badnik

    gibsEnabled: true
    gibCount: 6
    gibLocation: resBase + "obj/badnik/default/gib-%1.png"

    Image{
        id: sprite
        source: resBase + "obj/obj/badnik.png"
        smooth: false
    }

    DWEveryFrame
    {
        id: updater
        enabled: badnik.active && field.fieldActive
        onUpdate:
        {
            if(previousXDelta - xDelta) sprite.mirror = (previousXDelta - xDelta > 0);
            x += previousXDelta - xDelta;
            previousXDelta = xDelta;

            if(overlapPlayerI(badnik))
            {
                if(player.playerRolling || player.playerHarmful)
                {
                    reboundPlayer();
                    pop();
                }
                else
                {
                    hitPlayer();
                }
            }
        }
    }

    property real xDelta: 0
    property real previousXDelta: 0

    SequentialAnimation on xDelta
    {
        loops: Animation.Infinite
        NumberAnimation { to: -32; duration: 1750 + Math.random()*250; }
        NumberAnimation { to: +32; duration: 1750 + Math.random()*250; }
    }
}
