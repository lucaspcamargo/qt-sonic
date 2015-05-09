import QtQuick 2.3


Item {


    property bool showScore: false
    property int score: 0
    property int ringsValue: 0
    property real timeValue: 0

    DWTextBitmap
    {
        x: 13
        y: 9
        text: "SCORE"
        spacing: 2
        visible: showScore
    }

    DWTextBitmap
    {
        x: 13
        y: 9 + (showScore? 18 : 0)
        text: "TIME"
        spacing: 2
    }

    DWTextBitmap
    {
        id: ringsLabel
        x: 13
        y: 27 + (showScore? 18 : 0)
        text: "RINGS"
        spacing: 2
    }

    SequentialAnimation
    {
        id: ringsLabelAnim
        loops: Animation.Infinite
        running: ringsValue == 0
        onRunningChanged: ringsLabel.font = "chaotix-hud"

        ScriptAction
        {
            script: ringsLabel.font = "chaotix-hud-rings-red"
        }

        PauseAnimation {
            duration: 150
        }

        ScriptAction
        {
            script: ringsLabel.font = "chaotix-hud"
        }

        PauseAnimation {
            duration: 150
        }
    }

    DWTextBitmap
    {
        x: 56
        y: 9
        text: ("      " + score).slice(-7)
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
        text: Math.floor( timeValue / 60 )+/*"'"*/":"+("0" + Math.floor(timeValue) % 60).slice(-2)//+"\""+("0" + Math.floor(timeValue*100) % 100).slice(-2)
        spacing: 2
    }

    DWTextBitmap
    {
        x: 56
        y: 27 + (showScore? 18 : 0)
        text: ("   "+ringsValue).slice(-4);
        spacing: 2
    }



/*
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
