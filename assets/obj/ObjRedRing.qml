import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject{
    id: ring

    width: 32
    height: 32
    z: field.objAZ

    property bool collected: false


AnimatedSprite{
    source: "spr/redRing.png"
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
        source: "sfx/redring.wav.ogg"
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
                ring.destroy();
            }
        }
    }
}
