import QtQuick 2.0
import dw 1.0
import ".."

DWFieldObject {

    id: platformBase

    width: 64
    height: 16
    z: field.objAZ

    property real radius: 128

    DWFOPhysicsBody
    {
        id: body
    }

    DWSoundEffect
    {
        id: popSound
        source: "sfx/pop.wav"
    }
}

