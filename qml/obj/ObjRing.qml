import QtQuick 2.4
import dw 1.0
import ".."

DWFieldObject{
    id: ring
    width: 16
    height: 16
    z: field.objAZ

    property bool flying: false
    property bool attraction: false
    property bool collected: false
    property real xS: 0
    property real yS: 0

    DWFOPhysicsBody {
        id: physicsBody
        active: ring.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_CIRCLE
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER | DWFieldPhysicsWorld.CC_DYNAMIC
        shapeData: Qt.vector4d(8, 8, 0, 0)
        origin: Qt.point(8, 8)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        onCollision: {
            collect();
        }
    }

    DWSprite {
        id: sprite
        spritesheet: resBase + "obj/obj-common.dws?ring"
        running: ring.visible
        width: 16
        height: 16
    }

    property real prevfmod: 0


    DWEveryFrame
    {
        enabled: ring.active
        //onEnabledChanged: console.log("Ring is now " + (enabled? "active" : "inactive"))
        onUpdate:
        {
            if(!flying)
            {
                var f = field.fieldTime % (8 * 0.0666666666666667);
                if(f < prevfmod) sprite.resetSequence();
                prevfmod = f;

                if(player.hasShield && player.shieldType == 1 && !collected)
                {
                    var vecX = (ring.x+8 - player.x);
                    var vecY = (ring.y + 8 - player.y);
                    var dist = Math.sqrt(vecX*vecX + vecY*vecY);
                    if(dist < 96 && !attraction && !collected)
                    {
                        if(managerIndex >= 0) objManager.objectDestroyed(managerIndex);
                        managerIndex = -1;
                        attraction = true;
                    }

                    if(attraction){
                        vecX /= dist;
                        vecY /= dist;
                        xS -= vecX * dt * 1800 * (xS*vecX > 0? 5 : 1) ;
                        yS -= vecY * dt * 1800 * (yS*vecY > 0? 5 : 1) ;

                        x += xS*dt;
                        y += yS*dt;
                    }

                }else if(attraction && !flying)
                {
                    flying = true;
                }
            }


            if ( ring.flying )
            {

                yS += 0.09375 * 60 * 60 * dt;
                xS /=  Math.abs(xS) / (Math.abs(xS) - 40 * dt);

                ring.x += xS * dt;
                ring.y += yS * dt;

                //if(Math.random() > 0.6) return; //simulate shitty ring collision detection

                var categoriesDown = 0x04 | 0x08 | 0x10 | 0x20;
                var categories = 0x04 | 0x08;

                if(yS > 0)
                {
                    var rayCastDown = physicsWorld.raycastClosestDistance(ring.x + ring.width / 2, ring.y + ring.height / 2, ring.x + ring.width / 2, ring.y+ring.height, categoriesDown);
                    if(rayCastDown > 0)
                    {
                        ring.yS *= -0.75;
                        ring.y -= (ring.height/2)*rayCastDown;
                    }
                } else
                {
                    var rayCastUp = physicsWorld.raycastClosestDistance(ring.x + ring.width / 2, ring.y + ring.height / 2, ring.x + ring.width / 2, ring.y, categoriesDown);
                    if(rayCastUp > 0)
                    {
                        ring.yS *= -0.75;
                        ring.y += (ring.height/2)*rayCastUp;
                    }
                }

            }

        }
    }


    function collect()
    {
        if(collected || player.ringCollectLock > 0) return;

        if(managerIndex >= 0) objManager.objectDestroyed(managerIndex);
        collected = true;
        flying = false;
        attraction = false;
        collectedTimer.running = true;
        fieldController.rings += 1;

        sfx.play( 1, 1, 1-2*Math.random(), 0, -0.75 );

        x = Math.round(x);
        y = Math.round(y);
    }


    DWSoundEffect
    {
        id: sfx
        source: resBase + "obj/sfx/ring.ogg"
    }

    SequentialAnimation
    {
        id: flyingTimer
        running: flying

        PauseAnimation { duration: convertGenesisTime(256 + Math.floor(Math.random()*50)) *1000 }

        PropertyAnimation
        {
            id: fadeAnimation
            target: ring
            property: "opacity"
            to: 0.0

            running: false

        }

        ScriptAction
        {
            script: field.destroyLater(ring)
        }

    }

    SequentialAnimation
    {
        id: collectedTimer
        running: false

        ScriptAction
        {
            script:
            {
                sprite.sequence = "ring-sparkle";
            }
        }

        PauseAnimation { duration: 300 }

        ScriptAction
        {
            script: field.destroyLater(ring)
        }
    }
}
