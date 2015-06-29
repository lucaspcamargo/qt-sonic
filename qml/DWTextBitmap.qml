import QtQuick 2.4

Row {
    id: row
    property string text: ""
    property string font: "chaotix-hud"
    property bool asyncronous: false
    property bool active: visible
    property int offset: 0

    Repeater {        
        model: active? text.length : null

        Image {
            source: resBase + "fonts/"+font+"/" + (text.charCodeAt(index)+offset) + ".png"
            smooth: false
            antialiasing: false
            asynchronous: row.asyncronous
        }
    }
}
