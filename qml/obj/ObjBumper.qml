import QtQuick 2.0
import dw 1.0
import ".."


Image {

    id: bumper

    width: 32
    height: 32

    property bool notStub: true
    property int managerIndex: -1
    property bool active: true
    visible: active
    function activate(){ active = true; objManager.objCount++; }
    function deactivate(){ active = false; objManager.objCount--; }

    source: resBase + "obj/obj/bumper-32.png"

    DWFOPhysicsBody {
        id: physicsBody
        active: bumper.active
        bodyType: DWFOPhysicsBody.BT_DYNAMIC_SENSOR
        shapeType: DWFOPhysicsBody.ST_CIRCLE
        shapeCategory: DWFieldPhysicsWorld.CC_PLAYER_SENSOR
        shapeCollisionMask: DWFieldPhysicsWorld.CC_PLAYER
        shapeData: Qt.vector4d(16, 16, 0, 0)
        origin: Qt.point(16, 16)

        Component.onCompleted: rebuildBody();

        collisionCallbackEnabled: true
        onCollision: {
            collided();
        }
    }


    function collided()
    {
        var spd = convertGenesisSpeed(7);
        var xC = x + width/2;
        var yC = y + height/2;
        var dir = Qt.vector2d(player.x - xC, player.y - yC);
        dir = dir.normalized();
        player.xSpeed = dir.x * spd;
        player.ySpeed = dir.y * spd;
        player.playerState = DWPlayerBase.PS_AIR;
        player.playerJumping = false;
        bumperSfx.play();
        animation.restart();
        //if(!player.playerRolling)player.onAnimationChanged("hurt");
    }


    DWSoundEffect
    {
        id: bumperSfx
        source: resBase + "obj/sfx/bumper.wav.ogg"
    }


    NumberAnimation on scale
    {
        id: animation
        running: false
        from: 1.5
        to: 1
        duration: 1500
        easing.type: Easing.OutElastic
    }
}
