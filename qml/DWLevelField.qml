import QtQuick 2.3
import QtMultimedia 5.0
import dw 1.0
import "field"
import "obj"

DWField {

    id: field

    property bool fieldActive: false
    property real fieldTime: 0
    property bool fieldEditMode: false

    signal resetted

    signal preUpdate
    signal postUpdate

    property real bgZ: -5
    property real visualBgZ: -4
    property real layerBZ: -3
    property real objBZ: -1
    property real playerZ: -.5
    property real objAZ: 0
    property real objSfxZ: 2
    property real layerAZ: 3
    property real fgZ: 3.5
    property real waterBorderZ: 3.9
    property real hudZ: 4

    property bool water: levelData.hasWater
    property color waterColor: levelData.waterColor
    property real waterYCenter: levelData.waterYCenter
    property real waterYAmplitude: levelData.waterYAmplitude
    property int waterY: waterYCenter


    /* TODO MAKE INTO EFF
    NumberAnimation on waterY
    {

        running: true
        from: waterYCenter - waterYAmplitude/2
        to: waterYCenter + waterYAmplitude/2
        duration: 5000
        easing.type: Easing.SineCurve
        loops: Animation.Infinite
    }*/

    //onWaterColorChanged: screenRenderer.waterColor = waterColor

    // this is uneeded and buggy but totally cool
    //Behavior on viewScale { enabled: field.fieldActive; NumberAnimation{ duration: 1000 } }

    DWFieldBVH
    {
        id: fieldBVH

        maxChildNodes: 8
        viewRadius: field.viewRadius
        activateAll: fieldEditMode


        onActivateAllChanged:
        {
            update(0);
        }
    }

    DWFieldPhysicsWorld
    {
        id: physicsWorld
        physicsScale: 1/convertGenesisDimension(32)
    }

    property var objectManager: DWLevelFieldObjManager
    {
        id: objManager
    }

    property var camera: DWLevelFieldCamera
    {
        id: fieldCamera
    }

    property var player: null


    Component
    {
        id: nodeVisualizer

        Rectangle
        {
            property bool active: true
            function activate(){ active = true; }
            function deactivate(){ active = false; }

            visible: _DW_DEBUG && _DW_DEBUG_BVH_DRAW

            width: 16
            height: width
            radius: width/2
            color: "transparent"
            border.width: 3
            border.color: active ? "lime" : "blue"
        }
    }

    function createNodeVis(node, depth)
    {
        console.log(("createNodeVis(): %1 %2 %3").arg(node.centerX).arg(node.centerY).arg(node.radius) )

        var vis = nodeVisualizer.createObject(field);
        vis.x = node.centerX - node.radius;
        vis.y = node.centerY - node.radius;
        vis.width = node.radius * 2;
        vis.z = fgZ;
        vis.opacity = 0.1*(1+depth);
        node.activated.connect(vis.activate);
        node.deactivated.connect(vis.deactivate);

        for(var i = 0; i < node.childrenCount(); i++)
        {
            createNodeVis(node.child(i), depth+1);
        }
    }

    function rebuildBVH()
    {
        fieldBVH.rebuildBVH();
        fieldBVH.viewRadius = Qt.vector2d(viewWidth/2, viewHeight/2).length()

    }

    function init()
    {


        for(var i = 0; i < levelData.chunks.length; i++)
        {
            var chunkData = levelData.chunks[i];
            console.log("[DWLevelField] init reading chunk: " + resBase + levelData.urlPrefix + chunkData.chunkSource);
            var chunkComponent = Qt.createComponent(resBase + levelData.urlPrefix + chunkData.chunkSource);
            var chunk = chunkComponent.createObject(this);
            if(!chunk) continue;
            chunk.x = chunkData.chunkX;
            chunk.y = chunkData.chunkY;
            chunk.process();
        }
        objManager.init();

        var pComponent = Qt.createComponent(Qt.resolvedUrl("obj/ObjPlayer.qml"));
        player = pComponent.createObject(this, {x: levelData.playerX, y: levelData.playerY });

        // set camera pos
        viewCenterAtX = levelData.playerX;
        viewCenterAtY = levelData.playerY;

        rebuildBVH();

        if(_DW_DEBUG_BVH_DRAW)createNodeVis(fieldBVH.rootNode, 0);

        /*
        if(water)
        {
            screenRenderer.waterEnabled = true;
            screenRenderer.waterColor = waterColor;
        }*/

        for(var i = 0; i < levelData.effects.length; i++)
        {
            var effectData = levelData.effects[i];
            var inPrefix = effectData.inPrefix;
            var effectComponent = Qt.createComponent(Qt.resolvedUrl((inPrefix? levelData.urlPrefix : "field/") + effectData.effect + ".qml"));
            var effect = effectComponent.createObject(this, effectData.effectParams);
        }


    }

    function reset()
    {
        objManager.fieldReset();
        resetted();
    }


    Component.onDestruction:
    {
        //screenRenderer.waterEnabled = false;
        //screenRenderer.waterLevel = 1;
        gc();
    }


    DWEveryFrame
    {
        onUpdate:
        {
            controls.update();

            preUpdate(dt);

            if(false)
            {
                var fac = (0.5 + 0.25*(1+Math.sin(fieldTime)));
                dt *= fac;
                dwAnimationUpdater.setDomainTimeFactor(DWAnimationUpdater.FieldDomain, fac);
            }

            if(fieldActive)
            {
                fieldTime += dt;
                physicsWorld.update(dt);
                player.update(dt);
                objManager.updateObjects(dt);
            }
            else
            {

                if(player && player.playerDead)
                    player.update(dt);
            }

            // update camera and bvh always, if player not dead
            if(player && !player.playerDead)
            {
                fieldCamera.update(dt);
                fieldBVH.viewCenterX = viewCenterAtX;
                fieldBVH.viewCenterY = viewCenterAtY;
                fieldBVH.update(dt);
            }

            /*
            screenRenderer.time = fieldTime / 1.5 * Math.PI * 2;

            if(water)
            {
                screenRenderer.waterLevel = Math.min(1.0, Math.max(0, (waterY - (viewCenterAtY - viewHeight/2))/viewHeight));
            }*/

            if(physicsWorldDrawer && physicsWorldDrawer.visible)
                physicsWorldDrawer.updateNow();

            postUpdate(dt);
        }

    }

    property var destroyList: []

    function destroyLater(d)
    {
        destroyList.push(d);
    }

    onPostUpdate: {
        for(var i = 0; i < destroyList.length; i++)
        {
            destroyList[i].destroy();
        }

        destroyList = [];
    }

    function createExplosion(x, y)
    {
        var c = Qt.createComponent("obj/ObjExplode.qml");
        var o = c.createObject(field);
        o.x = x;
        o.y = y;
        return o;
    }

    function createFlicky(x, y, type)
    {
        var c = Qt.createComponent("obj/ObjFlicky.qml");
        var o = c.createObject(field);
        if(type != undefined) o.type = type;
        o.x = x-12;
        o.y = y-12;
        return o;
    }

    function createGib(props)
    {
        var c = Qt.createComponent("obj/ObjGib.qml");
        var o = c.createObject(field, props);
        return o;
    }

    function createWaterSplash(x)
    {
        var c = Qt.createComponent("obj/ObjTimedSprite.qml");
        var o = c.createObject(field);
        o.source = resBase + "obj/fx/splash.png";
        o.width = 32;
        o.height = 32;

        o.frameWidth = 32;
        o.frameHeight = 32;
        o.frameCount = 9;
        o.frameDuration = 75;

        o.x = x-16;
        o.y = waterY - 32 //- (waterBorder.visible? 4 : 0);
        o.z = waterBorderZ;
        o.opacity = 0.7;
        return o;
    }

    DWFxWater
    {
      Component.onCompleted: if(!field.water) destroy();
        id: waterRectDraw

        x: field.viewCenterAtX - 250
        y: waterY-2
        z: waterBorderZ

        width: 500
        height: 4000

        color: field.waterColor

        time: field.fieldTime % (2*Math.PI)

    }


    Rectangle
    {
        Component.onCompleted: if(!field.water) destroy();
        id: waterFlasher

        x: field.viewCenterAtX - 250
        y: waterY
        z: waterBorderZ

        width: 500
        height: 4000
        opacity: 0.0

        color: "white"

        NumberAnimation on opacity
        {
            id: waterFlasherAnimation
            running: false

            duration: 100
            from: 1.0
            to: 0.0
        }

    }

    ShaderEffect
    {
        Component.onCompleted: if(!field.water) destroy();

        id: waterBorder
        visible: true

        x: field.viewCenterAtX - 250
        y: waterY-2
        z: waterBorderZ

        width: 500
        height: 16
        opacity: 0.6

        mesh: GridMesh
        {
            resolution: Qt.size(100, 4)
        }

        property real time: field.fieldTime % (2*Math.PI)
        property real xpos: x
        property color borderColor: Qt.lighter(field.waterColor)

        vertexShader: "
            uniform highp mat4 qt_Matrix;
            attribute highp vec4 qt_Vertex;
            attribute highp vec2 qt_MultiTexCoord0;
            varying highp vec2 coord;
            varying lowp vec2 normal;
            uniform mediump float time;
            uniform highp float xpos;
            void main() {
                coord = qt_MultiTexCoord0;
                float worldPos = xpos + 500.0 * coord.x;
                float sinarg = 0.1*(worldPos) + time*5.0;
                float timeAlpha = (1.0 + sin(time * 4.0))*0.5;
                float angle = atan(cos(sinarg));
                normal = mix(vec2(-sin(angle), cos(angle)), vec2(sin(angle), cos(angle)), timeAlpha);
                gl_Position = qt_Matrix * (qt_Vertex + vec4(0.0, 2.5 * mix(sin(sinarg), -sin(sinarg), timeAlpha), 0.0, 0.0) );
            }"

        fragmentShader: "
            varying highp vec2 coord;
            varying lowp vec2 normal;
            //uniform sampler2D src;
            uniform lowp float qt_Opacity;
            uniform lowp vec4 borderColor;
            void main() {
                vec2 nn = normalize(normal);
                lowp vec4 tex = borderColor * pow((1.0-coord.y), 4.0);//texture2D(src, coord);
                const vec2 lightdir = vec2(0.7, 0.7);
                tex += vec4(1.0, 1.0, 1.0, 1.0) * pow(dot(nn, lightdir)* pow(tex.a, 2.0f), 5.0) * 5.0;
                gl_FragColor = vec4(tex.rgb, tex.a) * qt_Opacity;
            }"

    }

    DWFieldPhysicsDrawer
    {
        id: physicsWorldDrawer
        z: fgZ
    }

    //from the SPG to the engine
    property real genesisPixelToLocalPixels: 1
    property real genesisFrameToSecondInv: 60.0;
    property real genesisFrameToSecond: 1.0/genesisFrameToSecondInv;

    function convertGenesisDimension(pixels)
    {
        return pixels * genesisPixelToLocalPixels;
    }

    function convertGenesisSpeed(pixelsPerFrame)
    {
        return pixelsPerFrame * genesisPixelToLocalPixels * genesisFrameToSecondInv;
    }

    function convertGenesisAcceleration(pixelsPerFrameSquared)
    {
        return pixelsPerFrameSquared * genesisPixelToLocalPixels * genesisFrameToSecondInv * genesisFrameToSecondInv;

    }

    function convertGenesisTime(frames)
    {
        return frames * genesisFrameToSecond;
    }


    function overlap(ax1, ax2, ay1, ay2, bx1, bx2, by1, by2)
    {
        return !(ax1 > bx2 || bx1 > ax2 || ay1 > by2 || by1 > ay2);
    }

    function overlapViewI(item1)
    {
        return overlap(item1.x, item1.x + item1.width, item1.y, item1.y + item1.height,
                       -x, -x + viewWidth, -y, -y + viewHeight);
    }

    function overlapView2I(item1)
    {
        return overlap(item1.x, item1.x + item1.width, item1.y, item1.y + item1.height,
                       -x - viewWidth, -x + 2*viewWidth, -y-viewHeight, -y + 2*viewHeight);
    }

    function overlapI(item1, item2)
    {
        return overlap(item1.x, item1.x + item1.width, item1.y, item1.y + item1.height,
                       item2.x, item2.x + item2.width, item2.y, item2.y + item2.height);
    }

    Column
    {
        id: debugInfo

        x: viewCenterAtX - viewWidth/2 + 26/viewScale
        y: viewCenterAtY - viewHeight/2 + 64/viewScale
        z: hudZ
        transformOrigin: Item.TopLeft
        scale: 1/viewScale

        visible: _DW_DEBUG && _DW_DEBUG_FIELD_INFO
        Component.onCompleted: if(!_DW_DEBUG) destroy();
        spacing: 3

        Text
        {
            text: !visible? "" : objManager.objCount + " objs ("+objManager.objStubsCount+")"
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";

        }

        Text
        {
            text: !visible? "" : player.playerState + " " + player.playerQuadMode + " " + (player.currentAnimation) + (player.canUseMidair? " M" : "")
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";

        }

        Text
        {
            text: !visible? "" : "x  " + player.x.toFixed(2)
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";
        }

        Text
        {
            text: !visible? "" : "y  " + player.y.toFixed(2)
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";
        }

        Text
        {
            text: !visible? "" : "xS " + player.xSpeed.toFixed(2)
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";
        }

        Text
        {
            text: !visible? "" : "yS " + player.ySpeed.toFixed(2)
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";
        }

        Text
        {
            text: !visible? "" : "gS " + player.gSpeed.toFixed(2)
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";
        }

        Text
        {
            text: !visible? "" : "gA " + player.gAngle.toFixed(2)
            color: "yellow"; font.bold: true; font.pixelSize: 8; style: Text.Outline; styleColor: "#880";
        }
    }
}
