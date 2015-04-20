import QtQuick 2.0
import ".." 1.0
import "../obj" 1.0

PLevelChunk {

    width: 4096
    height: 4096


    PLevelChunkGRect {
        id: maxBoundaryX
        x: 7936 + 512
        y: -2048 + 512
        width: 128
        height: 4096
    }

    Image {
        x: 192 + 512
        y: 48 + 512
        source: "../obj/obj/movingPlatform.png"
    }

    Image {
        x:  512
        y: 48 + 512
        source: "../obj/obj/movingPlatform.png"
    }

    Image {
        x:  512 - 192
        y: 48 + 512
        source: "../obj/obj/movingPlatform.png"
    }


    PLevelChunkVisual {
        id: image44
        x: 1536
        y: 528
        source: "../mm/tileset/7.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect11
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image46
        x: 3072
        y: 528
        layerB: true
        source: "../mm/tileset/2.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect16
            x: 0
            y: 192
            width: 256
            height: 64
        }

        Image {
            id: image103
            x: 115
            y: 156
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image104
            x: 83
            y: 156
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image106
            x: 147
            y: 156
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image47
        x: 1792
        y: 528
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image49
        x: 2048
        y: 528
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect18
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image50
        x: 1536
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect19
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image57
        x: 1792
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect21
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image60
        x: 2304
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect22
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual3
        x: 2304
        y: 528
        layerB: true
        source: "../mm/tileset/14.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect23
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect24
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect25
            x: 190
            y: 192
            width: 66
            height: 16
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual4
        x: 2560
        y: 528
        source: "../mm/tileset/37.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect30
            x: 0
            y: 128
            width: 256
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect31
            x: 64
            y: 96
            width: 128
            height: 32
            visible: true
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect32
            x: 64
            y: 32
            width: 64
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect33
            x: 192
            y: 0
            width: 64
            height: 128
        }

        Image {
            id: image65
            x: 144
            y: 80
            source: "../obj/obj/spring.png"
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual5
        x: 2304
        y: 272
        source: "../mm/tileset/11.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect26
            x: 0
            y: 0
            width: 256
            height: 97
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual6
        x: 2560
        y: 16
        layerB: true
        source: "../mm/tileset/38.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect34
            x: 64
            y: 32
            width: 64
            height: 225

            PLevelChunkGRect {
                id: pLevelChunkGRect37
                x: 128
                y: 0
                width: 64
                height: 224
            }

            PLevelChunkGRect {
                id: pLevelChunkGRect39
                x: 160
                y: -32
                width: 32
                height: 32
            }
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect36
            x: 96
            y: 0
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp1
            x: 64
            y: 0
            width: 32
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp2
            x: 192
            y: 0
            width: 32
            height: 33
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual7
        x: 2048
        y: 272
        visualBg: true
        layerB: true
        source: "../mm/tileset/47.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect28
            x: 0
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect29
            x: 160
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect27
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image85
            x: 224
            y: 63
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image87
            x: 64
            y: 192
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image88
            x: 0
            y: 187
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image89
            x: 32
            y: 187
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image61
        x: 2048
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image62
        x: 2304
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image63
        x: 2560
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image64
        x: 2816
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual8
        x: 2304
        y: -240
        source: "../mm/tileset/69.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect40
            x: 0
            y: 32
            width: 256
            height: 224
        }

        Image {
            id: image280
            x: 160
            y: 0
            source: "../obj/obj/monitor-rings.png"
        }
    }

    PLevelChunkVisual {
        id: image66
        x: 2048
        y: -240
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect41
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image67
        x: 2048
        y: -496
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect42
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image68
        x: 1792
        y: -240
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect43
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image69
        x: 1792
        y: -496
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect44
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image70
        x: 2048
        y: -752
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect45
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual9
        x: 2304
        y: -752
        layerB: true
        source: "../mm/tileset/9.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect46
            x: 0
            y: 0
            width: 256
            height: 192
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual10
        x: 1792
        y: 272
        visualBg: true
        source: "../mm/tileset/47.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect47
            x: 0
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect48
            x: 160
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect49
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image83
            x: 112
            y: 208
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image84
            x: 0
            y: 63
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image90
            x: 224
            y: 188
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image127
            x: 232
            y: 63
            source: "../obj/obj/badnik.png"
        }
    }

    PLevelChunkVisual {
        id: image71
        x: 2048
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect50
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image53
        x: 3072
        y: -240
        source: "../mm/tileset/2.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect51
            x: 0
            y: 192
            width: 256
            height: 64
        }

        Image {
            id: image78
            x: 53
            y: 162
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image80
            x: 87
            y: 162
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image81
            x: 120
            y: 162
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual11
        x: 2816
        y: 16
        source: "../mm/tileset/69.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect52
            x: 0
            y: 32
            width: 256
            height: 224
        }

        Image {
            id: image74
            x: 0
            y: 0
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image76
            x: 64
            y: 0
            source: "../obj/obj/spikes.png"
        }
    }

    PLevelChunkVisual {
        id: image72
        x: 3072
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect53
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    Image {
        id: image54
        x: 3040
        y: 16
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image73
        x: 3008
        y: 16
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image75
        x: 2848
        y: 16
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image77
        x: 2932
        y: 0
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image79
        x: 2967
        y: 0
        source: "../obj/obj/ring.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual13
        x: 3072
        y: 272
        source: "../mm/tileset/11.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect55
            x: 0
            y: 0
            width: 256
            height: 97
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual12
        x: 3328
        y: -240
        source: "../mm/tileset/95.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect59
            x: 0
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect60
            x: 192
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect58
            x: 64
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect61
            x: 161
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp3
            x: 161
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp4
            x: 64
            y: 128
            width: 32
            height: 32
            reversed: true
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual14
        x: 3328
        y: 16
        source: "../mm/tileset/100.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect65
            x: 0
            y: 0
            width: 96
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect66
            x: 192
            y: 128
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect64
            x: 160
            y: 0
            width: 96
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect67
            x: 0
            y: 128
            width: 64
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp5
            x: 64
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp6
            x: 160
            y: 128
            width: 32
            height: 32
            reversed: true
        }

        Image {
            id: image282
            x: 226
            y: 224
            source: "../obj/obj/monitor-rings.png"
        }
    }

    PLevelChunkVisual {
        id: image94
        x: 3072
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image95
        x: 3328
        y: 784
        source: "../mm/tileset/22.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect62
            x: 0
            y: 0
            width: 48
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect63
            x: 48
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc14
            x: 112
            y: 128
            quadrant: 2
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc15
            x: 176
            y: 128
            quadrant: 3
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect68
            x: 240
            y: 128
            width: 16
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect69
            x: 96
            y: 0
            width: 160
            height: 64
        }

        Image {
            id: image99
            x: 64
            y: 13
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image100
            x: 64
            y: -15
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image101
            x: 64
            y: 41
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image96
        x: 3072
        y: 1040
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image97
        x: 3328
        y: 1040
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image98
        x: 3328
        y: 528
        source: "../mm/tileset/27.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect57
            x: 96
            y: 0
            width: 160
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect79
            x: 0
            y: 240
            width: 48
            height: 16
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp7
            x: 0
            y: 193
            width: 48
            height: 48
            reversed: true
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual15
        x: 1536
        y: 272
        visualBg: true
        source: "../mm/tileset/48.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect70
            x: 0
            y: 0
            width: 256
            height: 97
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect90
            x: 64
            y: 224
            width: 64
            height: 32
        }

