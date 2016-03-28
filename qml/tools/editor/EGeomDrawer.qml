import QtQuick 2.0

Item {

    // a line is a js object with "start" and "end" point members, in absolute coords
    // other optional arguments mean arcs or boxes

    id: geomDrawer

    property var lines: []
    property var lineObjs: []

    property color color: "cyan"

    Component.onCompleted:
    {

    }

    function hasLine()
    {
        return lines.length > 0;
    }

    function addLine(line)
    {
        lines.push(line);

        lineObjs.push(lineComponent.createObject(geomDrawer, line));
    }

    function createLineRect(i)
    {
        var line = lines[i];

    }

    function compile()
    {
        if(lines.length)
        {
            var ret = [];
            ret.push([lines[0].start.x, lines[0].start.y]);

            for(var i = 0; i < lines.length; i++)
            {
                ret.push([lines[i].end.x, lines[i].end.y]);
            }

            return ret;
        }
        else return null;
    }

    function makeGeomData(pointList)
    {
        // let's learn something about the result
        var minX = pointList[0][0];
        var maxX = minX;
        var minY = pointList[0][1];
        var maxY = minY;

        for(var i = 0; i < pointList.length; i++)
        {
            minX = Math.min(minX, pointList[i][0]);
            maxX = Math.max(maxX, pointList[i][0]);
            minY = Math.min(minY, pointList[i][1]);
            maxY = Math.max(maxY, pointList[i][1]);
        }

        var xC = (maxX + minX) / 2;
        var yC = (maxY + minY) / 2;
        var radius = Math.sqrt(Math.pow(maxX-minX, 2) + Math.pow(maxY-minY, 2));
        var xPoints = [];
        var yPoints = [];

        for(var i = 0; i < pointList.length; i++)
        {
            xPoints.push(pointList[i][0] - xC);
            yPoints.push(pointList[i][1] - yC);
        }

        return {
            "minX": minX,
            "maxX": maxX,
            "minY": minY,
            "maxY": maxY,
            "xC": xC,
            "yC": yC,
            "radius": radius,
            "xPoints": xPoints,
            "yPoints": yPoints
        };
    }

    function setupFromGeomData(gd)
    {
        for(var i = 0; i < gd.xPoints.length - 1; i++)
        {
            addLine({start: Qt.point(gd.xPoints[i] - gd.minX + gd.xC, gd.yPoints[i] - gd.minY + gd.yC), end: Qt.point(gd.xPoints[i+1] - gd.minX + gd.xC, gd.yPoints[i+1] - gd.minY + gd.yC)});
        }
    }

    function clear()
    {
        for(var i = 0; i < lineObjs.length; i++)
        {
            lineObjs[i].destroy();
        }
        lineObjs = [];
        lines = [];
    }

    Component{
        id: lineComponent

        Item{

            id: origin

            property point start: Qt.point(0,0)
            property point end: Qt.point(0,0)
            property real minX: Math.min(start.x, end.x)
            property real maxX: Math.max(start.x, end.x)
            property real minY: Math.min(start.y, end.y)
            property real maxY: Math.max(start.y, end.y)
            property real lght: Math.sqrt(Math.pow(maxX-minX, 2) + Math.pow(maxY-minY, 2))

            x: (maxX + minX) /2
            y: (maxY + minY) /2
            rotation: 180*(Math.atan2(start.y - end.y, start.x - end.x)/Math.PI)

            Rectangle
            {
                width: origin.lght
                height: 1
                x: -width/2
                y: -0.5
                color: geomDrawer.color
            }
        }

    }

}
