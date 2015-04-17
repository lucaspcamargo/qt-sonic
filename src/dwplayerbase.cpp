#include "dwplayerbase.h"
#include "dwfieldphysicsworld.h"



dwPlayerBase::dwPlayerBase(QQuickItem *parent) :
    QQuickItem(parent)
{
    m_active = true;
    m_numIterations = 4;

    lazyProperties = false;

    //init vars
    m_playerState = PS_GROUND;
    m_playerQuadMode = 0;
    m_playerQuadModeVertical = false; //(playerQuadMode == 1) || (playerQuadMode == 3)
    m_playerQuadModeReversed = false; //playerQuadMode > 1
    m_playerQuadModeSign = 1; //playerQuadModeReversed ? -1  = 1
    m_playerQuadModeLocked = 0;
    m_playerJumping = false;
    m_playerRolling = false;
    m_playerInvincible = false;
    m_playerSpindash = -1;
    m_ringCollectLock = 0.0;
    m_playerHalfHeight = cgDim( m_playerRolling || m_playerState == PS_CROUCHED? 15 : 20);
    m_playerHalfWidth = cgDim(10);
    m_playerInLayerB = false;


    m_xSpeed = 0;
    m_ySpeed = 0;
    m_gSpeed = 0;
    m_gAngle = 0;
    m_gAngleDifference = 0;
    m_gAngleRad = 0;
    m_turnedBack = false;

    recalcPhysicsVariables(false);

    anim.distancePerFrameWalk = cgDim(10);
    anim.timePerFrameAccum = 0.0;
    anim.currentAnimation = "falling";
    anim.timeIntoAnimation = 0.0;

    sens.verticalSensorLength = cgDim(15.75) + m_playerHalfHeight;
    sens.halfHeightDifference = cgDim(5);
    sens.horizontalSensorYOffset = cgDim(4.05); // plus .05 to fix 16px-high stairs
    sens.horizontalSensorLength = cgDim(11);
    sens.sensorHSpan = cgDim( m_playerRolling? 7 : 9 );

    misc.timerIdle = 0.0;
    misc.controlAPressedLastFrame = false;
    misc.controlBPressedLastFrame = false;
    misc.playerStateLastFrame  = PS_AIR;
    misc.playerQuadModeSecondToLastFrame = 0;

    misc.horizontalControlLock = 0.0;
    misc.controlLockHit = false;

    controls.directionValueX = 0;
    controls.directionValueY = 0;
    controls.aPressed = false;
    controls.bPressed = false;
}

void dwPlayerBase::updateSim(qreal dt)
{

    if(!m_active) return;

    {
        lazyProperties = true;
        _x = x();
        _y = y();

        lastState.gAngle = m_gAngle;
        lastState.gAngleDifference = m_gAngleDifference;
        lastState.gSpeed = m_gSpeed;
        lastState.ringCollectLock = m_ringCollectLock;
        lastState.playerHalfHeight = m_playerHalfHeight;
        lastState.playerHalfWidth = m_playerHalfWidth;
        lastState.playerInvincible = m_playerInvincible;
        lastState.playerJumping = m_playerJumping;
        lastState.playerQuadMode = m_playerQuadMode;
        lastState.playerRolling = m_playerRolling;
        lastState.playerSpindash = m_playerSpindash;
        lastState.playerState = m_playerState;
        lastState.turnedBack = m_turnedBack;
        lastState.xSpeed = m_xSpeed;
        lastState.ySpeed = m_ySpeed;
    };

    QString newAnimation = "";
    for(int i = 0; i < m_numIterations; i++)
    {
        QString anim = playerIteration(dt/m_numIterations, m_numIterations);
        if(!anim.isEmpty()) newAnimation = anim;
    }
    if(!newAnimation.isEmpty() && newAnimation != anim.currentAnimation)
    {
        setAnimation(newAnimation);
    }


    {
        lazyProperties = false;
        setX(_x);
        setY(_y);

        if( lastState.gAngle != m_gAngle)
        {
            emit gAngleChanged(m_gAngle);
            emit gAngleRadChanged(m_gAngleRad);
        }
        //if( lastState.gAngleDifference != m_gAngleDifference) emit gAngleDifferenceChanged(m_gAngleDifference);
        if( lastState.gSpeed != m_gSpeed) emit gSpeedChanged(m_gSpeed);
        if( lastState.ringCollectLock != m_ringCollectLock) emit ringCollectLockChanged(m_ringCollectLock);
        if( lastState.playerHalfHeight != m_playerHalfHeight) emit playerHalfHeightChanged(m_playerHalfHeight);
        if( lastState.playerHalfWidth != m_playerHalfWidth) emit playerHalfWidthChanged(m_playerHalfWidth);
        if( lastState.playerInvincible != m_playerInvincible) emit playerInvincibleChanged(m_playerInvincible);
        if( lastState.playerJumping != m_playerJumping) emit playerJumpingChanged(m_playerJumping);
        if( lastState.playerQuadMode != m_playerQuadMode)
        {
            emit playerQuadModeChanged(m_playerQuadMode);
            emit playerQuadModeReversedChanged(m_playerQuadModeReversed);
            emit playerQuadModeVerticalChanged(m_playerQuadModeVertical);
            emit playerQuadModeSignChanged(m_playerQuadModeSign);
        }
        if( lastState.playerRolling != m_playerRolling) emit playerRollingChanged(m_playerRolling);
        if( lastState.playerSpindash != m_playerSpindash) emit playerSpindashChanged(m_playerSpindash);
        if( lastState.playerState != m_playerState) emit playerStateChanged(m_playerState);
        if( lastState.turnedBack != m_turnedBack) emit turnedBackChanged(m_turnedBack);
        if( lastState.xSpeed != m_xSpeed) emit xSpeedChanged(m_xSpeed);
        if( lastState.ySpeed != m_ySpeed) emit ySpeedChanged(m_ySpeed);
    };

    //finally, recenter camera based on final x and y
    // emit recenterCamera(qRound(_x), qRound(_y - ((m_playerRolling || (m_playerState == PS_CROUCHED))? sens.halfHeightDifference : 0)));
}

