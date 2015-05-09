import QtQuick 2.0
import dw 1.0

ObjTrigger
{
    width: 16
    height: 16

    property int bgIndex: 0

    debugText: "BG"
    continuous: false

    function morph(opts)
    {
        if(opts.length && opts.length > 0)
        {
            bgIndex = Number(opts[0]);
        }
    }

    onTriggered:
    {
        bg.bgIndex = bgIndex;
    }
}


