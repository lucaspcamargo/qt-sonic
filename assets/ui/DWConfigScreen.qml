import QtQuick 2.0

DWUIScreenTemplate {

    screenLabel: "Configuration"
    //darkBg: true

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