void dwPlayerBase::injectControl(qreal dvX, qreal dvY, bool aP, bool bP)
{
    controls.directionValueX = dvX;
    controls.directionValueY = dvY;
    controls.aPressed = aP;
    controls.bPressed = bP;
}

QString dwPlayerBase::playerIteration(qreal dt, int numIterations)
{

    QString newAnimation = "";

    if(m_playerState == PS_GROUND)
    {
        // on the floor
        // first of all, add slope factor
        setGSpeed(m_gSpeed + dt * qSin(m_gAngleRad) *
                  (!m_playerRolling? phy.groundSlopeFactor: (qSin(m_gAngleRad) * m_gSpeed > 0? phy.groundSlopeFactorRollDown : phy.groundSlopeFactorRollUp )));

        if(!misc.horizontalControlLock && controls.directionValueX > 0)
        {
            // holding right

            // are we going right?
            if(m_gSpeed >= 0)
            {
                // accelerate when applicable
                if(!m_playerRolling && m_gSpeed < phy.groundSpeedCap)
                {

                    setGSpeed(m_gSpeed + dt * controls.directionValueX * phy.groundAccel);
                    if(m_gSpeed > phy.groundSpeedCap) setGSpeed(phy.groundSpeedCap);
                }
                setTurnedBack(false);

                if(!m_playerRolling)
                    newAnimation = m_gSpeed >= phy.groundSpeedCap? (m_gSpeed >= (phy.peeloutSpeed - cgSpd(2)) && anim.currentAnimation == "peelout"? "peelout" : "running") : "walking";
            }
            else
            {
                // braking
                setGSpeed(m_gSpeed + dt * controls.directionValueX * (m_playerRolling? phy.groundBrakeRoll: phy.groundBrake));
                if(m_gSpeed > 0 && m_playerRolling)
                {
                    setGSpeed(0);
                    setPlayerRolling(false);
                    newAnimation = "standing";
                    recalcDimensions();
                }
                if(!m_playerRolling &&m_gSpeed < -0.75*phy.groundSpeedCap && anim.currentAnimation != "braking")
                {
                    newAnimation = "braking";
                    playSfx("brake");
                }
            }
        }
        else
            if(!misc.horizontalControlLock && controls.directionValueX < 0)
            {
                // holding left

                // are we going left?
                if(m_gSpeed <= 0)
                {
                    // accelerate when applicable
                    if(!m_playerRolling &&m_gSpeed > -phy.groundSpeedCap)
                    {
                        setGSpeed( m_gSpeed + dt * controls.directionValueX * phy.groundAccel );
                        if(m_gSpeed < -phy.groundSpeedCap)m_gSpeed = -phy.groundSpeedCap;
                    }

                    setTurnedBack(true);

                    if(!m_playerRolling)
                        newAnimation = m_gSpeed <= -phy.groundSpeedCap? (m_gSpeed <= -(phy.peeloutSpeed - cgSpd(2)) && anim.currentAnimation == "peelout"? "peelout" : "running") : "walking";

                }
                else
                {
                    //braking
                    setGSpeed(m_gSpeed + dt * controls.directionValueX * (m_playerRolling? phy.groundBrakeRoll: phy.groundBrake));
                    if(m_gSpeed < 0 && m_playerRolling)
                    {
                        setGSpeed(0);
                        setPlayerRolling(false);
                        newAnimation = "standing";
                        recalcDimensions();
                    }
                    if(!m_playerRolling &&m_gSpeed > 0.75*phy.groundSpeedCap && anim.currentAnimation != "braking")
                    {
                        newAnimation = "braking";
                        playSfx("brake");
                    }
                }

                misc.timerIdle = 0;
            }
            else
            {
                //not holding any horizontal direction
                qreal fric  = (m_playerRolling? phy.groundFricRoll : phy.groundFric);

                // is speed significant or we are on a wall?
                if((qAbs(m_gSpeed) > fric * dt) || m_playerQuadMode != 0)
                {
                    // applying friction
                    if(m_gSpeed > 0)
                        setGSpeed(m_gSpeed - dt * fric);
                    else
                        setGSpeed(m_gSpeed + dt * fric);

                    if(!m_playerRolling) newAnimation = qAbs(m_gSpeed) >= phy.groundSpeedCap? "running" : "walking";

                    misc.timerIdle = 0;
                }
                else
                {
                    // stopped already
                    m_gSpeed = 0;
                    m_playerRolling = false;
                    newAnimation = "standing";
                    recalcDimensions();

                    misc.timerIdle += dt;

                    if(controls.directionValueY < -0.5)
                    {
                        setPlayerState(PS_CROUCHED);
                        newAnimation = "crouched";
                        misc.timerIdle = 0;
                    }else if(controls.directionValueY > 0.5)
                    {
                        setPlayerState(PS_LOOKINGUP);
                        newAnimation = "lookingUp";
                        misc.timerIdle = 0;
                    }

                    if(misc.timerIdle > 5)
                    {
                        newAnimation = "goingIdle";
                    }

                    if(misc.timerIdle > (9.6) )
                    {
                        newAnimation = "idle";
                    }

                }

            }

        // regardless of input, if rolling, apply rolling limit
        if(m_playerRolling && qAbs(m_gSpeed) > phy.groundSpeedCapRolling){
            setGSpeed((m_gSpeed > 0)? phy.groundSpeedCapRolling : - phy.groundSpeedCapRolling);
        }

        // adjust speeds based on m_gSpeed
        setXSpeed(m_gSpeed*qCos(m_gAngle/180*M_PI));
        setYSpeed(m_gSpeed*qSin(m_gAngle/180*M_PI));


        //if on a wall or ceiling validade speed
        //don't leave the wall if it reattached already, let it slide
        //in a vertical surface, only fall if going uphill

        if(!misc.horizontalControlLock && m_playerQuadMode != 0 && qAbs(m_gSpeed) < phy.groundCeilingMinSpeed && ((m_playerQuadMode==2) || ( qSin(m_gAngleRad) *m_gSpeed < 0 )) )
        {
            setGSpeed(0);
            setGAngle(0);
            setPlayerState(PS_AIR);
            setPlayerQuadMode(0);
            newAnimation = "falling";
            misc.horizontalControlLock = cgTime(30);
        }

        // maybe jump
        if(controls.aPressed && !misc.controlAPressedLastFrame)
        {
            if(!m_playerQuadModeVertical) _y=(_y + sens.halfHeightDifference * m_playerQuadModeSign);
            setPlayerState(PS_AIR);
            setPlayerJumping(true);
            setPlayerRolling(true);
            setPlayerQuadMode(0);
            setYSpeed(m_ySpeed - phy.jumpSpeed*qCos(m_gAngleRad));
            setXSpeed(m_xSpeed + phy.jumpSpeed*qSin(m_gAngleRad));
            setGAngle(0);
            newAnimation = "rollingM";
            anim.timeIntoAnimation = 0;
            misc.timerIdle = 0;
            playSfx("jump");
        }

        // maybe special move
        if( controls.bPressed && !misc.controlBPressedLastFrame )
        {

        }

    }

    if(m_playerState == PS_AIR)
    {
        if(!misc.controlLockHit)
        {

            if(m_playerJumping && !controls.aPressed)
            {
                if(m_ySpeed < 0 && m_ySpeed < -phy.jumpCutoff) m_ySpeed = -phy.jumpCutoff;
                setPlayerJumping(false);
            }

            if(controls.aPressed && !misc.controlAPressedLastFrame && m_playerRolling && misc.playerStateLastFrame != PS_GROUND)
            {
                emit jumpedInMidair();
            }

            if( m_playerRolling && controls.bPressed && !misc.controlBPressedLastFrame )
            {
                setXSpeed(m_xSpeed * 0.25);
                setYSpeed(m_ySpeed * 0.25);
                setPlayerJumping(false);
                setPlayerRolling(false);
                newAnimation = "falling";
                misc.controlBPressedLastFrame = true; // avoid going into next block
            }

            if( anim.currentAnimation == "spring" && m_ySpeed > 0 ) newAnimation = "falling";

            qreal xSpeedPrev = m_xSpeed;
            if(!misc.horizontalControlLock) setXSpeed( m_xSpeed + dt * controls.directionValueX * phy.airAccel);

            // if we were not past max speed already, and we did after increasing, we need to cap it
            if(qAbs(xSpeedPrev) < phy.airSpeedCap)
            {
                if(qAbs(m_xSpeed) > phy.airSpeedCap)
                {
                    setXSpeed(phy.airSpeedCap * (m_xSpeed > 0? 1.0 : -1.0));
                }
            } else {
                // but if we were above speed cap already, we shouldn't be able to increase it
                if(qAbs(m_xSpeed) > qAbs(xSpeedPrev))
                {
                    setXSpeed(xSpeedPrev);
                }
            }

            //now weird air drag
            //from SPG
            if (m_ySpeed < 0 && m_ySpeed > cgSpd(-4))
            {
                if(qAbs(m_xSpeed) >= cgSpd(0.125))
                {
                    setXSpeed(m_xSpeed * qPow(0.96875, dt / cgTime(1)));
                }
            }

            //and finally enable to flip
            if(m_xSpeed != 0.0) setTurnedBack(m_xSpeed < 0);

        }

        setYSpeed(m_ySpeed + dt * (anim.currentAnimation == "hurt"? cgAcc(0.1875): phy.gravity));
        if(m_ySpeed > phy.ySpeedCap)
            setYSpeed(phy.ySpeedCap);
    }




    if(m_playerState == PS_CROUCHED)
    {
        if(controls.aPressed && !misc.controlAPressedLastFrame)
        {
            setPlayerSpindash( m_playerSpindash + 2.0);
            newAnimation = "spindash";
            if(m_playerSpindash > 8) setPlayerSpindash(8);
            emit playSfx("speed", 1 + (m_playerSpindash - 2)/4);
        }

        if(m_playerSpindash > 0)
        {
            //FROM SPG
            setPlayerSpindash(m_playerSpindash - ( ( m_playerSpindash / 0.125 ) / 256 ) * dt / cgTime(1));
            if(m_playerSpindash < 0) setPlayerSpindash(0);

            // TODO ANIM SPEED
            //sprite.frameDuration = 30 - playerSpindash;
        }


        if( controls.directionValueY >= -0.1 )
        {
            m_playerState = PS_GROUND;
            if(m_playerSpindash >= 0)
            {
                //spindashing
                //from SPG
                setGSpeed(m_xSpeed = (m_turnedBack? -1.0: 1.0) * (cgSpd(8 + qRound(m_playerSpindash)/2))); // round instead of floor, better

                m_playerRolling = true;
                emit playSfx("peelout");
                newAnimation = "rollingM";

                setPlayerSpindash(-1);
            }
            else
            {
                newAnimation = "standing";
            }
            misc.timerIdle = 0;

            recalcDimensions();
        }
    }

    if(m_playerState == PS_LOOKINGUP)
    {
        if(anim.currentAnimation != "peelout" && controls.aPressed && !misc.controlAPressedLastFrame)
        {
            newAnimation = "running";
            emit playSfx("peeloutCharge");
        }

        if(anim.currentAnimation == "running" && anim.timeIntoAnimation >= 0.5)
        {
            newAnimation = "peelout";
            //emit playSfx("ready");
        }

        if( controls.directionValueY < 0.1 )
        {
            setPlayerState(PS_GROUND);

            if ( anim.currentAnimation == "peelout" )
            {
                setGSpeed((m_turnedBack? -1.0: 1.0) * phy.peeloutSpeed);
                setXSpeed(gSpeed());
                emit playSfx("peelout");
                newAnimation = "peelout";
            }
            else
            {
                newAnimation = "standing";
            }

            misc.timerIdle = 0;
        }
    }

    // see if rolling must start after possible landing or in phy.ground even
    if( m_playerState == PS_GROUND && !m_playerRolling )
    {
        // not stopped and has speed, we can roll
        if(qAbs(m_gSpeed) > phy.groundRollMinSpeed && controls.directionValueY < -0.5)
        {
            m_playerRolling = true;
            newAnimation = "rollingM";
            playSfx("speed");
            recalcDimensions();
        }
    }

    //
    // COLLISION ROUTINES
    //

    dwFieldPhysicsWorld * physicsWorld = dwFieldPhysicsWorld::singleton();
    QVector4D sensorAResultComplete;
    QVector4D sensorBResultComplete;
    qreal sensorAResult;
    qreal sensorBResult;
    qreal sensorMResult;
    qreal sensorAHResult;
    qreal sensorBHResult;
    QVector4D sensorAHResultComplete;
    QVector4D sensorBHResultComplete;
    qreal sensorCResult;
    qreal sensorDResult;

    // BASE, LAYER A
    int categories = 0x04 | ( (m_playerState == PS_GROUND) || m_ySpeed >= 0? (0x01 | 0x10) : 0x00);
    int hCategories = 0x04;

    // LAYER B
    if( m_playerInLayerB )
    {
        categories *= 2;
        hCategories *= 2;
    }

    // CC_OBJ_NOT_ROLLING
    if(!m_playerRolling)
    {
        categories |= 0x40;
        hCategories |= 0x40;
    }

    // CC_WATER_EDGE
    categories |= 0x100;

    qreal horizontalSensorLengthNow = sens.horizontalSensorLength;
    switch(m_playerQuadMode)
    {
    case 0:
        sensorAResultComplete = physicsWorld->raycast(_x-sens.sensorHSpan, _y, _x-sens.sensorHSpan, _y+sens.verticalSensorLength, categories);
        sensorBResultComplete = physicsWorld->raycast(_x+sens.sensorHSpan, _y, _x+sens.sensorHSpan, _y+sens.verticalSensorLength, categories);
        sensorMResult = physicsWorld->raycastClosestDistance(_x, _y, _x, _y+sens.verticalSensorLength, categories);
        sensorCResult = physicsWorld->raycastClosestDistance(_x-sens.sensorHSpan, _y, _x-sens.sensorHSpan, _y-m_playerHalfHeight, hCategories);
        sensorDResult = physicsWorld->raycastClosestDistance(_x+sens.sensorHSpan, _y, _x+sens.sensorHSpan, _y-m_playerHalfHeight, hCategories);
        break;

    case 1:
        sensorAResultComplete = physicsWorld->raycast(_x, _y+sens.sensorHSpan, _x+sens.verticalSensorLength, _y+sens.sensorHSpan, categories);
        sensorBResultComplete = physicsWorld->raycast(_x, _y-sens.sensorHSpan, _x+sens.verticalSensorLength, _y-sens.sensorHSpan, categories);
        break;

    case 2:
        sensorAResultComplete = physicsWorld->raycast(_x+sens.sensorHSpan, _y, _x+sens.sensorHSpan, _y-sens.verticalSensorLength, categories);
        sensorBResultComplete = physicsWorld->raycast(_x-sens.sensorHSpan, _y, _x-sens.sensorHSpan, _y-sens.verticalSensorLength, categories);
        break;

    case 3:
        sensorAResultComplete = physicsWorld->raycast(_x, _y-sens.sensorHSpan, _x-sens.verticalSensorLength, _y-sens.sensorHSpan, categories);
        sensorBResultComplete = physicsWorld->raycast(_x, _y+sens.sensorHSpan, _x-sens.verticalSensorLength, _y+sens.sensorHSpan, categories);
        break;
    }
    sensorAResult = sensorAResultComplete.x();
    sensorBResult = sensorBResultComplete.x();


    qreal angle = 0;
    if((sensorAResult > 0) || (sensorBResult > 0))
    {
        if((sensorAResult > 0) && (sensorBResult > 0))
        {
            // use highest, original
            angle = sensorAResult < sensorBResult? qAtan2(sensorAResultComplete.y(), sensorAResultComplete.z()) : qAtan2(sensorBResultComplete.y(), sensorBResultComplete.z());
        }
        else if(sensorAResult > 0)
            angle = qAtan2(sensorAResultComplete.y(), sensorAResultComplete.z());
        else
            angle = qAtan2(sensorBResultComplete.y(), sensorBResultComplete.z());
    }

    if(m_playerQuadMode == 0 && (sensorCResult > 0 || sensorDResult > 0) )
    {
        // we hit the ceiling
        if(m_ySpeed < 0)setYSpeed(0);
        qreal newY = _y;

        if((sensorCResult > 0) && (sensorDResult > 0))
            newY += (sensorCResult < sensorDResult)? (1.0 - sensorCResult)*m_playerHalfHeight : (1.0 - sensorCResult)*m_playerHalfHeight;
        else if(sensorCResult > 0)
            newY += (1.0 - sensorCResult)*m_playerHalfHeight;
        else
            newY += (1.0 - sensorDResult)*m_playerHalfHeight;

        newY += 0.01; // for not sticking

        _y=(newY);
    }

    if(m_playerState != PS_AIR )
    {
        if((sensorAResult < 0) && (sensorBResult < 0))
        {
            setPlayerState(PS_AIR);
            setPlayerQuadMode(0);
            setGAngle(0);

            if(m_playerRolling) newAnimation = "rollingM";
            else newAnimation = "falling";
        }else
        {
            putOnGround(false, false, sensorAResult, sensorBResult, angle);
        }
    }else
    { // was on air
        if( ( ! (sensorAResult < 0 && sensorBResult < 0) ) && m_ySpeed > 0 ) // found something and can land
        {
            bool willRoll = controls.directionValueY < -0.5;

            if(putOnGround(m_playerQuadMode == 0, willRoll, sensorAResult, sensorBResult, angle))
            {

                setPlayerState(PS_GROUND);

                //setm_gSpeed
                if(m_gAngle > 337.5 || m_gAngle < 22.5)
                {
                    setGSpeed(m_xSpeed);
                }else if(m_gAngle > 329 || m_gAngle < 31)
                {
                    if(qAbs(m_xSpeed) > qAbs(m_ySpeed))
                        setGSpeed(m_xSpeed);
                    else
                        setGSpeed(m_ySpeed*0.5*(qCos(m_gAngleRad)> 0? -1 : 1)*(m_gAngle < 180? -1 : 1));
                }else //if(gAngle > 192 || gAngle < 63)
                {
                    setGSpeed(m_ySpeed*(qCos(m_gAngleRad)> 0? -1 : 1)*(m_gAngle < 180? -1 : 1));
                }

                if(m_gSpeed < 0) setTurnedBack(true);
                if(m_gSpeed > 0) setTurnedBack(false);

                if(misc.controlLockHit)
                {
                    emit playInvicibilityAnimation();
                    misc.controlLockHit = false;
                }

                // not stopped and has speed, we can roll
                if(willRoll && qAbs(m_gSpeed) > phy.groundRollMinSpeed ) // we were put on phy.ground
                {
                    setPlayerRolling(true);
                    newAnimation = "rollingM";
                    emit playSfx("speed");
                }
                else
                {
                    if(m_playerRolling) _y=( _y - sens.halfHeightDifference);
                    m_playerRolling = false;
                    newAnimation = qAbs(m_gSpeed)>0? "walking" : "standing";
                    emit playSfx("land");
                }

                recalcDimensions();
            }
        }
    }

    //check if need to switch quadrant
    if(m_playerState == PS_GROUND && ! m_playerQuadModeLocked)
    {
        int prevMode = m_playerQuadMode;
        int newMode = 0;
        if(225 < m_gAngle && m_gAngle <= 314 /*originally 315*/ ) newMode = 1;
        else if(135 < m_gAngle && m_gAngle <= 225) newMode = 2;
        else if(46 /*originally 45*/ < m_gAngle && m_gAngle <= 135) newMode = 3;
        else newMode = 0;

        if( (prevMode != newMode) && misc.playerStateLastFrame == PS_GROUND )
        {
            // avoid flickering quad modes
            if(!(newMode == misc.playerQuadModeSecondToLastFrame) )
                setPlayerQuadMode(newMode);

            if(m_gAngleDifference != 0)
            {
                bool increasingQuadrants = false;

                if(newMode == 0 && prevMode == 3) increasingQuadrants = true;
                else if(newMode == 3 && prevMode == 0) increasingQuadrants = false;
                else increasingQuadrants = newMode > prevMode;

                bool increasingAngle = m_gAngleDifference > 0;

            }

        }


        misc.playerQuadModeSecondToLastFrame = prevMode;
    }

    //check if need to play balancing animation
    if(m_playerState == PS_GROUND && m_gSpeed == 0 && sensorMResult < 0)
    {
        if( sensorAResult > 0 )
        {

            if( m_turnedBack )
            {
                newAnimation = "balancingF";
            }
            else
            {
                newAnimation = "balancingB";
            }
        }else
        {
            if( m_turnedBack )
            {
                newAnimation = "balancingB";
            }
            else
            {
                newAnimation = "balancingF";
            }
        }
    }


    // add speeds
    _x=( _x + dt * m_xSpeed );
    _y=( _y + dt * m_ySpeed );


    // PUSH BACK FROM WALLS - raycast
    switch(m_playerQuadMode)
    {
    case 0:
        sensorAHResultComplete = physicsWorld->raycast(_x, _y+sens.horizontalSensorYOffset, _x-horizontalSensorLengthNow, _y+sens.horizontalSensorYOffset, hCategories);
        sensorBHResultComplete = physicsWorld->raycast(_x, _y+sens.horizontalSensorYOffset, _x+horizontalSensorLengthNow, _y+sens.horizontalSensorYOffset, hCategories);
        break;

    case 1:
        sensorAHResultComplete = physicsWorld->raycast(_x + sens.horizontalSensorYOffset, _y, _x+sens.horizontalSensorYOffset, _y+horizontalSensorLengthNow, hCategories);
        sensorBHResultComplete = physicsWorld->raycast(_x + sens.horizontalSensorYOffset, _y, _x+sens.horizontalSensorYOffset, _y-horizontalSensorLengthNow, hCategories);
        break;

    case 2:
        sensorAHResultComplete = physicsWorld->raycast(_x, _y-sens.horizontalSensorYOffset, _x+horizontalSensorLengthNow, _y-sens.horizontalSensorYOffset, hCategories);
        sensorBHResultComplete = physicsWorld->raycast(_x, _y-sens.horizontalSensorYOffset, _x-horizontalSensorLengthNow, _y-sens.horizontalSensorYOffset, hCategories);
        break;

    case 3:
        sensorAHResultComplete = physicsWorld->raycast(_x - sens.horizontalSensorYOffset, _y, _x-sens.horizontalSensorYOffset, _y-horizontalSensorLengthNow, hCategories);
        sensorBHResultComplete = physicsWorld->raycast(_x - sens.horizontalSensorYOffset, _y, _x-sens.horizontalSensorYOffset, _y+horizontalSensorLengthNow, hCategories);
        break;
    }
    sensorAHResult = sensorAHResultComplete.x();
    sensorBHResult = sensorBHResultComplete.x();



    //pushback
    if(sensorAHResult > 0)
    {
        if(!m_playerQuadModeVertical)
        {
            _x=( _x + (1.0 - sensorAHResult)*sens.horizontalSensorLength*m_playerQuadModeSign);
            if(m_gSpeed < 0) setGSpeed(0);
            if(m_xSpeed < 0 && m_playerQuadMode == 0)
            {
                setXSpeed(0);
                if(m_playerState == PS_GROUND)
                {
                    setGSpeed(0);
                    setPlayerRolling(false);

                    if(controls.directionValueX < 0.0) newAnimation = "pushing";
                    else newAnimation = "standing";
                }
            }
        }else
        {
            _y=( _y - (1.0 - sensorAHResult)*sens.horizontalSensorLength*m_playerQuadModeSign);
            if(m_gSpeed < 0) setGSpeed(0);
        }
    }
    if(sensorBHResult > 0)
    {
        if(!m_playerQuadModeVertical)
        {
            _x=( _x - (1.0 - sensorBHResult)*sens.horizontalSensorLength*m_playerQuadModeSign);
            if(m_gSpeed > 0) setGSpeed(0);
            if(m_xSpeed > 0 && m_playerQuadMode == 0)
            {
                setXSpeed(0);
                if(m_playerState == PS_GROUND)
                {
                    setGSpeed(0);
                    setPlayerRolling(false);

                    if(controls.directionValueX > 0.0) newAnimation = "pushing";
                    else newAnimation = "standing";
                }
            }
        }else
        {
            _y=( _y - (1.0 - sensorBHResult)*sens.horizontalSensorLength*m_playerQuadModeSign);
            if(m_gSpeed > 0) setGSpeed(0);
        }

    }


    //apply new animation
    anim.timeIntoAnimation += dt;

    //update misc vars
    setRingCollectLock(qMax(0.0, m_ringCollectLock - dt));
    misc.controlAPressedLastFrame = controls.aPressed;
    misc.controlBPressedLastFrame = controls.bPressed;
    misc.horizontalControlLock = qMax(0.0, misc.horizontalControlLock - dt);
    misc.playerStateLastFrame = m_playerState;

    return newAnimation;
}

