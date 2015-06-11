import QtQuick 2.4

AnimatedSprite
{
    id: shield
    source: resBase + "obj/player/fx/shield-0.png"
    interpolate: false
    running: visible
    width: 48
    height: 48
    frameWidth: width
    frameHeight: height
    frameCount: 10
    frameDuration: 0
    visible: false

    opacity: visible? 1 : 0
    Behavior on opacity { NumberAnimation { duration: 100 } }

    scale: visible? 1 : 3
    Behavior on scale { NumberAnimation { duration: 100 } }

    x: - ( player.x - Math.round(player.x))
    y: - ( player.y - Math.round(player.y)) - height/2
    z: 1


    function update()
    {
        x = - ( player.x - Math.round(player.x)) - width/2;
        y = - ( player.y - Math.round(player.y)) - height/2;
    }
}
