import QtQuick 2.0
import dw 1.0

DWImageItem{

    property int digit: 0

    source: resBase + "ui/hud/sheet.png"
    crop: true
    cropRect: Qt.rect(digit * 35, 62, 35, 57)
    width: 35
    height: 57

}
