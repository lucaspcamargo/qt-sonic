#ifndef DWPLAYERBASE_H
#define DWPLAYERBASE_H

#include "dwfieldobject.h"
#include <QtMath>

#define GENESIS_PIXELS_IN_PIXEL 1
#define GENESIS_FRAMES_IN_SECOND 60.0
#define GENESIS_FRAMES_IN_SECOND_INV (1.0/GENESIS_FRAMES_IN_SECOND)

#define cgDim(pixels) ((pixels) * GENESIS_PIXELS_IN_PIXEL)
#define cgSpd(pixelsPF) ((pixelsPF) * GENESIS_PIXELS_IN_PIXEL * GENESIS_FRAMES_IN_SECOND)
#define cgAcc(pixelsPFS) ((pixelsPFS) * GENESIS_PIXELS_IN_PIXEL * GENESIS_FRAMES_IN_SECOND * GENESIS_FRAMES_IN_SECOND)
#define cgTime(frames) ((frames) * GENESIS_FRAMES_IN_SECOND_INV)

class dwPlayerBase : public dwFieldObject
{
public:
    enum PlayerState
    {
        PS_AIR = 1,
        PS_GROUND,
        PS_CROUCHED,
        PS_LOOKINGUP
    };

private:

    Q_OBJECT

    Q_PROPERTY(bool active READ active WRITE setActive NOTIFY activeChanged)
    Q_PROPERTY(int numIterations READ numIterations WRITE setNumIterations NOTIFY numIterationsChanged)

    Q_PROPERTY(PlayerState playerState READ playerState WRITE setPlayerState NOTIFY playerStateChanged)
    Q_PROPERTY(int playerQuadMode READ playerQuadMode WRITE setPlayerQuadMode NOTIFY playerQuadModeChanged)
    Q_PROPERTY(bool playerQuadModeVertical READ playerQuadModeVertical NOTIFY playerQuadModeVerticalChanged)
    Q_PROPERTY(bool playerQuadModeReversed READ playerQuadModeReversed NOTIFY playerQuadModeReversedChanged)
    Q_PROPERTY(int playerQuadModeSign READ playerQuadModeSign NOTIFY playerQuadModeSignChanged)
    Q_PROPERTY(bool playerQuadModeLocked READ playerQuadModeLocked WRITE setPlayerQuadModeLocked NOTIFY playerQuadModeLockedChanged)
    Q_PROPERTY(bool playerJumping READ playerJumping WRITE setPlayerJumping NOTIFY playerJumpingChanged)
    Q_PROPERTY(bool playerRolling READ playerRolling WRITE setPlayerRolling NOTIFY playerRollingChanged)
    Q_PROPERTY(bool playerInvincible READ playerInvincible WRITE setPlayerInvincible NOTIFY playerInvincibleChanged)
    Q_PROPERTY(qreal playerSpindash READ playerSpindash WRITE setPlayerSpindash NOTIFY playerSpindashChanged)
    Q_PROPERTY(qreal ringCollectLock READ ringCollectLock WRITE setRingCollectLock NOTIFY ringCollectLockChanged)
    Q_PROPERTY(qreal playerHalfHeight READ playerHalfHeight WRITE setPlayerHalfHeight NOTIFY playerHalfHeightChanged)
    Q_PROPERTY(qreal playerHalfWidth READ playerHalfWidth WRITE setPlayerHalfWidth NOTIFY playerHalfWidthChanged)
    Q_PROPERTY(qreal playerInLayerB READ playerInLayerB WRITE setPlayerInLayerB NOTIFY playerInLayerBChanged)

