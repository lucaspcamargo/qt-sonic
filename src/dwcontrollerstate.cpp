#include "dwcontrollerstate.h"

dwControllerState::dwControllerState(QObject *parent) : QObject(parent)
{
    Up = Down = Left = Right = Start = Back = LeftShoulder =
            RightShoulder = AButton = BButton = XButton = YButton = false;
    StickX = StickY = 0.0f;
}

