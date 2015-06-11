import QtQuick 2.4
import dw 1.0

DWImageItem {
    property string chunkChildType: "visual"

    property bool layerB: false
    property bool visualBg: false
    property bool doNotFlatten: false

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
