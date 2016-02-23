import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject {
    id: trigger

    z: field.objAZ
    width: 128
    height: 128

    //onParentChanged: z = field.objAZ

    sizeMatters: true

    signal triggered(real dt)
    signal collisionEnded()
    property bool colliding: false
    property bool continuous: false

    Image
    {
        anchors.fill: parent
        source: resBase + "rage-16/spr/vortex.png"
    }


    DWEveryFrame
    {
        id: updater
        enabled: active
        onUpdate:
        {

            if(overlapPlayerI(trigger))
            {
                if(!continuous && colliding) return;

                trigger.triggered(dt);
                colliding = true;
            }
            else
            {
                if(colliding)
                {
                    collisionEnded();
                    colliding = false;
                }
            }
        }
    }

    onTriggered:
    {
        var tmp = fieldController.redRings;

        for(var i = 0; i < tmp.length; i++)
        {
            if(tmp[i] === false)
            {
                field.player.x = levelData.playerX;
                field.player.y = levelData.playerY;
                sfx.play();
                return;

            }
        }

        mainContentLoader.source =  Qt.resolvedUrl("../rage-16/SBAWin.qml");
    }

    DWSoundEffect
    {
        id: sfx
        source: resBase + "rage-16/vortex.ogg"
    }


    NumberAnimation {
        target: trigger
        property: "rotation"
        duration: 500
        easing.type: Easing.Linear
        loops: Animation.Infinite
        running: true
        from: 0
        to: 360
    }
}

