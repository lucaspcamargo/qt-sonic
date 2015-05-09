import QtQuick 2.0

DWUIScreenTemplate {

    screenLabel: "Configuration"

    Rectangle
    {
        id: shadowCont
        NumberAnimation on width
        {
            from: 64
            to: 128
            duration: 20000
            loops: Animation.Infinite
            easing.type: Easing.SineCurve
        }
        height: 64

        anchors.verticalCenter: parent.verticalCenter
        color: "#222"
        opacity: 0.7
    }

    Image {

        id: ribbon
        width: 64
        height: 64
        opacity: shadowCont.opacity
        source: "main/ribbon-terminator.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: shadowCont.right

    }

    Image {

        id: ribbon2
        width: 64
        height: 64
        opacity: shadowCont.opacity
        source: "main/ribbon-terminator.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ribbon.right
        anchors.leftMargin: 100
        mirror: true
    }


    Rectangle
    {
        id: shadowCont2
        height: 64

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ribbon2.right
        anchors.right: parent.right
        color: "#222"
        opacity: 0.7
    }

    Column
    {
        anchors.fill: parent
        anchors.margins: 64

        DWUICSetting
        {
            id: settingSampling
            label: "Sampling"
            settings: ["Smooth", "Sharp"]
            width: parent.width
            focus: !_DW_MOBILE
            KeyNavigation.down: settingFiltering

            currentSetting: renderSampleSharp? 1 : 0
            onCurrentSettingChanged: renderSampleSharp = (currentSetting? true : false)
        }

        DWUICSetting
        {
            id: settingFiltering
            label: "Filtering"
            settings: ["None", "Super 2xSai"]
            width: parent.width
            KeyNavigation.down: settingScanlines

            currentSetting: renderSuper2xSai? 1 : 0
            onCurrentSettingChanged: renderSuper2xSai = (currentSetting? true : false)
        }

        DWUICSetting
        {
            id: settingScanlines
            label: "Scanlines (when filtered)"
            settings: ["No", "Yes"]
            width: parent.width

            currentSetting: renderScanlines? 1 : 0
            onCurrentSettingChanged: renderScanlines = (currentSetting? true : false)
        }

    }


}