bool dwPlayerBase::putOnGround(bool onlyIfLower, bool willRoll, qreal sensorAResult, qreal sensorBResult, qreal angle, bool dontSetAngles)
{
    if(m_playerQuadModeVertical)
    {
        qreal newX = _x;
        newX -= (1-qMin(sensorAResult>0? sensorAResult : 1.0, sensorBResult>0? sensorBResult : 1.0)) * sens.verticalSensorLength * m_playerQuadModeSign;
        newX += (sens.verticalSensorLength - m_playerHalfHeight) * m_playerQuadModeSign;
        if( (_x-newX)*(m_playerQuadModeSign) > 0 ) _x=(newX);
    }
    else
    {
        qreal newY = _y;
        newY -= (1-qMin(sensorAResult>0? sensorAResult : 1.0, sensorBResult>0? sensorBResult : 1.0)) * sens.verticalSensorLength * m_playerQuadModeSign;
        newY += (sens.verticalSensorLength - m_playerHalfHeight) * m_playerQuadModeSign;
        if(onlyIfLower) //never true for ceiling
        {
            if(willRoll && !m_playerRolling) newY -= sens.halfHeightDifference;
            if(newY >= _y) return false;
        }
        _y=(newY);
    }

    if(!dontSetAngles)
    {
        if(misc.playerStateLastFrame == PS_AIR) setGAngleDifference(0);
        else if(angle != m_gAngle)
        {
            qreal angleDifference = ( angle - m_gAngle);
            if(angleDifference>180) angleDifference -= 360;
            if(angleDifference < -180) angleDifference += 360;
            setGAngleDifference(angleDifference);
        }

        setGAngle(180 - angle*180/M_PI);
    }

    return true;
}

