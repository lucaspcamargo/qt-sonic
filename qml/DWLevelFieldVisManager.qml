import QtQuick 2.3
import dw 1.0
import "chunk" 1.0

QtObject
{
    property var visStubs: []
    property var visXC: []
    property var visYC: []
    property var visRadius: []
    property var vis: []
    property var visManaged: []

    property int visStubsCount: 0
    property int visCount: 0

    property real viewCenterX: field.viewCenterAtX
    property real viewCenterY: field.viewCenterAtY
    property real instantiationDistance: Qt.vector2d(field.viewWidth, field.viewHeight).length() * 0.6
    property real destructionDistance: Qt.vector2d(field.viewWidth, field.viewHeight).length() * 0.65

    property bool alternator: false

    property var paletteItemProp: Item
    {
    id: paletteItem
    width: 256
    height: 4

    Image
    {
        id: paletteImage
        visible: false
        smooth: false
        source: resBase + "mm/palette-0.png"
    }
}

property var paletteSourceProp: ShaderEffectSource
{
    id: paletteSrc
    sourceItem: paletteItem
    smooth: false
    wrapMode: ShaderEffectSource.Repeat
}

property var paletteSource: [ paletteImage ]
property real paletteCoordSpeed: 3.33
property real paletteCoordY: (field.fieldTime * paletteCoordSpeed) % 1.0

function getPaletteSource( index )
{
    return paletteSource[index];
}

function addVisStub( x, y, xc, yc, radius, source, layerB, visBg, visObj )
{
    visStubs.push({"x": x, "y":y, "xc":xc, "yc":yc, "source": source,  "layerB": layerB,  "visualBg": visBg});
    visXC.push(xc);
    visYC.push(yc);
    visRadius.push(radius);

    vis.push(visObj? visObj : 0);
    visManaged.push(visObj? false : true);
    if(visObj) visCount ++;

    visStubsCount++;
}

function fieldReset()
{

}

function update(dt)
{
    // nothing here anymore, thx bvh <3
}


function init()
{

    for(var i = 0; i < visStubs.length; i++)
        createVis(i);
}

function createVis(i)
{
    var c = Qt.createComponent("chunk/PLevelChunkVisImpl.qml");
    var cp = Qt.createComponent("chunk/PLevelChunkVisualPaletted.qml");

    if(c)
    {
        var paletted = String(visStubs[i]["source"]).indexOf("/tileset/") >= 0;
        var v = (paletted ? cp : c).createObject(field);
        if(v)
        {
            vis[i] = v;
            v.x = visStubs[i]["x"];
            v.y = visStubs[i]["y"];
            v.source = visStubs[i]["source"] + (paletted? ".paletted" : "");
            v.z = visStubs[i]["visualBg"]? field.visualBgZ : (visStubs[i]["layerB"]? field.layerBZ : field.layerAZ);
            visCount ++;

            var bvhNode = fieldBVH.createNode(visXC[i], visYC[i], visRadius[i], fieldBVH.rootNode);
            bvhNode.activated.connect(v.activate);
            bvhNode.deactivated.connect(v.deactivate);

            return vis;
        }
        else console.log("Can't create vis!");
    }
    else console.log("Can't create vis component!");
}

}
