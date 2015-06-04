import QtQuick 2.4

DWUIScreenTemplate {

    screenLabel: "Configuration"

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
            KeyNavigation.down: settingShader

            currentSetting: renderSampleSharp? 1 : 0
            onCurrentSettingChanged: renderSampleSharp = (currentSetting? true : false)
        }

        DWUICSetting
        {
            id: settingShader
            label: "Shader"
            settings: ["None"].concat(renderShaders)
            width: parent.width
            KeyNavigation.down: settingScanlines

            currentSetting: renderShaderIndex + 1
            onCurrentSettingChanged: renderShaderIndex = currentSetting - 1
        }

        DWUICSetting
        {
            id: settingScanlines
            label: "Mute"
            settings: ["Yes", "No"]
            width: parent.width

            currentSetting: Math.ceil(DWRoot.soundSystem.masterGain)
            onCurrentSettingChanged: DWRoot.soundSystem.masterGain = (currentSetting? 1 : 0)
        }

    }


}