void dwPlayerBase::recalcDimensions()
{
    setPlayerHalfHeight( cgDim( m_playerRolling || m_playerState == PS_CROUCHED? 15 : 20) );
    //setPlayerHalfWidth( cgDim(10) ); never changes

    sens.verticalSensorLength = cgDim(15.75) + m_playerHalfHeight;
    sens.sensorHSpan = cgDim( m_playerRolling? 7 : 9 );

}

void dwPlayerBase::setAnimation(QString animationName)
{
    anim.currentAnimation = animationName;
    anim.timeIntoAnimation = 0.0;
    emit animationChanged(animationName);
}

void dwPlayerBase::getHit(int xc, int yc)
{
    emit gotHit();

    setRingCollectLock(cgTime(64));
    setPlayerRolling(false);
    setPlayerState(PS_AIR);
    setPlayerQuadMode(0);
    misc.controlLockHit = true;
    setY( y() - cgDim(8));
    setYSpeed(cgSpd(-4));
    setXSpeed(cgSpd(2 * (xc? (_x - xc > 0? 1 : -1) : -1)));
    setAnimation("hurt");
    setPlayerInvincible(true);
}

void dwPlayerBase::resetControlLocks()
{
    misc.horizontalControlLock = 0;
    if(misc.controlLockHit)
    {
        misc.controlLockHit = false;
        emit playInvicibilityAnimation();
    }

}

