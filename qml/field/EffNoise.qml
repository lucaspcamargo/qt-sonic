import QtQuick 2.0
import dw 1.0

Image
{
    id: noise
    parent: scene
    width: parent.width * 2
    height: parent.height * 2
    source: resBase + "field/fx/noise.png"
    fillMode: Image.Tile

    DWEveryFrame
    {
        onUpdate: {
            noise.x = -Math.random()*noise.parent.width;
            noise.y = -Math.random()*noise.parent.height;
        }
    }

}
