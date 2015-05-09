import QtQuick 2.3
import QtQuick.Particles 2.0
import dw 1.0

ParticleSystem {
    id: walkDust
    clip: false

    z: field.objSfxZ
    property bool enabled: true
    property alias color: imgParticle.color

    ImageParticle
    {
        id: imgParticle
        source: resBase + "field/fx/smoke-16.png"
        rotationVariation: 360
        opacity: 0.5
        color: "#DDD"
    }

    Emitter
    {
        id: emitter
        size: 6
        sizeVariation: 2
        x: player.x
        y: player.y + player.playerHalfHeight
        enabled: walkDust.enabled && (player.playerState === DWPlayerBase.PS_GROUND) && (player.playerQuadMode === 0) && (player.gSpeed !== 0) && (!player.inWater)
        endSize: 48
        lifeSpan: 500
        emitRate: Math.abs(player.gSpeed / 10)
        velocity: AngleDirection
        {
            angle: -90 - player.gAngle
            magnitude: 20
        }
    }
}

