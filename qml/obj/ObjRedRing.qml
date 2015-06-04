import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject{
    id: ring

    width: 32
    height: 32
    z: field.objAZ

    property bool collected: false


    AnimatedSprite{
        source: resBase + "obj/spr/redRing.png"
        width: 32
        height: 32
        frameWidth: 32
        frameHeight: 32
        frameCount: 8
        frameDuration: convertGenesisTime(4) * 1000
        interpolate: false
    }
    Item
    {
        id: collision
        x: parent.x + 2
        y: parent.y + 2
        width: 28
        height: 28
    }

    DWEveryFrame
    {
        id: updater
        enabled: active
        onUpdate:
        {
            if(!collected && overlapPlayerI(collision))
            {
                if(managerIndex >= 0) objManager.objectDestroyed(managerIndex);
                collected = true;
                collectedTimer.running = true;

                sfx.play();
            }
        }
    }

    DWSoundEffect
    {
        id: sfx
        source: resBase + "obj/sfx/redring.wav.ogg"
    }
    SequentialAnimation
    {
        id: collectedTimer
        running: false

        NumberAnimation {
            target: ring
            property: "scale"
            duration: 750
            from: 1
            to: 0
            easing.type: Easing.InOutQuad

        }

        ScriptAction
        {
            script:
            {

                var tmp = fieldController.redRings;

                for(var i = 0; i < tmp.length; i++)
                {
                    if(tmp[i] === false)
                    {
                        tmp[i] = true;
                        break;
                    }
                }

                fieldController.redRings = tmp;

                ring.destroy();

            }
        }
    }
}
