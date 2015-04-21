import QtQuick 2.3
import QtMultimedia 5.4

Audio
{
    id: bgm

    property string id: ""
    property string prefix: ""

    source: (prefix != ""? prefix : "music/") + id
    loops: Audio.Infinite
    autoPlay: false
    Behavior on volume { enabled: bgmPlayer.fadeEnabled; NumberAnimation { easing.type: Easing.OutExpo; duration: 3000; } }
    onVolumeChanged: { if(volume == 0 ) pause(); else if(!playing() || paused()) play(); }

    function seekZero() { seek(0); }

}

