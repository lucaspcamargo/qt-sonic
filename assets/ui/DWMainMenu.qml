import QtQuick 2.3
import QtGraphicalEffects 1.0
import ".."

DWUIScreenTemplate
{
    id: mainMenu

    screenLabel: "Main Menu"
    property var buttonInstructions: [ ['X', "Select"] ]
    property bool isCurrent: mainStackView.currentItem == this

    property var listModel: ListModel {

        ListElement
        {
            label: "Play"
        }

        ListElement
        {
            label: "Config"
        }

        ListElement
        {
            label: "Extras"
        }

        ListElement
        {
            label: "Quit"
        }
    }

    property var execMenuItem: function(i) {
        switch(i)
        {
        case 0:
            mainScreen.fadeAction = function(){mainContentLoader.source = Qt.resolvedUrl("../DWLevelScene.qml")};
            mainScreen.fade();
            break;
        case 1:
            mainScreen.stack(Qt.resolvedUrl("DWConfigScreen.qml"));
            break;
        case 2:
            mainContentLoader.source = Qt.resolvedUrl("../dev/DWDevMenu.qml"); //mainScreen.stack(Qt.resolvedUrl("DWExtrasScreen.qml"));
            break;
        case 3:
            mainScreen.fadeAction = Qt.quit;
            mainScreen.fade();
            break;
        }
    }

    onIsCurrentChanged: if(isCurrent) menuView.forceActiveFocus();

    Rectangle
    {
        id: shadow
        width: parent.width
        height: 64

        anchors.centerIn: parent
        color: "#222"
        opacity: 0.7

        Behavior on y { NumberAnimation { easing.type: Easing.InOutQuart; duration: sceneTitle.animDuration } }
    }


    Item
    {
        id: itemIcon
        Behavior on opacity { NumberAnimation{} }

        width: 64
        height: 64
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -8

        Repeater
        {
            model: 0//menuView.count

            Image
            {
                opacity: menuView.currentIndex == index? 1 : 0

                Behavior on opacity { enabled: itemIcon.opacity == 1; NumberAnimation{ duration: 100 } }

                source: ("menu/item-%1.png").arg(index)
                anchors.fill: parent
            }
        }
    }

    ListView
    {
        id: menuView
        anchors.centerIn: parent
        pixelAligned: true

        orientation: ListView.Horizontal
        displayMarginBeginning: parent.width
        displayMarginEnd: parent.width

        focus: mainMenu

        header: Component{Item{height: 2;width: (menuView.width - 140) / 2}}
        footer: header

        width: parent.width
        height: 64

        highlightMoveDuration: 200

        model: listModel

        delegate: Item   {

            id: delegateItem
            property bool isCurrent: menuView.currentIndex == index

            width: 140
            height: 64

            Image
            {
                source: "menu/menu-shadow.png"
                height: 64
                y: 8
            }

            DWTextBitmap
            {
                visible: false
                anchors.centerIn: parent
                text: label.toUpperCase()
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    var _DW_MOBILE = true; // make it work on desktop as if it were touch
                    if(_DW_MOBILE && !isCurrent)
                    {
                        menuView.currentIndex = index;
                        return;
                    }

                    menuView.currentIndex = index;
                    actionAnimation.start();
                }
            }


            Text
            {
                id: textLabelS
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.baseline: parent.bottom
                anchors.baselineOffset: -10
                text: label
                font.family: "OpenSans"
                font.pixelSize: 26
                font.weight: Font.Light
                color: "black" //"#222"
            }
            Text
            {
                id: textLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.baseline: parent.bottom
                anchors.baselineOffset: -11
                text: label
                font.family: "OpenSans"
                font.pixelSize: 26
                font.weight: Font.Light
                color: isCurrent? "white" : "#AAA"
                Behavior on color {
                    ColorAnimation {
                    }
                }
            }

            Rectangle
            {
                id: selectedHighlight
                color: "#cf0"

                ColorAnimation{
                    target: selectedHighlight
                    property: "color"
                    from: "#cf0"
                    to: "#8a0"
                    duration: 200
                    running: true
                    loops: Animation.Infinite
                    easing.type: Easing.SineCurve
                }
                width: textLabel.width
                height: 2
                opacity: isCurrent? 1 : 0
                Behavior on opacity {NumberAnimation{}}
                anchors.horizontalCenter: parent.horizontalCenter
                y: 62
            }

            NumberAnimation
            {
                running: !isCurrent && actionAnimation.running
                target: delegateItem
                property: "opacity"
                duration: 200
                to: 0
            }




            Keys.onReturnPressed:
            {
                actionAnimation.start();
            }

            Keys.onPressed:
            {
                if(event.key == Qt.Key_X) actionAnimation.start();
            }
        }

        currentIndex: 0
        contentX: currentItem.x - headerItem.width
        onCurrentIndexChanged: { if(isCurrent) changeSfx.play(); }
        Behavior on contentX {NumberAnimation{easing.type: Easing.InOutQuart}}

        onMovementStarted: itemIcon.opacity = 0

        onMovementEnded:
        {
            var i = indexAt(contentX + width/2, 0);
            currentIndex = i;

            itemIcon.opacity = 1;

            // make contentX snap back by forcing reevaluating binding even if currentIndex is still the same
            headerItem.width --;
            headerItem.width ++;
        }



        Component.onCompleted: forceActiveFocus()

    }

    SequentialAnimation
    {
        id: actionAnimation

        ScriptAction
        {
            script:
            {
                selectSfx.play();
                menuView.enabled = false;
            }

        }


        PauseAnimation {
            duration: 300
        }



        ScriptAction
        {
            id: stuffDoer

            script:
            {
                execMenuItem(menuView.currentIndex);
            }
        }


        PauseAnimation {
            duration: 550
        }

        ScriptAction
        {
            script: if(mainScreen.fadeAction === null) mainMenu.reset();
        }
    }

    function reset()
    {
        menuView.enabled = true;
        var curr = menuView.currentIndex;
        var model = menuView.model;
        menuView.model = null;
        menuView.model = model;
        menuView.currentIndex = curr;
    }

}

