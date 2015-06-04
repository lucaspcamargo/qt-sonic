import QtQuick 2.4
import dw 1.0
import ".."


Image{
    id: bubble

    width: 8
    height: 8
    z: field.fgZ

    property bool notStub: true
    property real yAccum;

    property real timeToFullSize: 1
    property real timeAccum;

    property int size: 0
    property int sizeLimit: 1
    source: resBase + "obj/spr/bubble-"+size+".png"

    onSourceSizeChanged:
    {
        x -= (sourceSize.width - width) / 2;
        y -= (sourceSize.height - height) / 2;
        width = sourceSize.width;
        height = sourceSize.height;
    }

    DWEveryFrame
    {
        enabled: field.fieldActive

        onUpdate:
        {
            yAccum -= dt * (32 + 16*((5-size)/5));
            if(yAccum < 1)
            {
                yAccum += 1;
                y--;
            }

            if(size == 5 )
            {
                if(overlapI(bubble, player))
                {
                    bubble.destroy();
                    player.breathe();
                }
            }

            if(size < sizeLimit)
            {
                timeAccum += dt;
                if(timeAccum > timeToFullSize/(sizeLimit+1))
                {
                    timeAccum = 0;
                    size ++;
                }
            }


            x += Math.round((1 - size/5) * 2 * (0.5-Math.random()));

            if(!field.overlapViewI(bubble) || (y + height/2) < field.waterY)
            {
                bubble.destroy();
            }

        }
    }
}
