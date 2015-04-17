import QtQuick 2.0

Item
{
    id: shield
    visible: false


    x: - ( player.x - Math.round(player.x))
    y: - ( player.y - Math.round(player.y))
    z: 1


    Repeater
    {
        model: 8

        Image
        {
            source: "fx/shield-2.png"
            x: Math.round(Math.cos(angle + index*0.25 * Math.PI) * radius - width/2)
            y: Math.round(-Math.sin(angle + index*0.25 * Math.PI) * radius - height/2)
        }
    }

    property real radius: 32
    NumberAnimation on radius
    {
        from: 30
        to: 38
        duration: 2500
        easing.type: Easing.SineCurve
        loops: Animation.Infinite
    }

    property real angle: 0
    NumberAnimation on angle
    {
        from: 0
        to: 2 * Math.PI
        duration: 750
        loops: Animation.Infinite
    }

    function action()
    {
        player.xSpeed = convertGenesisSpeed(turnedBack? -8 : 8);
        player.ySpeed = 0;
        player.hasShield = false;
    }
}
