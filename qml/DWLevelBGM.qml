import QtQuick 2.4
import dw 1.0

QtObject {

    id: bgm

    property string mainId: ""
    property string introId: ""
    property string prefix: ""
    property bool loop: true
    property string realizedPrefix: (prefix != ""? prefix : resBase + "music/")
    property url source: realizedPrefix + mainId
    property url introSource: introId == "" ? "" : (realizedPrefix + introId)
    property bool fadeEnabled: bgmPlayer? bgmPlayer.fadeEnabled : true

    property real volume: 1.0
    Behavior on volume { enabled: bgm.fadeEnabled; NumberAnimation { easing.type: Easing.OutExpo; duration: 3000; } }

    onVolumeChanged: {

        if(!sndSource)
            return;

        if(volume == 0 )
            pause();
        else if(!playing() || paused())
            play();

        sndSource.setGain(volume);

    }

    property var sndSource: null
    property var sndStream: null
    property var sndIntroStream: null
    property var sndStreamer: null
    property var sndPlaylist: null

    Component.onCompleted:
    {
        if(!dwSoundSystem) return;
        var sndSys = dwSoundSystem;
        var name = "BGM" + Math.random();

        sndSource = sndSys.createSource(name);
        sndSource.setGain(volume);

        if(!sndSource) {
            console.log("Failed to create source");
            return;
        }

        sndStream = sndSys.createStreamUrl(source, sndSource);
        if(!sndStream) return;

        if(introId != "") sndIntroStream = sndSys.createStreamUrl(introSource, sndSource);

        sndPlaylist = sndSys.createStreamerPlaylist(sndSource);

        if(sndIntroStream)
        {
            sndPlaylist.createItem(sndIntroStream, false);
        }
        sndPlaylist.createItem(sndStream, loop);

        sndStreamer = sndSys.createStreamer(name, sndSource, sndPlaylist);

    }

    Component.onDestruction: {
        if(!dwSoundSystem) return;

        dwSoundSystem.destroyStreamer(sndStreamer);
        dwSoundSystem.destroySource(sndSource);

    }

    function play() {
        if(!dwSoundSystem) return;
        sndSource.play();
    }

    function pause() {
        if(!dwSoundSystem) return;
        sndSource.pause();
    }

    function stop() {
        if(!dwSoundSystem) return;
        sndSource.stop();
    }

    function rewind() {
        if(!dwSoundSystem) return;
        sndStreamer.rewind();
    }

    function seekZero() {
        if(!dwSoundSystem) return;
        sndStreamer.rewind();
    }

    function playing() {
        if(!dwSoundSystem) return;
        return sndSource.state == NSoundSource.SSS_PLAYING;
    }

    function paused() {
        if(!dwSoundSystem) return;
        return sndSource.state == NSoundSource.SSS_PAUSED;
    }
}

