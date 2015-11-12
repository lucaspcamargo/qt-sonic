#ifndef DWCONTROLLERSTATE_H
#define DWCONTROLLERSTATE_H

#include <QObject>

class dwControllerState : public QObject
{
    Q_OBJECT
public:
    explicit dwControllerState(QObject *parent = 0);

    bool Up;
    bool Down;
    bool Left;
    bool Right;
    bool Start;
    bool Back;
    bool LeftShoulder;
    bool RightShoulder;
    bool AButton;
    bool BButton;
    bool XButton;
    bool YButton;

    qreal StickX;
    qreal StickY;

signals:


public slots:
    bool getUp() { return Up; }
    bool getDown() { return Down; }
    bool getLeft() { return Left; }
    bool getRight() { return Right; }
    bool getStart() { return Start; }
    bool getBack() { return Back; }
    bool getLeftShoulder() { return LeftShoulder; }
    bool getRightShoulder() { return RightShoulder; }
    bool getAButton() { return AButton; }
    bool getBButton() { return BButton; }
    bool getXButton() { return XButton; }
    bool getYButton() { return YButton; }

    qreal getStickX() { return StickX; }
    qreal getStickY() { return StickY; }
};

#endif // DWCONTROLLERSTATE_H
