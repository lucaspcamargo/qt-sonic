import QtQuick 2.0
import dw 1.0
import ".."


AnimatedSprite{
    id: flicky

    width: 24
    height: 24
    z: field.objAZ

    property bool notStub: true
    property int managerIndex: -1
    property real xS: 0
    property real yS: -7*60

    property bool goingAway: false

    property int type: Math.round(Math.random())
    source: "spr/flicky-"+type+".png"
    frameWidth: 24
    frameHeight: 24
    frameCount: 1
    frameDuration: convertGenesisTime(4) * 1000
    interpolate: false

    transform: Rotation{ origin.x: 12; axis: Qt.vector3d(0,1,0); angle: xS <= 0? 0 : 180 }
    transformOrigin: Item.Bottom

    DWEveryFrame
    {
        onUpdate:
        {
                yS += 0.25 * 60 * 60 * dt;

                flicky.x += xS * dt;
                flicky.y += yS * dt;

                var categoriesDown = 0x04 | 0x08 | 0x10 | 0x20;
                var categories = 0x04 | 0x08;

                if(yS > 0)
                {
                    var rayCastDown = physicsWorld.raycastClosestDistance(flicky.x + flicky.width / 2, flicky.y + flicky.height / 2, flicky.x + flicky.width / 2, flicky.y+flicky.height, categoriesDown);
                    if(rayCastDown > 0)
                    {
                        flicky.yS *= -1;
                        if(flicky.yS > -60) flicky.yS = 60;
                        flicky.y -= (flicky.height/2)*rayCastDown;

                        if(!goingAway)
                        {
                            xS = (field.viewCenterAtX > x)? -100 : 100;
                            frameX = 24;
                            frameCount = 2;
                            yS = -5*60;
                            goingAway = true;
                        }
                    }
                }

                if(goingAway && !overlapViewI(flicky))
                {
                    flicky.destroy();
                    if(managerIndex > 0) objManager.objectDestroyed(managerIndex);
                }


        }
    }
}
