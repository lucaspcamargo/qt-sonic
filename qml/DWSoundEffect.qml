import QtQuick 2.4
import dw 1.0

QtObject {
    property url source: ""
    property var soundBuffer: null
    property real gain: 1.0

    Component.onCompleted:
    {
        if(source == "") return;
        if(!dwSoundSystem) return;

        soundBuffer = dwSoundSystem.buffer(source);

        if(soundBuffer == null)
        {
            soundBuffer = DWRoot.soundSystem.createBuffer(source);

            DWRoot.soundSystem.fillBuffer(soundBuffer, source);
        }
    }

    onSourceChanged: Component.onCompleted();

    function play(gainArg, pitch, xPos, yPos, zPos, attenuationScale)
    {
        if((!soundBuffer) || (!dwSoundSystem)) return;

        var src = DWRoot.soundSystem.createSource(NSoundSource.SSR_SFX);
        src.gain *= gain;

        if(gainArg) src.gain *= gainArg;
        if(pitch) src.pitch = pitch;
        if(xPos) src.position = Qt.vector3d(xPos, yPos, zPos).times((attenuationScale? attenuationScale : 1));

        src.attachBuffer(soundBuffer);
        src.destroyAfterStopped = true;
        src.play();
    }
}