    Q_PROPERTY(qreal xSpeed READ xSpeed WRITE setXSpeed NOTIFY xSpeedChanged)
    Q_PROPERTY(qreal ySpeed READ ySpeed WRITE setYSpeed NOTIFY ySpeedChanged)
    Q_PROPERTY(qreal gSpeed READ gSpeed WRITE setGSpeed NOTIFY gSpeedChanged)
    Q_PROPERTY(qreal gAngle READ gAngle WRITE setGAngle NOTIFY gAngleChanged)
    Q_PROPERTY(qreal gAngleRad READ gAngleRad NOTIFY gAngleRadChanged)
    Q_PROPERTY(qreal gAngleDifference READ gAngleDifference WRITE setGAngleDifference NOTIFY gAngleDifferenceChanged)
    Q_PROPERTY(bool turnedBack READ turnedBack WRITE setTurnedBack NOTIFY turnedBackChanged)

    Q_ENUMS(PlayerState)

    bool lazyProperties;
    qreal _x;
    qreal _y;

    struct SavedLazyState
    {
        PlayerState playerState;
        int playerQuadMode;
        bool playerQuadModeVertical;
        bool playerQuadModeReversed;
        int playerQuadModeSign;
        bool playerJumping;
        bool playerRolling;
        bool playerInvincible;
        qreal playerSpindash;
        qreal ringCollectLock;
        qreal playerHalfHeight;
        qreal playerHalfWidth;

        qreal xSpeed;
        qreal ySpeed;
        qreal gSpeed;
        bool turnedBack;
        qreal gAngleDifference;
        qreal gAngle;
        qreal gAngleRad;

    } lastState;

    PlayerState m_playerState;
    int m_playerQuadMode;
    bool m_playerQuadModeVertical;
    bool m_playerQuadModeReversed;
    int m_playerQuadModeSign;
    bool m_playerJumping;
    bool m_playerRolling;
    bool m_playerInvincible;
    qreal m_playerSpindash;
    qreal m_ringCollectLock;
    qreal m_playerHalfHeight;
    qreal m_playerHalfWidth;

    qreal m_xSpeed;
    qreal m_ySpeed;
    qreal m_gSpeed;
    bool m_turnedBack;
    qreal m_gAngleDifference;
    qreal m_gAngle;
    qreal m_gAngleRad;

    struct PhysicsProperties
    {
        qreal gravity;
        qreal ySpeedCap;
        qreal groundSpeedCap;
        qreal groundSpeedCapRolling;
        qreal airSpeedCap;
        qreal groundAccel;
        qreal groundFric;
        qreal groundFricRoll;
        qreal groundBrake;
        qreal groundBrakeRoll;
        qreal groundRollMinSpeed;
        qreal groundCeilingMinSpeed;
        qreal groundSlopeFactor;
        qreal groundSlopeFactorRollUp;
        qreal groundSlopeFactorRollDown;
        qreal peeloutSpeed;
        qreal airAccel;
        qreal jumpSpeed;
        qreal jumpCutoff;
    } phy;

    struct AnimationProperties
    {
        qreal distancePerFrameWalk;
        qreal timePerFrameAccum;
        QString currentAnimation;
        qreal timeIntoAnimation;
    } anim;

    struct SensorProperties
    {
        qreal verticalSensorLength;
        qreal halfHeightDifference;
        qreal horizontalSensorYOffset;
        qreal horizontalSensorLength;
        qreal sensorHSpan;
    } sens;

    struct MiscVars
    {
        qreal timerIdle;
        bool controlAPressedLastFrame;
        bool controlBPressedLastFrame;
        PlayerState playerStateLastFrame;
        int playerQuadModeSecondToLastFrame;

        qreal horizontalControlLock;
        bool controlLockHit;
    } misc;

    struct ControlCapture
    {
        qreal directionValueX;
        qreal directionValueY;
        bool aPressed;
        bool bPressed;
    } controls;

    SavedLazyState captureState();
    bool putOnGround(bool, bool, qreal, qreal, qreal angle, bool dontSetAngles = false);
    void recalcDimensions();

    int m_numIterations;

    qreal m_playerInLayerB;

    bool m_active;

    bool m_playerQuadModeLocked;

public:
    explicit dwPlayerBase(QQuickItem *parent = 0);

    qreal xSpeed() const
    {
        return m_xSpeed;
    }

    bool turnedBack() const
    {
        return m_turnedBack;
    }

