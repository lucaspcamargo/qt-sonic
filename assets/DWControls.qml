import QtQuick 2.3

FocusScope {

    opacity: 0.5

    property real directionAngle: 0
    property real directionIntensity: 0

    property real directionValueX: 0
    property real directionValueY: 0

    property bool aPressed: buttonATouchPoint.pressed || combinedTouchPoint.pressed || kbdAEquivPressed
    property bool bPressed: buttonBTouchPoint.pressed || combinedTouchPoint.pressed || kbdBEquivPressed

    property bool dPadMode: false


    signal enterPressed()
    signal escapePressed()


    function recalcXY()
    {

        directionValueX = directionIntensity*Math.cos(directionAngle);
        directionValueY = directionIntensity*Math.sin(directionAngle);

        if(dPadMode)
        {
            if(directionValueX > 0.33) directionValueX = 1;
            else if(directionValueX < -0.33) directionValueX = -1;
            else directionValueX = 0;

            if(directionValueY > 0.33) directionValueY = 1;
            else if(directionValueY < -0.33) directionValueY = -1;
            else directionValueY = 0;

            directionIntensity = Math.sqrt(directionValueX*directionValueX + directionValueY * directionValueY);

        }
    }

    Image
    {
        id: dPad

        source: "ui/controls/controls-dpad-base-hd.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 48
        anchors.bottomMargin: 48

        Image
        {
            id:dPadCursor
            source: "ui/controls/controls-dpad-cursor.png"
            width: 200
            height: 200
            opacity: directionIntensity
            x: (0.5 + directionValueX/(dPadMode? Math.sqrt(directionIntensity): 1)/2)*parent.width - 100
            y: (0.5 - directionValueY/(dPadMode? Math.sqrt(directionIntensity): 1)/2)*parent.height - 100
        }

        Item
        {
            id: dPadHint
            anchors.fill: parent
            rotation: -180.0*directionAngle/Math.PI
            Image
            {
                source: "ui/controls/controls-dpad-hint-hd.png"
                anchors.verticalCenter: parent.verticalCenter
                x: 153
                opacity: directionIntensity

            }
        }

        MultiPointTouchArea
        {
            scale: 1.2
            anchors.fill: parent
            touchPoints: [TouchPoint
            {
                id: dPadTouchPoint
            }]

            function updateDirection( x, y )
            {

                    var i_directionValueX = (x - width/2)/(width/2) * scale;
                    var i_directionValueY = -(y - height/2)/(height/2) * scale;

                    directionIntensity = Math.min(1.0, Math.sqrt(i_directionValueX*i_directionValueX+i_directionValueY*i_directionValueY))
                    if(directionIntensity > 0)
                        directionAngle = Math.atan(i_directionValueY/i_directionValueX)
                                     + (i_directionValueX < 0? -Math.PI : 0);
                    else directionAngle = 0;

                    recalcXY();

            }

            onReleased: {
                directionValueX = 0;
                directionValueY = 0;
                directionIntensity = 0;
                directionAngle = 0;
            }

            onPressed: {
                updateDirection(touchPoints[0].x, touchPoints[0].y);
            }

            onUpdated: {
                updateDirection(touchPoints[0].x, touchPoints[0].y);
            }
        }
    }

    Image
    {
        id: buttonA
        source: "ui/controls/controls-button-a-hd.png"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 48
        anchors.bottomMargin: 48

        Image
        {
            id:buttonAGlow
            source: "ui/controls/controls-button-glow.png"
            anchors.centerIn: parent
            visible: buttonATouchPoint.pressed || combinedTouchPoint.pressed || kbdAEquivPressed
            opacity: 0.6
            width: 4*sourceSize.width
            height: width
        }

        MultiPointTouchArea
        {
            anchors.fill: parent
            touchPoints: [TouchPoint
            {
                id: buttonATouchPoint
            }]
        }
    }

    MultiPointTouchArea
    {
        anchors.bottom: buttonA.bottom
        anchors.right: buttonA.left
        anchors.left: buttonB.right
        anchors.top: buttonA.top
        touchPoints: [TouchPoint
        {
            id: combinedTouchPoint
        }]
    }

    Image
    {
        id: buttonB
        source: "ui/controls/controls-button-b-hd.png"
        anchors.bottom: parent.bottom
        anchors.right: buttonA.left
        anchors.rightMargin: 64
        anchors.bottomMargin: 48

        Image
        {
            id:buttonBGlow
            source: "ui/controls/controls-button-glow.png"
            anchors.centerIn: parent
            visible: buttonBTouchPoint.pressed || combinedTouchPoint.pressed || kbdBEquivPressed
            opacity: 0.6
            width: 4*sourceSize.width
            height: width
        }



        MultiPointTouchArea
        {
            anchors.fill: parent
            touchPoints: [TouchPoint
            {
                id: buttonBTouchPoint
            }]
        }
    }


    // KEYBOARD TREATMENT
    property bool kbdAEquivPressed: false
    property bool kbdBEquivPressed: false
    property bool kbdUpPressed: false
    property bool kbdDownPressed: false
    property bool kbdLeftPressed: false
    property bool kbdRightPressed: false



    property alias keyboardHandler: kbdHandler
    Item {
        id: kbdHandler

        width: 20
        height: 20
        focus: true

        Keys.onPressed:{
            if(event.key == Qt.Key_Right) kbdRightPressed = true;
            else if(event.key == Qt.Key_Left) kbdLeftPressed = true;
            else if(event.key == Qt.Key_Down) kbdDownPressed = true;
            else if(event.key == Qt.Key_Up) kbdUpPressed = true;
            else if(event.key == Qt.Key_X) kbdAEquivPressed = true;
            else if(event.key == Qt.Key_Z) kbdBEquivPressed = true;
            else{
                event.accepted = false;
                return;
            }

            event.accepted = true;
            kbdRecalcDirection();
        }

        Keys.onReleased: {
            if(event.key == Qt.Key_Right) kbdRightPressed = false;
            else if(event.key == Qt.Key_Left) kbdLeftPressed = false;
            else if(event.key == Qt.Key_Down) kbdDownPressed = false;
            else if(event.key == Qt.Key_Up) kbdUpPressed = false;

            else if(event.key == Qt.Key_X) kbdAEquivPressed = false;
            else if(event.key == Qt.Key_Z) kbdBEquivPressed = false;
            else{
                event.accepted = false;
                return;
            }

            event.accepted = true;
            kbdRecalcDirection();
        }

        Keys.onReturnPressed: enterPressed();
        Keys.onEscapePressed: escapePressed();
        Keys.onDigit0Pressed: mainContentLoader.source = Qt.resolvedUrl("DWMainScreen.qml")

        function kbdRecalcDirection()
        {
            var dirX = 0.0;
            var dirY = 0.0;
            if(kbdUpPressed) dirY += 1;
            if(kbdDownPressed) dirY -= 1;
            if(kbdRightPressed) dirX += 1;
            if(kbdLeftPressed) dirX -= 1;

            directionIntensity = Math.min(1.0, Math.sqrt(dirX*dirX+dirY*dirY))

            if(directionIntensity > 0)
                directionAngle = Math.atan(dirY/dirX)
                             + (dirX < 0? -Math.PI : 0);
            else directionAngle = 0;

            recalcXY();
        }
    }
}
