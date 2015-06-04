import QtQuick 2.4

Image {
    property string chunkChildType: "visual"

    property bool layerB: false
    property bool visualBg: false
    property bool doNotFlatten: false
    cache: false

    function activate()
    {
        visible = true;
        visManager.visCount ++;
    }

    function deactivate()
    {
        visible = false;
        visManager.visCount --;
    }

}
