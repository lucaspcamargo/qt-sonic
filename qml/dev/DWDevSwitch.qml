import QtQuick 2.0

DWDevButton {

    property string description: prop
    property string prop: ""

    text: ""

    function update()
    {
        if(prop == "") return;

        var on = eval(prop)? true : false;
        text = description.replace(/_/g, "-") + (on? " is ON" : " is OFF");
        colorIndex = on? 7 : 5;
    }

    Component.onCompleted: update()

    onClicked: {
        eval(prop + "= !" + prop + ";");
        update();
    }

}