    qreal gAngleDifference() const
    {
        return m_gAngleDifference;
    }

    qreal gAngle() const
    {
        return m_gAngle;
    }

    qreal gAngleRad() const
    {
        return m_gAngleRad;
    }

    qreal gSpeed() const
    {
        return m_gSpeed;
    }

    qreal ySpeed() const
    {
        return m_ySpeed;
    }

    PlayerState playerState() const
    {
        return m_playerState;
    }

    int playerQuadMode() const
    {
        return m_playerQuadMode;
    }

    bool playerQuadModeVertical() const
    {
        return m_playerQuadModeVertical;
    }

    bool playerQuadModeReversed() const
    {
        return m_playerQuadModeReversed;
    }

    int playerQuadModeSign() const
    {
        return m_playerQuadModeSign;
    }

    bool playerJumping() const
    {
        return m_playerJumping;
    }

    bool playerRolling() const
    {
        return m_playerRolling;
    }

    bool playerInvincible() const
    {
        return m_playerInvincible;
    }

    qreal playerSpindash() const
    {
        return m_playerSpindash;
    }


    qreal ringCollectLock() const
    {
        return m_ringCollectLock;
    }

    qreal playerHalfHeight() const
    {
        return m_playerHalfHeight;
    }

    qreal playerHalfWidth() const
    {
        return m_playerHalfWidth;
    }

    int numIterations() const
    {
        return m_numIterations;
    }

    qreal playerInLayerB() const
    {
        return m_playerInLayerB;
    }

    bool active() const
    {
        return m_active;
    }

    bool playerQuadModeLocked() const
    {
        return m_playerQuadModeLocked;
    }

signals:

    void playSfx(QString sfx, qreal pitch = 1.0);
    void animationChanged( QString animation );
    void jumpedInMidair();
    void gotHit();
    void playInvicibilityAnimation();


    void xSpeedChanged(qreal arg);

    void turnedBackChanged(bool arg);

    void gAngleDifferenceChanged(qreal arg);

    void gAngleChanged(qreal arg);

    void gSpeedChanged(qreal arg);

    void ySpeedChanged(qreal arg);

    void playerStateChanged(PlayerState arg);

    void playerQuadModeChanged(int arg);

    void playerQuadModeVerticalChanged(bool arg);

    void playerQuadModeReversedChanged(bool arg);

    void playerQuadModeSignChanged(int arg);

    void playerJumpingChanged(bool arg);

    void playerRollingChanged(bool arg);

    void playerInvincibleChanged(bool arg);

    void playerSpindashChanged(qreal arg);

    void gAngleRadChanged(qreal arg);

    void ringCollectLockChanged(qreal arg);

    void playerHalfHeightChanged(qreal arg);

    void playerHalfWidthChanged(qreal arg);

    void numIterationsChanged(int arg);

    void playerInLayerBChanged(qreal arg);

    void activeChanged(bool arg);

    void playerQuadModeLockedChanged(bool arg);

public slots:

    void updateSim(qreal dt);
    void injectControl(qreal, qreal, bool, bool);
    QString playerIteration(qreal dt, int numIterations);
    void setAnimation(QString anim);
    void getHit(int xc, int yc);
    void resetControlLocks();
    void setHorizontalControlLock(qreal time);
    void recalcPhysicsVariables(bool water);

    qreal getCurrentGravity(){ return phy.gravity;  }


