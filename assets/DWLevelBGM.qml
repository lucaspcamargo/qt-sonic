import QtQuick 2.4
import dw 1.0

QtObject {

    id: bgm

    property string id: ""
    property string introId: ""
    property string prefix: ""
    property bool loop: true
    property url source: (prefix != ""? prefix : "music/") + id
    property url introSource: introId == ""? "" : ((prefix != ""? prefix : "music/") + introId)

    property real volume: 1.0
    Behavior on volume { enabled: bgmPlayer.fadeEnabled; NumberAnimation { easing.type: Easing.OutExpo; duration: 3000; } }

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
        var sndSys = DWRoot.soundSystem;
        var name = "BGM" + Math.random();

        sndSource = sndSys.createSource(name);

        if(!sndSource) {
            console.log("Failed to create source");
            return;
        }

        sndStream = sndSys.createStreamUrl(source, sndSource);
        console.log("created stream 1");
        if(introId != "") sndIntroStream = sndSys.createStreamUrl(introSource, sndSource);
        console.log("created streams");

        sndPlaylist = sndSys.createStreamerPlaylist(sndSource);
        console.log("created playlist");

        if(sndIntroStream)
        {
            sndPlaylist.createItem(sndIntroStream, false);
        }
        sndPlaylist.createItem(sndStream, loop);

        sndStreamer = sndSys.createStreamer(name, sndSource, sndPlaylist);
        console.log("created streamer");
    }

    Component.onDestruction: {
        if(!DWRoot) return;
        var sndSys = DWRoot.soundSystem;

        sndSys.destroyStreamer(sndStreamer);
        sndSys.destroySource(sndSource);

    }

    function play() {
        sndSource.play();
    }

    function pause() {
        sndSource.pause();
    }

    function stop() {
        sndSource.stop();
    }

    function rewind() {
        sndStreamer.rewind();
    }

    function seekZero() {
        sndStreamer.rewind();
    }

    function playing() {
        return sndSource.state == NSoundSource.SSS_PLAYING;
    }

    function paused() {
        return sndSource.state == NSoundSource.SSS_PAUSED;
    }
}

