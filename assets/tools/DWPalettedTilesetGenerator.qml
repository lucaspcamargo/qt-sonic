import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.folderlistmodel 2.1

import dw 1.0

ApplicationWindow {

    id: window

    width: 1200
    height: 600

    title: "Palleted Tileset Generator"

    visible: true

    property url sourceDir: dirSelector.fileUrl

    FileDialog
    {
        id: dirSelector
        selectFolder: true
        selectMultiple: false
        folder: Qt.resolvedUrl("../mm/tileset")
    }

    Component.onCompleted: console.log(Qt.resolvedUrl("../mm/tileset"))

    FolderListModel
    {
        id: folderListModel
        folder: sourceDir
        showDirs: false
        nameFilters: ["*.png"]
    }

    SplitView
    {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Column
        {
            id: buttonColumn
            width: 256
            height: parent.height

            Button
            {
                text: ("Select dir...")
                width: parent.width
                onClicked: dirSelector.visible = true
            }

            Button
            {
                text: ("Load Images")
                width: parent.width
                enabled: folderListModel.count
                onClicked: loadImages()
            }


            Button
            {
                id: findColorsButton
                text: ("Find Colors")
                width: parent.width
                enabled: folderListModel.count
                onClicked: findColors()
            }

            Button
            {
                id: buildImagesButton
                text: ("Build Images")
                width: parent.width
                enabled: false
                onClicked: createImages()
            }

            ProgressBar
            {
                id: progressBar
                value: 0
                width: parent.width
            }



            Canvas
            {
                id: colorsCanvas
                width: 256
                height: 256
                scale: parent.width / width
                transformOrigin: Item.TopLeft
                renderStrategy: Canvas.Immediate
                renderTarget: Canvas.Image
                //visible: false

                property url image: ""
                property var findColorsList: []
                property bool done: false
                property bool createImagesMode: false
                property var colors: []

                onPaint:
                {
                    getContext("2d");
                    context.clearRect(0,0,width,height);

                    if(findColorsList.length)
                    {
                        var imageUrl = findColorsList[0];
                        console.log("processing "+ imageUrl);
                        context.drawImage(imageUrl, 0, 0);
                        findColorsList.splice(0, 1);

                        //now we process the canvas contents
                        var imageData = context.getImageData(0, 0, width, height);
                        var numPixels = width * height;

                        if(!createImagesMode)
                        {
                            // find colors

                            for(var p = 0; p < numPixels; p++)
                            {
                                var r = imageData.data[4*p];
                                var g = imageData.data[4*p + 1];
                                var b = imageData.data[4*p + 2];
                                var a = imageData.data[4*p + 3];

                                if(a == 0) continue;
                                else
                                {
                                    var color = Qt.rgba(r/255.0, g/255.0, b/255.0, a/255.0);
                                    var foundEqual = false;
                                    for(var ci = 0; ci < colors.length && !foundEqual; ci++)
                                    {
                                        if(Qt.colorEqual(color, colors[ci]))
                                        {
                                            foundEqual = true;
                                        }
                                    }

                                    if(!foundEqual)
                                    {
                                        console.log("found color "+ color);
                                        colors.push(color);
                                    }
                                }
                            }
                        }
                        else
                        {
                            // create images

                            for(var p = 0; p < numPixels; p++)
                            {
                                var r = imageData.data[4*p];
                                var g = imageData.data[4*p + 1];
                                var b = imageData.data[4*p + 2];
                                var a = imageData.data[4*p + 3];


                                var color = Qt.rgba(r/255.0, g/255.0, b/255.0, a/255.0);
                                var destColor = "black";

                                for(var ci = 0; ci < colors.length; ci++)
                                {
                                    if(Qt.colorEqual(color, colors[ci]))
                                    {
                                        destColor = Qt.rgba(1/128 + ci/64.0, (r+g+b)/765.0, a, 1.0);
                                        break;
                                    }
                                }
                                context.fillStyle = destColor;
                                context.fillRect(p%width, Math.floor(p/width), 1, 1);
                            }


                            // now we save the new image
                            var newImageData = context.getImageData(0, 0, width, height);
                            for(var p = 0; p < numPixels; p++)
                            {
                                DWUtil.putImageDataPixel(newImageData.data[4*p], newImageData.data[4*p+1], newImageData.data[4*p+2],newImageData.data[4*p+3]);
                            }

                            DWUtil.saveImageData( imageUrl + ".paletted", newImageData.width, newImageData.height );
                        }

                        progressBar.value = (folderListModel.count - findColorsList.length) / folderListModel.count;
                    }
                    else if(colors.length)
                    {
                        //draw colors

                        context.fillStyle = "lightgray";
                        context.fillRect(0,0,width, height);
                        context.fillStyle = context.createPattern("black", Qt.DiagCrossPattern);
                        context.fillRect(0,0,width, height);

                        for(var i = 0; i < colors.length; i ++)
                        {
                            context.fillStyle = colors[i];
                            context.fillRect((i%64)*4, Math.floor(i/64)*4, 4, 4);
                        }
                    }
                    else
                    {
                        context.fillStyle = "lightgray";
                        context.fillRect(0,0,width, height);
                        context.fillStyle = context.createPattern("black", Qt.DiagCrossPattern);
                        context.fillRect(0,0,width, height);

                    }
                }

                Timer
                {
                    interval: 1
                    repeat: true
                    running: true
                    onTriggered:{

                        if(colorsCanvas.findColorsList.length)
                        {
                            console.log("loading "+ colorsCanvas.findColorsList[0]);
                            colorsCanvas.loadImage(colorsCanvas.findColorsList[0]);
                            colorsCanvas.requestPaint();
                        }else if(colorsCanvas.colors.length && !colorsCanvas.done)
                        {
                            colorsCanvas.done = true;
                            colorsCanvas.height = 4 + Math.floor(colorsCanvas.colors.length / 64) * 4

                            //sort colors
                            if(!colorsCanvas.createImagesMode)
                            {
                                colorsCanvas.colors.sort(function(c1, c2){ return (c1.r + c1.g + c1.b) - (c2.r + c2.g + c2.b); })
                                colorsCanvas.requestPaint();
                            }

                            findColorsButton.enabled = true;
                            buildImagesButton.enabled = true;
                        }
                    }
                }

                onImageLoaded: progressBar.value += 1 / folderListModel.count;
            }

        }

        GridView
        {
            id: imageGrid
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            flow: GridView.FlowTopToBottom

            model: folderListModel
            clip: true

            delegate: Component
            {
            Image
            {
                width: 64
                height: 64
                source: fileURL
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }
        }


    }

}

function loadImages()
{
    progressBar.value = 0;
    for(var i = 0; i < folderListModel.count; i++)
    {
        console.log(folderListModel.get(i, "fileURL"));
        colorsCanvas.loadImage(folderListModel.get(i, "fileURL"));
    }
}

function findColors()
{
    findColorsButton.enabled = false;
    buildImagesButton.enabled = false;

    colorsCanvas.done = false;
    colorsCanvas.createImagesMode = false;
    colorsCanvas.height = colorsCanvas.width;

    for(var i = 0; i < folderListModel.count; i++)
    {
        console.log(folderListModel.get(i, "fileURL"));
        colorsCanvas.findColorsList.push(folderListModel.get(i, "fileURL"));
    }
    colorsCanvas.loadImage(colorsCanvas.findColorsList[0]);
    colorsCanvas.requestPaint();
}

function createImages()
{
    findColorsButton.enabled = false;
    buildImagesButton.enabled = false;

    colorsCanvas.done = false;
    colorsCanvas.createImagesMode = true;
    colorsCanvas.height = colorsCanvas.width;

    for(var i = 0; i < folderListModel.count; i++)
    {
        console.log(folderListModel.get(i, "fileURL"));
        colorsCanvas.findColorsList.push(folderListModel.get(i, "fileURL"));
    }
    colorsCanvas.loadImage(colorsCanvas.findColorsList[0]);
    colorsCanvas.requestPaint();
}

}

