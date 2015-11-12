import QtQuick 2.3

FocusScope {

    opacity: 1.0

    property real directionAngle: 0
    property real directionIntensity: 0

    property real directionValueX: 0
    property real directionValueY: 0

    property bool aPressed: buttonATouchPoint.pressed || kbdAEquivPressed
    property bool bPressed: buttonBTouchPoint.pressed || kbdBEquivPressed

    property bool dPadMode: false
    property bool joystickEnabled: true

    signal enterPressed()
    signal escapePressed()

    function getFocus()
    {
        keyboardHandler.forceActiveFocus();
    }

    function recalcXY()
    {

        var dx = directionIntensity*Math.cos(directionAngle);
        var dy = directionIntensity*Math.sin(directionAngle);

        if(dPadMode)
        {
            if(dx > 0.33) dx = 1;
            else if(dx < -0.33) dx = -1;
            else dx = 0;

            if(dy > 0.33) dy = 1;
            else if(dy < -0.33) dy = -1;
            else dy = 0;

            directionIntensity = Math.min(1, Math.sqrt(dx*dx + dy * dy));
        }

        directionValueX = dx;
        directionValueY = dy;
    }

    function update()
    {
        controllerHub.update();

        if(joystickEnabled)
        {
            var count = controllerHub.controllerCount();

            if(count && controllerHub.controllerIsConnected(0))
            {
                //var s = controllerHub.controllerState(0);

                //if(!s)
                //{
                 //   console.log("[DWControls.qml] Controller has no state!");
                 //   return;
                //}

                kbdAEquivPressed = controllerHub.getControllerAButton(0);
                kbdBEquivPressed = controllerHub.getControllerBButton(0);

                var dirX = 0.0;
                var dirY = 0.0;
                if(controllerHub.getControllerUp(0)) dirY += 1;
                if(controllerHub.getControllerDown(0)) dirY -= 1;
                if(controllerHub.getControllerLeft(0)) dirX += 1;
                if(controllerHub.getControllerRight(0)) dirX -= 1;

                dirX += controllerHub.getControllerStickX(0);
                dirY += controllerHub.getControllerStickY(0);

                directionIntensity = Math.min(1.0, Math.sqrt(dirX*dirX+dirY*dirY))

                if(directionIntensity > 0)
                    directionAngle = Math.atan(dirY/dirX)
                                 + (dirX < 0? -Math.PI : 0);
                else directionAngle = 0;

                recalcXY();
            }
        }
    }

    Image
    {
        id: dPad

        source: resBase + "ui/virtualpad/dpad.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.bottomMargin: 16

        Image
        {
            id:dPadCursor
            source: resBase + "ui/virtualpad/dpad-marker.png"
            opacity: directionIntensity
            x: (0.5 + 0.4 * directionIntensity * Math.cos(directionAngle))*parent.width - height/2
            y: (0.5 - 0.4 * directionIntensity * Math.sin(directionAngle))*parent.height - width/2
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
        source: resBase + "ui/virtualpad/button-a.png"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.bottomMargin: 14

        Image
        {
            id:buttonAGlow
            source: resBase + "ui/virtualpad/button-marker.png"
            anchors.centerIn: parent
            visible: buttonATouchPoint.pressed
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


    Image
    {
        id: buttonB
        source: resBase + "ui/virtualpad/button-b.png"
        anchors.bottom: parent.bottom
        anchors.right: buttonA.left
        anchors.rightMargin: 20
        anchors.bottomMargin: 14

        Image
        {
            id:buttonBGlow
            source: resBase + "ui/virtualpad/button-marker.png"
            anchors.centerIn: parent
            visible: buttonBTouchPoint.pressed
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
        Keys.onDeletePressed: {joystickEnabled = !joystickEnabled; debugMessage.text = "Joystick " + (joystickEnabled? "Enabled" : "Disbled");}

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
