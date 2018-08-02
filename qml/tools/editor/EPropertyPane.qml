import QtQuick 2.0
import ".."
import "../.."

Rectangle
{
    id: propPane
    property var selectedHandles: handlesLayer.selectedHandles
    property int selectedCount: selectedHandles.length

    property var propFields: []

    color: "#dd000000"

    border.color: "#88aa00"
    border.width: 1
    clip: true


    width: 200
    height: Math.max(100, 300)

    x: parent.width - 200 + 1
    y: Math.floor(parent.height / 2 - height / 2)


    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor
    }

    Column
    {
       id: propertiesColumn
       visible: selectedCount == 1
       anchors.fill: parent
       anchors.margins: 10

       spacing: 8

       DWTextBitmap { id: selObjName; text: "TESTE 1"; offset: 95 }

    }

    DWTextBitmap
    {
        visible: selectedCount == 0
        text: "SELECT SOMETHING PLS"
        anchors.centerIn: parent
    }

    DWTextBitmap
    {
        visible: selectedCount > 1
        text: selectedCount  + " SELECTED"
        anchors.centerIn: parent
    }


    onSelectedHandlesChanged:
    {
        for ( var pr in propFields)
        {
            propFields[pr].destroy();
        }

        propFields = [];

        if(selectedHandles.length === 1)
        {
            // create fields
            var h = selectedHandles[0];

            var stub = h.stubRef;
            var objName = stub.name;
            selObjName.text = objName.toUpperCase();

            var libEntry = null;

            for (var libItem in objLib)
                if((objLib[libItem]["name"]) === objName)
                {
                    libEntry = objLib[libItem];
                    break;
                }


            var optList = [];

            if(libEntry) // object in library
            {
                console.log(libEntry);

                if(libEntry.options) optList = clone(libEntry.options);
            }

            // std opts
            optList.push( { name: "x", type: "Number", isStd: true } );
            optList.push( { name: "y", type: "Number", isStd: true } );
            optList.push( { name: "w", type: "Number", isStd: true } );
            optList.push( { name: "h", type: "Number", isStd: true } );


            for( var opt in optList )
            {
                var option = optList[opt];

                // continue daqui
                var o = propComponent.createObject(propertiesColumn, { stub: stub, opt: option, isStd: option.isStd? true : false });
                propFields.push(o);

            }



        }
    }

    Component
    {
        id: propComponent

        Item
        {
            id: propertyRow
            property var stub: null
            property var opt: null
            property bool isStd: true
            property string propName: opt.name
            property string propType: opt.type

            height: 16
            width: parent.width

            function isSet() { return (stub && ((isStd) || (stub.options && (propName in stub.options)) ) ); }
            function getValue() { return (isStd? stub[propName] : stub.options[propName]); }

            function setValue(arg)
            {
                if(!stub)
                    return;

                var theVal = eval(propType + "(" + arg + ")");

                if(isStd)
                {
                    stub[propName] = theVal;
                }

                //field.objectManager.
            }

            DWTextBitmap { text: String(propName).toUpperCase(); anchors.verticalCenter: parent.verticalCenter }

            TextInput {

                function checkVisible() { return propertyRow.propType == "Number"; }


                visible: checkVisible();
                anchors.fill: parent
                text: isSet()? getValue() : "(unset)"
                horizontalAlignment: Text.AlignRight
                color: "white"
                font.family: "Monospace"

                Component.onCompleted: if(!checkVisible()) destroy();
            }
        }
    }


    // UTIL from stackoverflow at http://stackoverflow.com/questions/728360/how-do-i-correctly-clone-a-javascript-object

    function clone(obj) {
        var copy;

        // Handle the 3 simple types, and null or undefined
        if (null == obj || "object" != typeof obj) return obj;

        // Handle Date
        if (obj instanceof Date) {
            copy = new Date();
            copy.setTime(obj.getTime());
            return copy;
        }

        // Handle Array
        if (obj instanceof Array) {
            copy = [];
            for (var i = 0, len = obj.length; i < len; i++) {
                copy[i] = clone(obj[i]);
            }
            return copy;
        }

        // Handle Object
        if (obj instanceof Object) {
            copy = {};
            for (var attr in obj) {
                if (obj.hasOwnProperty(attr)) copy[attr] = clone(obj[attr]);
            }
            return copy;
        }

        throw new Error("Unable to copy obj! Its type isn't supported.");
    }
}
