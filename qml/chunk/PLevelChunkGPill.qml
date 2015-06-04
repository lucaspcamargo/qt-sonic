import QtQuick 2.4

Item {

    id: pill
    property string chunkChildType: "template"
    property bool onlyBottomSensors: false
    property bool layerA: true
    property bool layerB: true

    // editor visuals and default props
    width: 128
    height: 16

    PLevelChunkGArc
    {
        height: pill.height/2
        width: height
        quadrant: 1
    }


    PLevelChunkGArc
    {
        y: height
        height: pill.height/2
        width: height
        quadrant: 2
    }

    PLevelChunkGRect
    {
        height: pill.height
        x: pill.height/2
        width: pill.width - pill.height
        Component.onCompleted: {if(width == 0) destroy();}
    }


    PLevelChunkGArc
    {
        x: pill.width - pill.height/2
        height: pill.height/2
        width: height
        quadrant: 0
    }


    PLevelChunkGArc
    {
        x: pill.width - pill.height/2
        y: height
        height: pill.height/2
        width: height
        quadrant: 3
    }

}