Image {
    id: image55
    x: 224
    y: 224
    source: "../obj/obj/spikes.png"
}



    }

    PLevelChunkVisual {
        id: pLevelChunkVisual16
        x: 3328
        y: 272
        source: "../mm/tileset/91.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect71
            x: 160
            y: 160
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect72
            x: 224
            y: 0
            width: 32
            height: 160
        }

        Image {
            id: image156
            x: 176
            y: 144
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image158
            x: 112
            y: 240
            source: "../obj/obj/spring-y.png"
        }
    }

    PLevelChunkVisual {
        id: image102
        x: 3584
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect73
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image105
        x: 3584
        y: 272
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect74
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image82
        x: 3584
        y: -240
        source: "../mm/tileset/3.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect75
            x: 0
            y: 160
            width: 256
            height: 96
        }

        Image {
            id: image107
            x: 85
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image108
            x: 149
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image109
            x: 117
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image86
            x: 0
            y: 128
            source: "../obj/obj/spikes.png"
        }

        PLevelChunkGTop {
            id: pLevelChunkGTop2
            x: 32
            y: 112
            width: 32
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual17
        x: 2560
        y: -752
        source: "../mm/tileset/9.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect76
            x: 0
            y: 0
            width: 256
            height: 192
        }
    }

    PLevelChunkVisual {
        id: image110
        x: 2560
        y: -1008
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect77
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image111
        x: 3584
        y: 784
        source: "../mm/tileset/23.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect78
            x: 0
            y: 128
            width: 160
            height: 128
        }

        Image {
            id: image112
            x: 8
            y: -23
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image113
            x: 44
            y: 96
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp8
            x: 160
            y: 128
            width: 32
            height: 32
            reversed: true
        }

        Image {
            id: image116
            x: 72
            y: 96
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image117
            x: 98
            y: 96
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect35
            x: 160
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect38
            x: 0
            y: 32
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect54
            x: 0
            y: 0
            width: 32
            height: 32
        }
    }

    PLevelChunkVisual {
        id: image115
        x: 3584
        y: 560
        source: "../mm/tileset/142.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect56
            x: 0
            y: 64
            width: 32
            height: 32
        }

        Image {
            id: image118
            x: 8
            y: 32
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image120
            x: 168
            y: 64
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect80
            x: 64
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect81
            x: 96
            y: 32
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect82
            x: 160
            y: 96
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect83
            x: 224
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect84
            x: 224
            y: 64
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect85
            x: 192
            y: 192
            width: 32
            height: 32
        }

        Image {
            id: image119
            x: 224
            y: 96
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image121
            x: 64
            y: 96
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image122
            x: 104
            y: 0
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image123
            x: 232
            y: 32
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image124
            x: 200
            y: 163
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image125
        x: 3840
        y: -240
        source: "../mm/tileset/199.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect86
            x: 64
            y: 191
            width: 64
            height: 65
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect87
            x: 0
            y: 160
            width: 64
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect88
            x: 128
            y: 224
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect89
            x: 80
            y: 48
            width: 160
            height: 32
        }

        Image {
            id: image149
            x: 145
            y: 32
            source: "../obj/obj/spring.png"
        }
    }

    PLevelChunkVisual {
        id: image130
        x: 3584
        y: 1040
        source: "../mm/tileset/13.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect96
            x: 0
            y: 0
            width: 128
            height: 256
        }

        Image {
            id: image299
            x: 183
            y: 141
            source: "../obj/obj/bumper.png"
        }

        Image {
            id: image306
            x: 189
            y: 42
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image131
        x: 3072
        y: 1296
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image132
        x: 3328
        y: 1295
        layerB: true
        source: "../mm/tileset/205.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect91
            x: 0
            y: 160
            width: 256
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect92
            x: 0
            y: 0
            width: 256
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect93
            x: 0
            y: 32
            width: 32
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect94
            x: 224
            y: 112
            width: 32
            height: 48
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect95
            x: 224
            y: 32
            width: 32
            height: 32
        }

        Image {
            id: image146
            x: 144
            y: 128
            source: "../obj/obj/badnik.png"
        }

        Image {
            id: image283
            x: 38
            y: 128
            source: "../obj/obj/monitor-fshield.png"
        }

        PLevelChunkVisual {
            id: pLevelChunkVisual2
            x: 0
            y: 0
            width: 256
            height: 256
            source: "../mm/tileset/45-fg.png"
        }
    }

    PLevelChunkVisual {
        id: image133
        x: 3584
        y: 1296
        layerB: true
        source: "../mm/tileset/178.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect97
            x: 0
            y: 192
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect98
            x: 192
            y: 159
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp9
            x: 64
            y: 159
            width: 128
            height: 33
        }

        Image {
            id: image114
            x: 0
            y: 160
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image186
            x: 32
            y: 160
            source: "../obj/obj/spikes.png"
        }
    }

    PLevelChunkVisual {
        id: image134
        x: 3840
        y: 1296
        layerB: true
        source: "../mm/tileset/166.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect99
            x: 0
            y: 160
            width: 256
            height: 96
        }
    }

    PLevelChunkVisual {
        id: image135
        x: 3072
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image136
        x: 3328
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image137
        x: 3584
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image138
        x: 3840
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image128
        x: 3840
        y: 16
        PLevelChunkGRect {
            id: pLevelChunkGRect111
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/7.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual20
        x: 3328
        y: -1008
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect117
            x: 0
            y: 0
            width: 256
            height: 192
        }
        source: "../mm/tileset/75.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual21
        x: 2817
        y: -1008
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect118
            x: 0
            y: 0
            width: 256
            height: 192
        }
        source: "../mm/tileset/9.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual22
        x: 3073
        y: -1008
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect119
            x: 0
            y: 0
            width: 256
            height: 192
        }
        source: "../mm/tileset/9.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual23
        x: 3584
        y: -1008
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect120
            x: 0
            y: 0
            width: 256
            height: 192
        }
        source: "../mm/tileset/9.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual25
        x: 3840
        y: -1008
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect122
            x: 0
            y: 0
            width: 256
            height: 97
        }
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: image151
        x: 3904
        y: 528
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect123
            x: 0
            y: 64
            width: 32
            height: 32
        }

        Image {
            id: image152
            x: 8
            y: 32
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image153
            x: 168
            y: 64
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect124
            x: 64
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect125
            x: 96
            y: 32
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect126
            x: 160
            y: 96
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect127
            x: 224
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect128
            x: 224
            y: 64
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect129
            x: 192
            y: 192
            width: 32
            height: 32
        }

        Image {
            id: image154
            x: 224
            y: 96
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image155
            x: 192
            y: 160
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image157
            x: 232
            y: 32
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/142.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual28
        x: 3840
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect135
            x: 0
            y: 0
            width: 256
            height: 97
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect136
            x: 64
            y: 224
            width: 64
            height: 32
        }

        Image {
            id: image166
            x: 104
            y: 189
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image167
            x: 72
            y: 189
            source: "../obj/obj/ring.png"
        }
        layerB: true
        visualBg: true
        source: "../mm/tileset/48.png"
    }

    Image {
        id: image150
        x: 2656
        y: 0
        source: "../obj/obj/spring-y.png"
    }

    PLevelChunk {
        id: pLevelChunk1
        x: 3992
        y: -400
        width: 16
        height: 160

        Image {
            id: image203
            x: 0
            y: 16
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image202
            x: 0
            y: 144
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image204
            x: 0
            y: 112
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image205
            x: 0
            y: 80
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image206
            x: 0
            y: 48
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunk {
        id: pLevelChunk2
        x: 3448
        y: -62
        width: 16
        height: 160
        Image {
            id: image207
            x: 0
            y: 16
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image208
            x: 0
            y: 144
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image209
            x: 0
            y: 112
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image210
            x: 0
            y: 80
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image211
            x: 0
            y: 48
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image228
        x: 2816
        y: 528
        PLevelChunkGRect {
            id: pLevelChunkGRect168
            x: 0
            y: 160
            width: 256
            height: 96
        }

        Image {
            id: image233
            x: 85
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image234
            x: 149
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image235
            x: 117
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image236
            x: 0
            y: 128
            source: "../obj/obj/spikes.png"
        }

        PLevelChunkGTop {
            id: pLevelChunkGTop4
            x: 32
            y: 112
            width: 32
        }
        layerB: true
        source: "../mm/tileset/3.png"
    }

    Image {
        id: image296
        x: 3840
        y: 1076
        source: "../obj/obj/bumper.png"
    }

    Image {
        id: image297
        x: 3980
        y: 1076
        source: "../obj/obj/bumper.png"
    }

    Image {
        id: image298
        x: 3912
        y: 1181
        source: "../obj/obj/bumper.png"
    }

    Image {
        id: image301
        x: 4051
        y: 1181
        source: "../obj/obj/bumper.png"
    }

    Image {
        id: image302
        x: 3912
        y: 978
        source: "../obj/obj/bumper.png"
    }

    Image {
        id: image303
        x: 3918
        y: 1082
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image304
        x: 3846
        y: 1187
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image305
        x: 3986
        y: 1187
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image307
        x: 4057
        y: 1082
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image308
        x: 3846
        y: 984
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image309
        x: 3986
        y: 984
        source: "../obj/obj/ring.png"
    }

    PLevelChunkVisual {
        id: image159
        x: 2304
        y: -336
        PLevelChunkGArc {
            id: pLevelChunkGArc16
            x: 0
            y: 0
            width: 128
            height: 128
            quadrant: 2
        }
        source: "../mm/tileset/ramp-i.png"
        layerB: true
    }

    Image {
        id: image23
        x: 2638
        y: 272
        rotation: 180
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image26
        x: 2768
        y: 272
        rotation: 180
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image51
        x: 2304
        y: 368
        rotation: 180
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image52
        x: 3361
        y: 1328
        rotation: 180
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image91
        x: 3393
        y: 1328
        rotation: 180
        source: "../obj/obj/spikes.png"
    }

    PLevelChunkVisual {
        id: image93
        x: 768
        y: 528
        source: "tileset/191.png"

        PLevelChunkGRamp {
            id: pLevelChunkGRamp10
            x: 0
            y: 128
            width: 128
            height: 128
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp11
            x: 128
            y: 128
            width: 128
            height: 128
            reversed: true
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect1
            x: 0
            y: 0
            width: 24
            height: 219
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp12
            x: 0
            y: 0
            width: 0
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image140
        x: 1280
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect100
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image141
        x: 1024
        y: 16
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect101
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image139
        x: 1024
        y: 528
        source: "tileset/10.png"
    }

    PLevelChunkVisual {
        id: image144
        x: 768
        y: 16
        PLevelChunkGRect {
            id: pLevelChunkGRect104
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image145
        x: 1280
        y: 528
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image316
        x: 768
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect244
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect245
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image333
            x: 197
            y: 160
            source: "../obj/obj/checkpoint.png"
        }
        source: "../mm/tileset/129.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image329
        x: 1024
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect246
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect247
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image330
            x: 38
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image331
            x: 83
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image332
            x: 122
            y: 176
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/127.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image334
        x: 1280
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect278
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect279
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image126
            x: 186
            y: 192
            source: "../obj/obj/badnik.png"
        }
        source: "../mm/tileset/210.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image147
        x: 768
        y: -240
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect105
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image148
        x: 1024
        y: 687
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect106
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual18
        x: 768
        y: 768
        source: "../mm/tileset/14.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect102
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect103
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect107
            x: 190
            y: 192
            width: 66
            height: 16
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: image160
        x: 1024
        y: 943
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect108
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image229
        x: 512
        y: 768
        source: "../mm/tileset/3.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect169
            x: 0
            y: 160
            width: 256
            height: 96
        }

        Image {
            id: image237
            x: 85
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image238
            x: 149
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image239
            x: 117
            y: 120
            source: "../obj/obj/ring.png"
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: image161
        x: 768
        y: 1024
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image162
        x: 512
        y: 1024
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual19
        x: 256
        y: 768
        source: "../mm/tileset/37.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect109
            x: 0
            y: 128
            width: 256
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect110
            x: 64
            y: 96
            width: 128
            height: 32
            visible: true
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect112
            x: 64
            y: 32
            width: 64
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect113
            x: 192
            y: 0
            width: 64
            height: 128
        }

        Image {
            id: image92
            x: 260
            y: 144
            source: "../obj/obj/spring.png"
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual24
        x: 512
        y: 144
        source: "../mm/tileset/9.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect121
            x: 0
            y: 0
            width: 256
            height: 192
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual26
        x: 256
        y: 144
        source: "../mm/tileset/9.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect130
            x: 0
            y: 0
            width: 256
            height: 192
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual27
        x: 0
        y: 144
        source: "../mm/tileset/11.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect131
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
    }

    PLevelChunkVisual{
        id: image2
        x: 128
        y: 896
        source: "tileset-extra/237.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect5
            x: 0
            y: 4
            width: 64
            height: 124
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect6
            x: 64
            y: 64
            width: 64
            height: 64
        }
    }

    PLevelChunkVisual{
        id: image3
        x: 0
        y: 896
        source: "tileset-extra/4.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect4
            x: 0
            y: 4
            width: 128
            height: 124
        }
    }

    PLevelChunkVisual{
        id: image1
        x: 128
        y: 1024
        source: "tileset-extra/15.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect2
            x: 0
            y: 0
            height: 128
        }
    }

    PLevelChunkVisual{
        id: image4
        x: 0
        y: 1024
        source: "tileset-extra/15.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect3
            x: 0
            y: 0
            height: 128
        }
    }

    PLevelChunkVisual{
        id: image5
        x: 0
        y: 768
        source: "tileset-extra/168.png"
    }

    PLevelChunkVisual {
        id: image6
        x: 0
        y: 640
        source: "tileset-extra/162.png"
    }

    PLevelChunkVisual {
        id: image7
        x: 256
        y: 1024
        source: "tileset-extra/15.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect7
            x: 0
            y: 0
            height: 128
        }
    }

    Image {
        id: image335
        x: 1008
        y: 336
        width: 16
        height: 160
        sourceSize.width: 15
        source: "../obj/obj/TriggerBG.png"
    }

    Image {
        id: image336
        x: 1280
        y: 336
        width: 16
        height: 160
        source: "../obj/obj/TriggerBG-1.png"
        sourceSize.width: 15
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual29
        x: 2560
        y: -576
        layerB: true
        source: "../mm/tileset/71.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect114
            x: 0
            y: 240
            width: 256
            height: 16
            onlyBottomSensors: true
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual31
        x: 2816
        y: -240
        source: "../mm/tileset/11.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect132
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: image129
        x: 2560
        y: -320
        source: "../mm/tileset/152.png"
    }

    PLevelChunkVisual {
        id: image165
        x: 2816
        y: -496
        source: "../mm/tileset/199.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect116
            x: 64
            y: 191
            width: 64
            height: 65
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect133
            x: 0
            y: 160
            width: 64
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect134
            x: 128
            y: 224
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect137
            x: 80
            y: 48
            width: 160
            height: 32
        }
        layerB: true
    }

    Image {
        id: image281
        x: 2961
        y: -479
        source: "../obj/obj/monitor-rings.png"
    }

/*
    Image {
        id: image311
        x: 944
        y: 432
        source: "../obj/obj/checkpoint.png"
    }
*/




}