void dwPlayerBase::setHorizontalControlLock(qreal time)
{
    misc.horizontalControlLock = time;

}

void dwPlayerBase::recalcPhysicsVariables(bool water)
{
    phy.gravity = cgAcc(0.21875);
    phy.ySpeedCap = cgSpd(16);
    phy.groundSpeedCap = cgSpd(6);
    phy.groundSpeedCapRolling = cgSpd(16);
    phy.airSpeedCap = phy.groundSpeedCap;

    phy.groundAccel = cgAcc(0.046875);
    phy.groundFric = phy.groundAccel;
    phy.groundFricRoll = phy.groundFric / 2;
    phy.groundBrake = cgAcc(0.5);
    phy.groundBrakeRoll = cgAcc(0.125) + phy.groundFricRoll; // genesis applies friction regardless
    phy.groundRollMinSpeed = cgSpd(1.03125); // s3&k value
    phy.groundCeilingMinSpeed = cgSpd(2.5);
    phy.groundSlopeFactor = cgAcc(0.125);
    phy.groundSlopeFactorRollUp = cgAcc(0.078125);
    phy.groundSlopeFactorRollDown = cgAcc(0.3125);
    phy.peeloutSpeed = cgSpd(12);
    phy.airAccel = 2 * phy.groundAccel;
    phy.jumpSpeed = cgSpd(6.5);
    phy.jumpCutoff = cgSpd(4);

    if(water)
    {
        phy.groundAccel /= 2;
        phy.groundBrake /= 2;
        phy.groundFric /= 2;
        phy.groundFricRoll = cgAcc(0.01171875);
        phy.groundSpeedCap = cgSpd(3);
        phy.airAccel /= 2;
        phy.gravity = cgAcc(0.0625);
        phy.jumpSpeed = cgSpd(3.5);
        phy.jumpCutoff = cgSpd(2);

    }
}
