import QtQuick 2.4
import dw 1.0
import ".."


AnimatedSprite{
    id: bubbler

    width: 16
    height: 16
    z: field.objAZ

    property bool notStub: true
    property int managerIndex: -1
    property alias active: updater.enabled
    function activate(){ objManager.objCount++; updater.enabled = true; }
    function deactivate(){ objManager.objCount--; updater.enabled = false; }

    property real timeAccum: 0
    property real timeToNextBubble: 0.75

    property int bigCountdown: 7

    source: resBase + "obj/spr/bubbler.png"
    frameWidth: 16
    frameHeight: 16
    frameCount: 2
    frameDuration: convertGenesisTime(32) * 1000
    interpolate: false
    running: visible

    DWEveryFrame
    {
        id: updater
        onUpdate:
        {
            visible = field.waterY < y;

            if(visible) timeAccum += dt;
            if(timeAccum > timeToNextBubble)
            {
                timeAccum = 0;
                var c = Qt.createComponent("ObjBubble.qml");
                var o = c.createObject(field);

                if(bigCountdown)
                {
                    o.sizeLimit = Math.random()*3;
                    bigCountdown--;
                }else
                {
                    o.sizeLimit = 5;
                    bigCountdown = Math.round(6 + Math.random()*7);
                }

                o.x = x + 4;
                o.y = y + 4;
            }

        }
    }
}
