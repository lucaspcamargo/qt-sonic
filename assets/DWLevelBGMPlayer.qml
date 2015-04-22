import QtQuick 2.0

QtObject {

    id: bgmPlayer

    property real gain: DWRoot.soundSystem.masterGain
    property real underwaterGainFactor: Qt.platform.os == "android"? Math.sqrt(0.4) : 0.4

    property bool underwater: false
    property bool fadeEnabled: true

    property var bgmIds: []
    property var bgms: []
    property int currentBGM: -1
    property int currentBGMBuffer: -1

    Component.onCompleted:
    {
        for(var bgmIndex = 0; bgmIndex < levelData.bgms.length; bgmIndex++)
        {
            var bgmDef = levelData.bgms[bgmIndex];

            if(bgmDef.type ==="simple")
            {
                addBGM(bgmDef.id, true, bgmDef.inPrefix? levelData.urlPrefix : null, bgmDef.introId? bgmDef.introId : null);
            }
            else if(bgmDef === "playlist")
            {
                // TODO
            }
        }
    }

    onCurrentBGMChanged:
    {
        if(currentBGMBuffer >= 0 && currentBGMBuffer < bgms.length)
        {
            if(bgms[currentBGMBuffer].playing())
                bgms[currentBGMBuffer].volume = 0;

            console.log("stopping BGM "+currentBGMBuffer);
        }

        if(currentBGM >= 0 && currentBGM < bgms.length )
        {
            bgms[currentBGM].play();
            bgms[currentBGM].volume = gain;
            currentBGMBuffer = currentBGM;
            console.log("starting BGM "+currentBGM);

        }
    }

    onGainChanged: recalcGain();
    onUnderwaterChanged: recalcGain();

    function recalcGain()
    {
        if(currentBGM >= 0 && currentBGM < bgms.length )
        {
            bgms[currentBGM].volume = gain * (underwater? underwaterGainFactor : 1.0);
        }
    }



    function addBGM( id, loop, prefix, introId )
    {
        var index = bgmIds.length;

        var bgmC = Qt.createComponent("DWLevelBGM.qml");
        var bgmO = bgmC.createObject(scene, {"id": id, "volume": gain, "loop": loop, "introId": introId, "prefix": (prefix? prefix : "") });

        bgmIds.push(id);
        bgms.push(bgmO);

        return index;

    }

    function getBGMIndex( id )
    {
        return bgmIds.indexOf(id);
    }

    function getBGM( index )
    {
        return bgms[index];
    }

    function destroyBGM( index )
    {
        var bgmO = bgms[index];
        bgmO.destroy();

        bgms.splice(index, 1);
        bgmIds.splice(index, 1);
    }

    function resetBGM( index )
    {
        return bgms[index].seekZero();
    }

}

