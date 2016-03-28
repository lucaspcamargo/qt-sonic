import QtQuick 2.3
import ".."
import dw 1.0

Item {


    anchors.centerIn: parent
    height: 1080
    width: 1920
    scale: parent.height / height

    property bool showScore: false
    property int scoreValue: 0
    property int ringsValue: 0
    property real timeValue: 0

    DWImageItem
    {
        x: 80
        y: 60
        source: resBase + "ui/hud/sheet.png"
        crop: true
        cropRect: Qt.rect(175, 0, 127, 58)

    }

    DWImageItem
    {
        id: ringsLabel
        x: 80
        y: 150
        source: resBase + "ui/hud/sheet.png"
        crop: true
        cropRect: Qt.rect(isRed? 520 : 0, 0, 153, 58)
        property bool isRed: false
    }

    Row
    {
        x: 270
        y: 150
        spacing: 4

        DWLevelHudDigit
        {
            digit: ringsValue/100 % 10
        }

        DWLevelHudDigit
        {
            digit: ringsValue/10 % 10
        }

        DWLevelHudDigit
        {
            digit: ringsValue % 10
        }

    }


    Row
    {
        x: 250
        y: 60
        spacing: 4

        DWLevelHudDigit
        {
            digit: Math.floor( timeValue / 60 ) % 10
        }

        DWImageItem{

            source: resBase + "ui/hud/sheet.png"
            crop: true
            cropRect: Qt.rect(366, 62, 15, 57)
            width: 15
            height: 57

        }

        DWLevelHudDigit
        {
            digit: (Math.floor(timeValue) % 60)/10 % 10
        }

        DWLevelHudDigit
        {
            digit: (Math.floor(timeValue) % 60) % 10
        }

        DWImageItem{

            source: resBase + "ui/hud/sheet.png"
            crop: true
            cropRect: Qt.rect(385, 62, 32, 57)
            width: 32
            height: 57

        }

        DWLevelHudDigit
        {
            digit: Math.floor(timeValue*10) % 10
        }

        DWLevelHudDigit
        {
            digit:  Math.floor(timeValue*100) % 10
        }

    }

    SequentialAnimation
    {
        id: ringsLabelAnim
        loops: Animation.Infinite
        running: ringsValue == 0
        onRunningChanged: ringsLabel.isRed = false

        ScriptAction
        {
            script: ringsLabel.isRed = true
        }

        PauseAnimation {
            duration: 150
        }

        ScriptAction
        {
            script: ringsLabel.isRed = false
        }

        PauseAnimation {
            duration: 150
        }
    }
/*
    DWTextBitmap
    {
        x: 56
        y: 9
        text: ("      " + scoreValue).slice(-7)
        spacing: 2
        visible: showScore
    }

    Row
    {
        x: 56
        y: 9 + (showScore? 18 : 0)
        spacing: 2
    }

    DWTextBitmap
    {
        x: 56
        y: 9 + (showScore? 18 : 0)
        text: Math.floor( timeValue / 60 )+":"+("0" + Math.floor(timeValue) % 60).slice(-2)//+"\""+("0" + Math.floor(timeValue*100) % 100).slice(-2)
        spacing: 2
    }

    DWTextBitmap
    {
        x: 56
        y: 27 + (showScore? 18 : 0)
        text: ("   "+ringsValue).slice(-4);
        spacing: 2
    }




    Image {
        id: shadow
        anchors.top: texts.top
        anchors.bottom: texts.bottom
        source: resBase + "res_core/etc-shadow.png"
        opacity: 0.15
        x: 0
        anchors.topMargin: -15
        width: 600
    }

    Grid {
        id: texts
        x: 40
        y: 35
        columns: 2
        spacing: 40
        rowSpacing:0



        DWDemoHudText{
            id: timeLabel
            text: "TIME"
            actualColor: "#fad128"
        }
        DWDemoHudText{
            id: time
            text: "00:00"
        }
        DWDemoHudText{
            id: ringsLabel
            text: "RINGS"
            actualColor: "#fad128"

            SequentialAnimation
            {
                alwaysRunToEnd: true
                loops: Animation.Infinite
                running: rings.text === "0"
                PropertyAnimation { target: ringsLabel; property:"actualColor"; from: "#fad128"; to: "red"; duration: 250 }
                PropertyAnimation { target: ringsLabel; property:"actualColor"; from: "red"; to: "#fad128"; duration: 250 }

            }

            ColorAnimation { target: ringsLabel; from: "#fad128"; to: "#880000"; duration: 200 }
        }
        DWDemoHudText{
            id: rings
            text: ringsValue
        }
    }
    */
}