    void setXSpeed(qreal arg)
    {
        if (m_xSpeed == arg)
            return;

        m_xSpeed = arg;
        if(!lazyProperties) emit xSpeedChanged(arg);
    }
    void setTurnedBack(bool arg)
    {
        if (m_turnedBack == arg)
            return;

        m_turnedBack = arg;
        if(!lazyProperties) emit turnedBackChanged(arg);
    }
    void setGAngleDifference(qreal arg)
    {
        if (m_gAngleDifference == arg)
            return;

        m_gAngleDifference = arg;
        if(!lazyProperties) emit gAngleDifferenceChanged(arg);
    }
    void setGAngle(qreal arg)
    {
        if (m_gAngle == arg)
            return;

        m_gAngle = arg;
        emit gAngleChanged(arg);

        m_gAngleRad = m_gAngle * M_PI / 180.0;
        if(!lazyProperties) emit gAngleRadChanged(m_gAngleRad);
    }
    void setGSpeed(qreal arg)
    {
        if (m_gSpeed == arg)
            return;

        m_gSpeed = arg;
        if(!lazyProperties) emit gSpeedChanged(arg);
    }
    void setYSpeed(qreal arg)
    {
        if (m_ySpeed == arg)
            return;

        m_ySpeed = arg;
        if(!lazyProperties) emit ySpeedChanged(arg);
    }
    void setPlayerState(PlayerState arg)
    {
        if (m_playerState == arg)
            return;

        m_playerState = arg;
        recalcDimensions();
        if(!lazyProperties) emit playerStateChanged(arg);
    }
    void setPlayerQuadMode(int arg)
    {
        if (m_playerQuadMode == arg)
            return;

        m_playerQuadMode = arg;
        m_playerQuadModeVertical = (m_playerQuadMode == 1) || (m_playerQuadMode == 3);
        m_playerQuadModeReversed = m_playerQuadMode > 1;
        m_playerQuadModeSign = m_playerQuadModeReversed ? -1 : 1;

        if(!lazyProperties)
        {
            emit playerQuadModeChanged(arg);
            emit playerQuadModeVerticalChanged(m_playerQuadModeVertical);
            emit playerQuadModeReversedChanged(m_playerQuadModeReversed);
            emit playerQuadModeSignChanged(m_playerQuadModeSign);
        }
    }
    void setPlayerJumping(bool arg)
    {
        if (m_playerJumping == arg)
            return;

        m_playerJumping = arg;
        if(!lazyProperties) emit playerJumpingChanged(arg);
    }
    void setPlayerRolling(bool arg)
    {
        if (m_playerRolling == arg)
            return;

        m_playerRolling = arg;
        recalcDimensions();
        if(!lazyProperties) emit playerRollingChanged(arg);
    }
    void setPlayerInvincible(bool arg)
    {
        if (m_playerInvincible == arg)
            return;

        m_playerInvincible = arg;
        if(!lazyProperties) emit playerInvincibleChanged(arg);
    }
    void setPlayerSpindash(qreal arg)
    {
        if (m_playerSpindash == arg)
            return;

        m_playerSpindash = arg;
        if(!lazyProperties) emit playerSpindashChanged(arg);
    }
    void setRingCollectLock(qreal arg)
    {
        if (m_ringCollectLock == arg)
            return;

        m_ringCollectLock = arg;
        if(!lazyProperties) emit ringCollectLockChanged(arg);
    }
    void setPlayerHalfHeight(qreal arg)
    {
        if (m_playerHalfHeight == arg)
            return;

        m_playerHalfHeight = arg;
        if(!lazyProperties) emit playerHalfHeightChanged(arg);
    }
    void setPlayerHalfWidth(qreal arg)
    {
        if (m_playerHalfWidth == arg)
            return;

        m_playerHalfWidth = arg;
        if(!lazyProperties) emit playerHalfWidthChanged(arg);
    }
    void setNumIterations(int arg)
    {
        if (m_numIterations == arg)
            return;

        m_numIterations = arg;
        if(!lazyProperties) emit numIterationsChanged(arg);
    }
    void setPlayerInLayerB(qreal arg)
    {
        if (m_playerInLayerB == arg)
            return;

        m_playerInLayerB = arg;
        emit playerInLayerBChanged(arg);
    }
    void setActive(bool arg)
    {
        if (m_active == arg)
            return;

        m_active = arg;
        emit activeChanged(arg);
    }
    void setPlayerQuadModeLocked(bool arg)
    {
        if (m_playerQuadModeLocked == arg)
            return;

        m_playerQuadModeLocked = arg;
        emit playerQuadModeLockedChanged(arg);
    }
};

#endif // DWPLAYERBASE_H
