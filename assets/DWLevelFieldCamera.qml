import QtQuick 2.0

QtObject {

    property real minXBoundary: levelData.minBoundaryX
    property real maxXBoundary: levelData.maxBoundaryX

    property real minYBoundary: levelData.minBoundaryY
    property real maxYBoundary: levelData.maxBoundaryY

    property real minViewCenterX: minXBoundary + Math.ceil(field.viewWidth/2)
    property real maxViewCenterX: maxXBoundary - Math.floor(field.viewWidth/2)

    property real minViewCenterY: minYBoundary + Math.ceil(field.viewHeight/2)
    property real maxViewCenterY: maxYBoundary - Math.floor(field.viewHeight/2)

    property real viewCenterX: 0
    property real viewCenterY: 0

    function update(dt)
    {
        if(levelEditor)
            if(levelEditor.visible)
                return;

        var x = player.x;
        var y = player.y - 20 + player.playerHalfHeight;

        if(Math.abs(viewCenterX - x) > 8)
        {
            if(viewCenterX > x)
                viewCenterX = Math.round(x) + 8;
            else
                viewCenterX = Math.round(x) - 8;
        }

        if(Math.abs(viewCenterY - y) > 16)
        {
            if(viewCenterY > y)
                viewCenterY = Math.round(y) + 16;
            else
                viewCenterY = Math.round(y) - 16;
        }

        // respect bounds

        if(viewCenterX < minViewCenterX) viewCenterX = minViewCenterX;
        if(viewCenterX > maxViewCenterX) viewCenterX = maxViewCenterX;

        if(viewCenterY < minViewCenterY) viewCenterY = minViewCenterY;
        if(viewCenterY > maxViewCenterY) viewCenterY = maxViewCenterY;

        field.viewCenterAtX = viewCenterX;
        field.viewCenterAtY = viewCenterY;

        if(player.y > maxYBoundary && !player.playerDead ) player.die(false);
    }

}

