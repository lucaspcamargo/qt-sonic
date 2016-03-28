import QtQuick 2.4
import dw 1.0
import ".."

Item {

    id: spring

    width: 32
    height: 16
    z: field.objAZ

    property bool yellow: false
    property bool notStub: true
    property bool setRot: true

    property int openFrames: 0
    property int managerIndex: -1
    property alias active: updater.enabled
    visible: updater.enabled
    function activate(){ objManager.objCount++; updater.enabled = true; }
    function deactivate(){ objManager.objCount--; updater.enabled = false; }

    function morph( opts )
    {
        if(opts.indexOf("y") >= 0)
        {
            yellow = true;
        }
        else yellow = false;
    }

    DWSprite
    {
        id: sprite
        spritesheet: resBase + (yellow? "obj/obj-common.dws?spring-y" : "obj/obj-common.dws?spring")
        anchors.fill: parent
        visible: openFrames == 0
        running: false
    }

    DWSprite
    {
        id: openSprite
        spritesheet: resBase + (yellow? "obj/obj-common.dws?spring-y-open" : "obj/obj-common.dws?spring-open")
        visible: openFrames > 0
        y: -16
        running: false
    }

    DWSprite
    {
        id: platform
        spritesheet: resBase + "obj/obj-common.dws?spring-platform"
        y: 16
        running: false
    }


    DWFOPhysicsBody {
        id: physicsBody
        active: spring.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_POLY_BOX
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(16, 8, 0, 0)
        origin: Qt.point(16, 8)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        onCollision: {
            collided();
        }
    }

    DWSoundEffect
    {
        id: springSfx
        source: resBase + (yellow? "obj/sfx/spring.wav.ogg" : "obj/sfx/spring2.wav.ogg")
    }

    DWEveryFrame
    {
        id: updater
        enabled: spring.active
        onUpdate:
        {

            if(openFrames > 0)
            {
                openFrames--;
            }
        }
    }

    function collided()
    {
        if(openFrames) return;

        // reset before applying our own maybe
        player.resetControlLocks();

        var baseSpeed = convertGenesisSpeed(yellow? 10 : 16);

        if(rotation === 0 || rotation === 180)
        {
            player.gAngle = 0;
            player.playerState = DWPlayerBase.PS_AIR;
            player.ySpeed = baseSpeed  * (rotation === 0? -1 : 1);
        }
        else if(rotation === 90 || rotation === 270)
        {
            player.setHorizontalControlLock(0.2);

            if(player.playerState == DWPlayerBase.PS_AIR)
                player.xSpeed = baseSpeed * (rotation===270? -1 : 1);
            else
                player.gSpeed = baseSpeed * (rotation===270? -1 : 1) * (player.playerQuadMode !== 0? -1 : 1);

            player.turnedBack = player.playerQuadMode === 0? rotation===270 : rotation !==270;
        }else
        {
            player.xSpeed = baseSpeed * Math.sin(rotation*Math.PI/180);
            player.ySpeed = -baseSpeed * Math.cos(rotation*Math.PI/180);
        }

        if(0)
        {
            if(player.playerState == DWPlayerBase.PS_AIR)
                player.xSpeed = baseSpeed * (reversed? -1 : 1);
            else
                player.gSpeed = baseSpeed * (reversed? -1 : 1) * (player.playerQuadMode !== 0? -1 : 1);
            player.turnedBack = reversed;

        }

        if(player.playerState == DWPlayerBase.PS_AIR)
        {
            player.setAnimation("spring");
        }
        player.playerRolling = false;
        player.playerJumping = false;
        springSfx.play();

        openFrames = 4;

    }
}
