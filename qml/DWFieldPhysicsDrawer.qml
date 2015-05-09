import QtQuick 2.0

Canvas {
    visible: _DW_DEBUG && _DW_DEBUG_PHYSICS_DRAW

    width: field.viewWidth
    height: field.viewHeight
    smooth: false

    x: field.viewCenterAtX - width / 2
    y: field.viewCenterAtY - height / 2

    contextType: "2d"
    renderTarget: Canvas.Image
    renderStrategy: Canvas.Immediate

    Component.onCompleted:
    {
        if(!_DW_DEBUG)
        {
            destroy();
            return;
        }

        // manually updated
        // physicsWorld.afterUpdating.connect(updateNow);
        physicsWorld.debugDrawPolygon.connect(onDrawPolygon);
        physicsWorld.debugDrawSolidPolygon.connect(onDrawSolidPolygon);
        physicsWorld.debugDrawSegment.connect(onDrawSegment);
        physicsWorld.debugDrawSolidCircle.connect(onDrawSolidCircle);
    }

    onPaint:
    {
        getContext("2d");

        context.resetTransform();
        context.clearRect( 0, 0, width, height);
        context.fillStyle = Qt.rgba(0,0,0,0.65);
        context.fillRect( 0, 0, width, height);
        context.translate(-x, -y);
        context.lineWidth = 1;

        physicsWorld.debugDraw();
    }

    function updateNow()
    {
        if(visible)requestPaint();
    }

    function onDrawPolygon(pointsX, pointsY, color)
    {
        context.strokeStyle = color;

        context.beginPath();
        for(var i = 0; i < pointsX.length; i ++)
        {
            if(i == 0)
                context.moveTo(pointsX[i], pointsY[i]);
            else
                context.lineTo(pointsX[i], pointsY[i]);
        }

        context.lineTo(pointsX[0], pointsY[0]);

        context.stroke();
    }
    function onDrawSolidPolygon(pointsX, pointsY, color)
    {
        context.strokeStyle = color;
        context.fillStyle = color;

        context.beginPath();
        for(var i = 0; i < pointsX.length; i ++)
        {
            if(i == 0)
                context.moveTo(pointsX[i], pointsY[i]);
            else
                context.lineTo(pointsX[i], pointsY[i]);
        }

        context.lineTo(pointsX[0], pointsY[0]);

        context.globalAlpha = 0.509;
        context.fill();
        context.globalAlpha = 1.0;
        context.stroke();
    }
    function onDrawSegment(x1,y1,x2,y2,color)
    {
        context.strokeStyle = color;

        context.beginPath();
        context.moveTo(x1, y1);
        context.lineTo(x2, y2);
        context.stroke();
    }
    function onDrawSolidCircle(x1,y1,radius,x2,y2,color)
    {
        context.strokeStyle = color;
        context.fillStyle = color;

        context.beginPath();
        context.arc(x1, y1, radius, 0, Math.PI * 2);

        context.globalAlpha = 0.509;
        context.fill();
        context.globalAlpha = 1.0;
        context.stroke();

        context.beginPath();
        context.moveTo(x1, y1);
        context.lineTo(x1+x2*radius, y1+y2*radius);
        context.stroke();
    }
}
