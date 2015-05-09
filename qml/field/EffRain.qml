import QtQuick 2.0
import dw 1.0

Image {

    id: rainOverlay
    source: resBase + "field/rain/overlay.png"

    width: field.viewWidth + sourceSize.width * 2
    height: Math.max( 0, Math.min( field.viewHeight + sourceSize.height * 2, field.waterY - y ) )

    x: -field.x - offsetX%sourceSize.width - sourceSize.width
    y: -field.y - offsetY%sourceSize.height - sourceSize.height
    z: field.fgZ

    property var splashes: []
    property int numSplashes: Qt.platform.os == "android"? 4 : 6
    property int offsetX: 0
    property int offsetY: 0

    enabled: true
    opacity: enabled? 1 : 0

    Behavior on opacity {
        NumberAnimation
        {
            duration: 1500
        }
    }


    fillMode: Image.Tile



    DWEveryFrame
    {
        enabled: rainOverlay.opacity != 0

        onUpdate:
        {
            offsetX += 16 * Math.random();
            offsetY -= 64 * Math.random();

            for(var i = 0; i < numSplashes; i++)
            {
                splashes[i].visible = false;

                var alpha = Math.random();
                var rayX = x + width * alpha;
                var rayY = y + Math.random()*height/4;
                var rayYEnd = rayY + height;
                var hitsWater = false;

                if(field.water)
                {
                    if(rayY > field.waterY) continue;
                    if(rayYEnd > field.waterY)
                    {
                        rayYEnd = field.waterY;
                        hitsWater = true;
                    }
                }

                var closest = physicsWorld.raycastClosestDistance(rayX, rayY, rayX, rayYEnd,
                                                    DWFieldPhysicsWorld.CC_LAYER_A | DWFieldPhysicsWorld.CC_LAYER_A_ONLYTOP |
                                                    DWFieldPhysicsWorld.CC_LAYER_B | DWFieldPhysicsWorld.CC_LAYER_B_ONLYTOP );
                if(closest > 0 || hitsWater)
                {
                    splashes[i].x = Math.round(-x + rayX - splashes[i].width/2);
                    if(closest > 0)
                        splashes[i].y = Math.round(-y + rayY + closest*(rayYEnd - rayY) - splashes[i].height);
                    else // has hit water
                        splashes[i].y = Math.round(-y + field.waterY - splashes[i].height);


                    splashes[i].visible = true;
                    splashes[i].mirror = i % 2;
                }
            }
        }
    }

    Repeater
    {
        model: numSplashes

        Image
        {
            id: splash
            source: resBase + "field/rain/splash.png";
            Component.onCompleted: splashes[index] = splash
        }

    }
}
