import QtQuick 2.0
import ".." 1.0
import "../obj" 1.0

PLevelChunk {

    width: 4096
    height: 4096


    PLevelChunkVisual {
        id: pLevelChunkVisual18
        x: 4096
        y: 1296
        source: "../mm/tileset/14.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect100
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect101
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect102
            x: 190
            y: 192
            width: 66
            height: 16
        }
    }

    PLevelChunkVisual {
        id: image140
        x: 4096
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image141
        x: 4352
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image142
        x: 4352
        y: 1296
        layerB: true
        source: "../mm/tileset-extra/ghz-loop-bg.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect103
            x: 0
            y: 193
            width: 256
            height: 64
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp10
            x: 48
            y: 182
            width: 74
            height: 12
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc18
            x: 49
            y: 17
            width: 79
            height: 79
            quadrant: 1

            Image {
                id: image181
                x: 63
                y: 0
                source: "../obj/obj/TriggerLayerB.png"
            }

            Image {
                id: image191
                x: 71
                y: 16
                source: "../obj/obj/ring.png"
            }

            Image {
                id: image192
                x: 6
                y: 70
                source: "../obj/obj/ring.png"
            }

            Image {
                id: image194
                x: 24
                y: 28
                source: "../obj/obj/ring.png"
            }
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc19
            x: 49
            y: 96
            width: 87
            height: 87
            layerA: false
            quadrant: 2

            Image {
                id: image196
                x: 21
                y: 32
                source: "../obj/obj/ring.png"
            }

            Image {
                id: image197
                x: 116
                y: 32
                source: "../obj/obj/ring.png"
            }
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect20
            x: 16
            y: 48
            width: 33
            height: 86
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect107
            x: 0
            y: 17
            width: 61
            height: 31
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect108
            x: 0
            y: 1
            width: 128
            height: 16
        }

        Image {
            id: image185
            x: 16
            y: 156
            source: "../obj/obj/TriggerLayerA.png"
        }
    }

    PLevelChunkVisual {
        id: image143
        x: 4480
        y: 1296
        source: "../mm/tileset-extra/ghz-loop-fg.png"

        PLevelChunkGArc {
            id: pLevelChunkGArc16
            x: 0
            y: 17
            width: 79
            height: 79

            Image {
                id: image193
                x: 54
                y: 71
                source: "../obj/obj/ring.png"
            }

            Image {
                id: image195
                x: 41
                y: 30
                source: "../obj/obj/ring.png"
            }
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc17
            x: -8
            y: 96
            width: 87
            height: 87
            layerB: false
            quadrant: 3
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect109
            x: 0
            y: 1

            Image {
                id: image182
                x: 0
                y: 16
                source: "../obj/obj/TriggerLayerA.png"
            }
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect110
            x: 79
            y: 17
            width: 49
            height: 112
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp12
            x: 7
            y: 183
            width: 64
            height: 10
            reversed: true
            layerA: true
        }

        Image {
            id: image183
            x: 112
            y: 155
            source: "../obj/obj/TriggerLayerA.png"
        }

        Image {
            id: image184
            x: 96
            y: 155
            source: "../obj/obj/TriggerLayerB.png"
        }

        Image {
            id: image190
            x: -8
            y: 150
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image144
        x: 4608
        y: 1296
        layerB: true
        source: "../mm/tileset/178.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect104
            x: 0
            y: 192
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect105
            x: 192
            y: 159
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp11
            x: 64
            y: 159
            width: 128
            height: 33
        }

        Image {
            id: image212
            x: 192
            y: 47
            source: "../obj/obj/badnik.png"
        }
    }

    PLevelChunkVisual {
        id: image145
        x: 4608
        y: 1552
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image147
        x: 4096
        y: 16
        PLevelChunkGRect {
            id: pLevelChunkGRect112
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/7.png"
    }

    PLevelChunkVisual {
        id: image148
        x: 4352
        y: 16
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect113
            x: 64
            y: 63
            width: 64
            height: 65
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect114
            x: 0
            y: 32
            width: 64
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect115
            x: 128
            y: 96
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect116
            x: 0
            y: 128
            width: 256
            height: 128
        }
        source: "../mm/tileset/49.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual24
        x: 4096
        y: -1008
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect121
            x: 0
            y: 0
            width: 256
            height: 97
        }

        Image {
            id: image313
            x: 22
            y: 240
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image314
            x: 74
            y: 240
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image315
            x: 126
            y: 240
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual19
        x: 4352
        y: 1488
        visualBg: true
        layerB: true
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual27
        x: 4096
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect131
            x: 0
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect132
            x: 160
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect133
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image159
            x: 112
            y: 208
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image161
            x: 120
            y: 111
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image162
            x: 120
            y: 79
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image163
            x: 120
            y: 143
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image46
            x: 112
            y: 32
            source: "../obj/obj/redRing.png"
        }
        layerB: true
        visualBg: true
        source: "../mm/tileset/47.png"
    }

    PLevelChunkVisual {
        id: image160
        x: 4352
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect134
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image168
        x: 4352
        y: 528
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect137
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual26
        x: 4096
        y: 528
        source: "../mm/tileset/91.png"
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect130
            x: 160
            y: 160
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect138
            x: 224
            y: 0
            width: 32
            height: 160
        }
    }

    Image {
        id: image169
        x: 4408
        y: 1265
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image170
        x: 4424
        y: 1233
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image171
        x: 4440
        y: 1265
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image172
        x: 4456
        y: 1233
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image173
        x: 4472
        y: 1265
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image174
        x: 4488
        y: 1233
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image175
        x: 4504
        y: 1265
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image177
        x: 4536
        y: 1265
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image178
        x: 4440
        y: 1201
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image176
        x: 4520
        y: 1233
        width: 16
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image180
        x: 4504
        y: 1201
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image179
        x: 4472
        y: 1201
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image188
        x: 4149
        y: -39
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image189
        x: 4285
        y: -39
        source: "../obj/obj/ring.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual29
        x: 4352
        y: 784
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect106
            x: 0
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect139
            x: 192
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect140
            x: 64
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect141
            x: 161
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp13
            x: 161
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp14
            x: 64
            y: 128
            width: 32
            height: 32
            reversed: true
        }

        Image {
            id: image25
            x: 248
            y: 136
            rotation: 90
            source: "../obj/obj/spring-y.png"
        }

        PLevelChunkObject {
            id: pLevelChunkObject1
            x: 192
            y: 120

            objComponentName: "Spinner"
            inPrefix: true

            width: 64
            height: 8

        }
        source: "../mm/tileset/95.png"
    }

    PLevelChunkVisual {
        id: image198
        x: 4096
        y: 784
        PLevelChunkGRect {
            id: pLevelChunkGRect142
            x: 0
            y: 0
            width: 48
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect143
            x: 48
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc20
            x: 112
            y: 128
            quadrant: 2
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc21
            x: 176
            y: 128
            quadrant: 3
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect144
            x: 240
            y: 128
            width: 16
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect145
            x: 96
            y: 0
            width: 160
            height: 64
        }

        Image {
            id: image199
            x: 64
            y: 13
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image200
            x: 64
            y: -15
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image201
            x: 64
            y: 41
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/22.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual30
        x: 4096
        y: 1040
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect146
            x: 0
            y: 0
            width: 256
            height: 97
        }
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual31
        x: 4352
        y: 1040
        layerB: false
        PLevelChunkGRect {
            id: pLevelChunkGRect147
            x: 0
            y: 0
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect148
            x: 160
            y: 0
            width: 96
            height: 96
        }
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual32
        x: 4864
        y: 1296
        layerB: true
        source: "../mm/tileset/14.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect149
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect150
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect151
            x: 190
            y: 192
            width: 66
            height: 64
        }
    }

    PLevelChunkVisual {
        id: image213
        x: 4864
        y: 1552
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect152
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image216
        x: 5376
        y: 1552
        source: "tileset/7.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect154
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image217
        x: 5376
        y: 784
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect155
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual33
        x: 5120
        y: 1552
        source: "../mm/tileset/91.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect156
            x: 160
            y: 160
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect157
            x: 224
            y: 0
            width: 32
            height: 160
        }

        Image {
            id: image227
            x: 176
            y: 144
            source: "../obj/obj/spring-y.png"
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: image214
        x: 4864
        y: 1808
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect158
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image218
        x: 5376
        y: 1808
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect159
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image219
        x: 5120
        y: 1808
        source: "../mm/tileset/142.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect160
            x: 0
            y: 64
            width: 32
            height: 32
        }

        Image {
            id: image220
            x: 8
            y: 32
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image221
            x: 168
            y: 64
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect161
            x: 64
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect162
            x: 96
            y: 32
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect163
            x: 160
            y: 96
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect164
            x: 224
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect165
            x: 224
            y: 64
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect166
            x: 192
            y: 192
            width: 32
            height: 32
        }

        Image {
            id: image222
            x: 224
            y: 96
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image224
            x: 104
            y: 0
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image225
            x: 232
            y: 32
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image226
            x: 200
            y: 176
            source: "../obj/obj/bubbler.png"
        }
        layerB: true
    }

    PLevelChunkVisual {
        id: image232
        x: 4864
        y: 2064
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect167
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image238
        x: 4864
        y: 2320
        PLevelChunkGRect {
            id: pLevelChunkGRect170
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image239
        x: 4864
        y: 2576
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image240
        x: 5120
        y: 2576
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image241
        x: 5120
        y: 2320
        layerB: true
        source: "../mm/tileset/212.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect17
            x: 0
            y: 0
            width: 64
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect171
            x: 64
            y: 224
            width: 192
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp15
            x: 64
            y: 160
            reversed: true
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect172
            x: 128
            y: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect173
            x: 144
            y: 144
            width: 112
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect174
            x: 128
            y: 0
            width: 128
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect175
            x: 224
            y: 64
            width: 32
            height: 64
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp16
            x: 128
            y: 144
            width: 16
            height: 16
            reversed: true
        }

        Image {
            id: image256
            x: 191
            y: 194
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image257
            x: 163
            y: 194
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image258
            x: 218
            y: 194
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image242
        x: 5376
        y: 2320
        layerB: true
        source: "../mm/tileset/215.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect176
            x: 0
            y: 0
            width: 64
            height: 160
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect177
            x: 0
            y: 224
            width: 256
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect178
            x: 224
            y: 16
            width: 32
            height: 208
        }

        Image {
            id: image51
            x: 133
            y: 208
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image52
            x: 179
            y: 192
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image230
            x: 187
            y: 157
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image231
            x: 187
            y: 120
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image237
            x: 187
            y: 82
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image229
        x: 5632
        y: 1040

        PLevelChunkGRect {
            id: pLevelChunkGRect179
            x: 0
            y: 0
            width: 256
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect180
            x: 0
            y: 32
            width: 32
            height: 224
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect181
            x: 224
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect182
            x: 224
            y: 32
            width: 32
            height: 32
        }

        PLevelChunkGTop {
            id: pLevelChunkGTop3
            x: 32
            y: 160
            width: 193
            height: 96
        }

        PLevelChunkVisual {
            id: pLevelChunkVisual38
            x: 0
            y: 0
            width: 256
            height: 256
            source: "../mm/tileset/45-fg.png"

            Image {
                id: image49
                x: 112
                y: 112
                source: "../obj/obj/redRing.png"
            }
        }
        layerB: true
        source: "../mm/tileset/205.png"
    }

    PLevelChunkVisual {
        id: image243
        x: 5376
        y: 2576
        source: "../mm/tileset/1.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect187
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image244
        x: 5376
        y: 2064
        source: "../mm/tileset/13.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect169
            x: 0
            y: 0
            width: 128
            height: 256
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual34
        x: 5632
        y: 2576
        source: "../mm/tileset/37.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect183
            x: 0
            y: 128
            width: 256
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect184
            x: 64
            y: 96
            width: 128
            height: 32
            visible: true
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect185
            x: 64
            y: 32
            width: 64
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect186
            x: 192
            y: 0
            width: 64
            height: 128
        }

        Image {
            id: image245
            x: 15
            y: 111
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image255
            x: 154
            y: 80
            source: "../obj/obj/bubbler.png"
        }
    }

    PLevelChunkVisual {
        id: image250
        x: 5888
        y: 1040
        source: "../mm/tileset/1.png"
    }

    Image {
        id: image251
        x: 5696
        y: 1880
        source: "../obj/obj/bumper-32.png"
    }

    Image {
        id: image252
        x: 5814
        y: 2016
        source: "../obj/obj/bumper-32.png"
    }

    Image {
        id: image253
        x: 5744
        y: 1576
        source: "../obj/obj/bumper-32.png"
    }

    Image {
        id: image254
        x: 5728
        y: 2196
        source: "../obj/obj/bumper-32.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual35
        x: 5888
        y: 1194
        layerB: true
        source: "../mm/tileset/48.png"
        visualBg: true
        PLevelChunkGRect {
            id: pLevelChunkGRect188
            x: 0
            y: 0
            width: 256
            height: 97
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect189
            x: 64
            y: 224
            width: 64
            height: 32
        }

        Image {
            id: image260
            x: 96
            y: 192
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image283
            x: 128
            y: 224
            rotation: 90
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image285
            x: 224
            y: 97
            source: "../obj/obj/spikes.png"
            rotation: 180
        }
    }

    Image {
        id: image259
        x: 6112
        y: 1830
        source: "../obj/obj/bumper-32.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual37
        x: 6400
        y: 1552
        layerB: true
        source: "../mm/tileset/47.png"
        visualBg: true
        PLevelChunkGRect {
            id: pLevelChunkGRect192
            x: 0
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect193
            x: 160
            y: 95
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect194
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image262
            x: 112
            y: 208
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image263
            x: 120
            y: 111
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image264
            x: 120
            y: 79
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image265
            x: 120
            y: 143
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image267
        x: 6656
        y: 1552
        source: "../mm/tileset/1.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect199
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image268
        x: 6400
        y: 1040
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect200
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image269
        x: 6656
        y: 1296
        layerB: true
        source: "../mm/tileset/178.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect201
            x: 0
            y: 192
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect202
            x: 192
            y: 160
            width: 64
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp17
            x: 64
            y: 160
            width: 128
            height: 32
        }

        Image {
            id: image270
            x: 0
            y: 160
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image271
            x: 192
            y: 128
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image274
            x: 32
            y: 176
            source: "../obj/obj/spring.png"
        }

        Image {
            id: image304
            x: 224
            y: 128
            source: "../obj/obj/spikes.png"
        }
    }

    PLevelChunkVisual {
        id: image272
        x: 6912
        y: 1552
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect203
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image273
        x: 6912
        y: 1296
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect204
            x: 0
            y: 0
            width: 256
            height: 256
        }
    }

    PLevelChunkVisual {
        id: image266
        x: 6400
        y: 1296
PLevelChunkVisual {
    id: pLevelChunkVisual39
    x: 0
    y: 0
    width: 256
    height: 256
    source: "../mm/tileset/45-fg.png"
}

PLevelChunkGRect {
    id: pLevelChunkGRect195
            x: 0
            y: 0
            width: 256
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect196
            x: 0
            y: 112
            width: 32
            height: 143
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect197
            x: 224
            y: 112
            width: 32
            height: 144
        }

        PLevelChunkGTop {
            id: pLevelChunkGTop5
            x: 32
            y: 160
            width: 193
            height: 96
        }

        layerB: true
        source: "../mm/tileset/205.png"
    }

    PLevelChunkVisual {
        id: image284
        x: 6144
        y: 1040
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image286
        x: 4608
        y: 784
        PLevelChunkGRect {
            id: pLevelChunkGRect205
            x: 0
            y: 160
            width: 256
            height: 96
        }
        source: "../mm/tileset/166.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual41
        x: 4608
        y: 1040
        PLevelChunkGRect {
            id: pLevelChunkGRect206
            x: 0
            y: 0
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect207
            x: 160
            y: 0
            width: 96
            height: 96
        }
        source: "../mm/tileset/11.png"
        layerB: false
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual42
        x: 4864
        y: 784
        PLevelChunkGRect {
            id: pLevelChunkGRect208
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect209
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect210
            x: 190
            y: 192
            width: 66
            height: 64
        }

        Image {
            id: image291
            x: 91
            y: 134
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image292
            x: 127
            y: 145
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image293
            x: 166
            y: 159
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/14.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual43
        x: 4864
        y: 1040
        PLevelChunkGRect {
            id: pLevelChunkGRect211
            x: 0
            y: 0
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect212
            x: 160
            y: 0
            width: 96
            height: 96
        }
        source: "../mm/tileset/11.png"
        layerB: false
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual44
        x: 5120
        y: 848
        PLevelChunkGRect {
            id: pLevelChunkGRect213
            x: 0
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect214
            x: 192
            y: 128
            width: 64
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect215
            x: 64
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect216
            x: 161
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp18
            x: 161
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp19
            x: 64
            y: 128
            width: 32
            height: 32
            reversed: true
        }

        Image {
            id: image23
            x: 208
            y: 112
            source: "../obj/obj/spring.png"
        }

        Image {
            id: image289
            x: 120
            y: 184
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image290
            x: 120
            y: 221
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/95.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image287
        x: 5376
        y: 528
        PLevelChunkGRect {
            id: pLevelChunkGRect217
            x: 0
            y: 0
            width: 256
            height: 143
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect218
            x: 0
            y: 224
            width: 256
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect219
            x: 224
            y: 143
            width: 32
            height: 81
        }

        Image {
            id: image26
            x: 38
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image91
            x: 83
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image92
            x: 122
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image93
            x: 170
            y: 192
            source: "../obj/obj/monitor-eshield.png"
        }

        Image {
            id: image28
            x: 200
            y: 200
            rotation: 270
            source: "../obj/obj/spring.png"
        }
        source: "../mm/tileset/7.png"
    }

    PLevelChunkVisual {
        id: image288
        x: 5376
        y: 1040
        PLevelChunkGRect {
            id: pLevelChunkGRect220
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    Image {
        id: image294
        x: 5240
        y: 1110
        source: "../obj/obj/ring.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual45
        x: 5120
        y: 1104
        PLevelChunkGRect {
            id: pLevelChunkGRect221
            x: 0
            y: 0
            width: 96
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect222
            x: 192
            y: 128
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect223
            x: 160
            y: 0
            width: 96
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect224
            x: 0
            y: 128
            width: 64
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp20
            x: 64
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp21
            x: 160
            y: 128
            width: 32
            height: 32
            reversed: true
        }
        source: "../mm/tileset/100.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image300
        x: 4608
        y: 528
        PLevelChunkGRect {
            id: pLevelChunkGRect225
            x: 0
            y: 0
            width: 128
            height: 256
        }
        source: "../mm/tileset/13.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual46
        x: 4097
        y: -752
        PLevelChunkGPill {
            id: pLevelChunkGRect226
            x: 0
            y: 32
            width: 176
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGRect227
            x: 80
            y: 128
            width: 176
            height: 32
        }

        Image {
            id: image311
            x: -7
            y: 24
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
        }

        Image {
            id: image312
            x: 73
            y: 120
            width: 191
            height: 48
            rotation: 180
            source: "../obj/obj/TriggerConveyor.png"
        }
        source: "../mm/tileset/124.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual47
        x: 4608
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect229
            x: 0
            y: 32
            width: 256
            height: 224
        }
        source: "../mm/tileset/69.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual48
        x: 4352
        y: -1008
        PLevelChunkGRect {
            id: pLevelChunkGRect228
            x: 0
            y: 0
            width: 256
            height: 97
        }
        source: "../mm/tileset/11.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual52
        x: 4864
        y: 272
        PLevelChunkGPill {
            id: pLevelChunkGRect234
            x: 0
            y: 32
            width: 176
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGRect235
            x: 80
            y: 128
            width: 176
            height: 32
        }

        Image {
            id: image318
            x: -7
            y: 24
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
        }

        Image {
            id: image319
            x: 73
            y: 120
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
            rotation: 180
        }
        source: "../mm/tileset/124.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual53
        x: 4864
        y: 464
        PLevelChunkGPill {
            id: pLevelChunkGRect236
            x: 0
            y: 32
            width: 176
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGRect237
            x: 80
            y: 128
            width: 176
            height: 32
        }

        Image {
            id: image320
            x: -7
            y: 24
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
        }

        Image {
            id: image321
            x: 73
            y: 120
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
            rotation: 180
        }
        source: "../mm/tileset/124.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual54
        x: 5118
        y: 2064
        PLevelChunkGPill {
            id: pLevelChunkGRect238
            x: 0
            y: 32
            width: 176
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGRect239
            x: 80
            y: 128
            width: 176
            height: 32
        }

        Image {
            id: image322
            x: -7
            y: 24
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
        }

        Image {
            id: image323
            x: 73
            y: 120
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
            rotation: 180
        }
        source: "../mm/tileset/124.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual55
        x: 5888
        y: 2576
        PLevelChunkGPill {
            id: pLevelChunkGRect240
            x: 32
            y: 64
            width: 176
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGRect241
            x: 129
            y: 224
            width: 128
            height: 32
        }

        Image {
            id: image325
            x: 25
            y: 56
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
            rotation: 180
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect232
            x: 32
            y: 96
            width: 32
            height: 160
        }

        Image {
            id: image326
            x: 126
            y: 216
            width: 135
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
            rotation: 180
        }

        Image {
            id: image9
            x: 113
            y: 26
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image10
            x: 142
            y: 26
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image11
            x: 82
            y: 26
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image12
            x: 161
            y: 189
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image13
            x: 192
            y: 189
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/137.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual56
        x: 6144
        y: 2640
        PLevelChunkGPill {
            id: pLevelChunkGRect242
            x: 0
            y: 32
            width: 176
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGRect243
            x: 80
            y: 128
            width: 176
            height: 32
        }

        Image {
            id: image324
            x: -7
            y: 24
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
        }

        Image {
            id: image327
            x: 73
            y: 120
            width: 191
            height: 48
            source: "../obj/obj/TriggerConveyor.png"
            rotation: 180
        }

        Image {
            id: image14
            x: 200
            y: 91
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image15
            x: 232
            y: 91
            source: "../obj/obj/ring.png"
        }
        source: "../mm/tileset/124.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image246
        x: 5632
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image316
        x: 5632
        y: 528
        layerB: true
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
            id: image1
            x: 172
            y: 192
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image2
            x: 204
            y: 192
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image48
            x: 186
            y: 137
            source: "../obj/obj/redRing.png"
        }
        source: "../mm/tileset/129.png"
    }

    PLevelChunkVisual {
        id: image329
        x: 5888
        y: 528
        layerB: true
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
    }

    PLevelChunkVisual {
        id: image333
        x: 5888
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image275
        x: 5888
        y: 272

        PLevelChunkGRect {
            id: pLevelChunkGRect248
            x: 32
            y: 224
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp22
            x: 0
            y: 223
            width: 32
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp23
            x: 96
            y: 192
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect249
            x: 128
            y: 192
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp24
            x: 192
            y: 160
            width: 32
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect250
            x: 224
            y: 160
            width: 32
            height: 96
        }
        source: "../mm/tileset/18.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image296
        x: 5120
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect233
            x: 64
            y: 64
            width: 32
            height: 32
        }

        Image {
            id: image27
            x: 72
            y: 37
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image94
            x: 168
            y: 37
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect251
            x: 160
            y: 64
            width: 32
            height: 32
        }

        PLevelChunkGPill {
            id: pLevelChunkGPill1
            x: 64
            y: 160
            width: 96
            height: 96
        }

        Image {
            id: image31
            x: 54
            y: 150
            width: 116
            height: 115
            source: "../obj/obj/TriggerConveyorCircle.png"
        }
        source: "../mm/tileset/130.png"
    }

    PLevelChunkVisual {
        id: image149
        x: 4608
        y: 176
        source: "../mm/tileset/ramp-i.png"
        layerB: true

        PLevelChunkGArc {
            id: pLevelChunkGArc1
            x: 0
            y: 0
            width: 128
            height: 128
            quadrant: 2
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual21
        x: 6656
        y: 2639
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect119
            x: 0
            y: 160
            width: 256
            height: 33
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect122
            x: 44
            y: 16
            width: 168
            height: 16
            onlyBottomSensors: true
        }

        Image {
            id: image6
            x: 216
            y: 128
            source: "../obj/obj/monitor-rings.png"
        }

        Image {
            id: image7
            x: 184
            y: 128
            source: "../obj/obj/monitor-rings.png"
        }
        source: "../tl/tileset/smw-yoshi.png"
    }

    PLevelChunkVisual {
        id: image228
        x: 6912
        y: 2576
        PLevelChunkGRect {
            id: pLevelChunkGRect168
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image233
        x: 6912
        y: 2320
        PLevelChunkGRect {
            id: pLevelChunkGRect252
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual51
        x: 6400
        y: 1808
        PLevelChunkGRect {
            id: pLevelChunkGRect253
            x: 0
            y: 0
            width: 256
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect257
            x: 64
            y: 224
            width: 64
            height: 32
        }
        source: "../mm/tileset/114.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual57
        x: 6656
        y: 1808
        PLevelChunkGRect {
            id: pLevelChunkGRect254
            x: 0
            y: 0
            width: 256
            height: 192
        }

        Image {
            id: image30
            x: 224
            y: 192
            rotation: 180
            source: "../obj/obj/spring.png"
        }
        source: "../mm/tileset/9.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: image279
        x: 6912
        y: 1808
        PLevelChunkGRect {
            id: pLevelChunkGRect255
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image280
        x: 6912
        y: 2064
        PLevelChunkGRect {
            id: pLevelChunkGRect256
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image146
        x: 6400
        y: 2576
        PLevelChunkGRect {
            id: pLevelChunkGRect111
            x: 0
            y: 192
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect117
            x: 192
            y: 159
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp25
            x: 64
            y: 159
            width: 128
            height: 33
        }
        source: "../mm/tileset/178.png"
        layerB: true
    }

    Image {
        id: image3
        x: 6726
        y: 2623
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image4
        x: 6767
        y: 2623
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image5
        x: 6807
        y: 2623
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image16
        x: 6836
        y: 2623
        source: "../obj/obj/spring-y.png"
    }

    PLevelChunkVisual {
        id: image281
        x: 6656
        y: 2064
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect258
            x: 0
            y: 240
            width: 256
            height: 16
            onlyBottomSensors: true
        }

        Image {
            id: image29
            x: 224
            y: 224
            source: "../obj/obj/spring.png"
        }
        source: "../mm/tileset/71.png"
    }

    PLevelChunkVisual {
        id: image282
        x: 6670
        y: 2320
        layerB: true
        source: "../mm/tileset/152.png"
    }

    Image {
        id: image8
        x: 6570
        y: 2236
        source: "../obj/obj/bumper-32.png"
    }

    Image {
        id: image17
        x: 6578
        y: 2152
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image18
        x: 6578
        y: 2118
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image19
        x: 6578
        y: 2084
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image20
        x: 6320
        y: 2040
        source: "../obj/obj/bumper-32.png"
    }

    Image {
        id: image21
        x: 6328
        y: 1956
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image22
        x: 6328
        y: 1922
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image24
        x: 6328
        y: 1888
        source: "../obj/obj/ring.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual1
        x: 4496
        y: -448
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual58
        x: 4608
        y: -752
        PLevelChunkGRect {
            id: pLevelChunkGRect259
            x: 0
            y: 0
            width: 96
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect260
            x: 192
            y: 128
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect261
            x: 160
            y: 0
            width: 96
            height: 128
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect262
            x: 0
            y: 128
            width: 64
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp26
            x: 64
            y: 128
            width: 32
            height: 32
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp27
            x: 160
            y: 128
            width: 32
            height: 32
            reversed: true
        }

        Image {
            id: image47
            x: 112
            y: 14
            source: "../obj/obj/redRing.png"
        }
        layerB: true
        source: "../mm/tileset/100.png"
    }

    PLevelChunkVisual {
        id: image164
        x: 4608
        y: -1008
        PLevelChunkGRect {
            id: pLevelChunkGRect135
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image165
        x: 4864
        y: -1008
        PLevelChunkGRect {
            id: pLevelChunkGRect136
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image166
        x: 5118
        y: -1008
        PLevelChunkGRect {
            id: pLevelChunkGRect263
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image167
        x: 5120
        y: -496
        layerB: true
        PLevelChunkGRect {
            id: pLevelChunkGRect264
            x: 0
            y: 0
            width: 32
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect265
            x: 64
            y: 0
            width: 192
            height: 192
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc3
            x: 32
            y: 192
            quadrant: 2
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc4
            x: 64
            y: 192
            width: 32
            height: 32
            quadrant: 2
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect1
            x: 96
            y: 192
            width: 160
            height: 32
        }
        source: "../mm/tileset/141.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual49
        x: 5120
        y: -240
        PLevelChunkGRect {
            id: pLevelChunkGRect266
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual50
        x: 4864
        y: -240
        PLevelChunkGRect {
            id: pLevelChunkGRect267
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: image297
        x: 4608
        y: -496
        PLevelChunkGRect {
            id: pLevelChunkGRect268
            x: 0
            y: 160
            width: 256
            height: 96
        }

        Image {
            id: image32
            x: 112
            y: 144
            source: "../obj/obj/spring.png"
        }
        layerB: true
        source: "../mm/tileset/166.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual59
        x: 4608
        y: -240
        PLevelChunkGRect {
            id: pLevelChunkGRect269
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: image186
        x: 5184
        y: -752
        PLevelChunkGRect {
            id: pLevelChunkGRect270
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image150
        x: 4352
        y: -496
        PLevelChunkGRect {
            id: pLevelChunkGRect118
            x: 64
            y: 63
            width: 64
            height: 65
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect120
            x: 0
            y: 32
            width: 64
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect123
            x: 128
            y: 96
            width: 64
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect124
            x: 0
            y: 128
            width: 256
            height: 128
        }

        Image {
            id: image33
            x: 256
            y: 128
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image36
            x: 64
            y: 32
            source: "../obj/obj/spikes.png"
        }
        layerB: true
        source: "../mm/tileset/49.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual60
        x: 4352
        y: -240
        PLevelChunkGRect {
            id: pLevelChunkGRect271
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual61
        x: 4928
        y: -752
        PLevelChunkGRect {
            id: pLevelChunkGRect272
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: image151
        x: 4992
        y: -368
        PLevelChunkGArc {
            id: pLevelChunkGArc2
            x: 0
            y: 0
            width: 128
            height: 128
            quadrant: 3
        }
        layerB: true
        source: "../mm/tileset/ramp.png"
    }

    Image {
        id: image34
        x: 4864
        y: -272
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image35
        x: 4896
        y: -272
        source: "../obj/obj/spikes.png"
    }

    Image {
        id: image37
        x: 4377
        y: -603
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image38
        x: 4377
        y: -566
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image39
        x: 4377
        y: -531
        source: "../obj/obj/ring.png"
    }

    PLevelChunkVisual {
        id: image298
        x: 6144
        y: 2064
        PLevelChunkGRect {
            id: pLevelChunkGRect274
            x: 0
            y: 240
            width: 256
            height: 16
            onlyBottomSensors: true
        }

        Image {
            id: image40
            x: -16
            y: 224
            source: "../obj/obj/spring-y.png"
        }
        layerB: true
        source: "../mm/tileset/71.png"
    }

    PLevelChunkVisual {
        id: image299
        x: 5888
        y: 2064
        PLevelChunkGRect {
            id: pLevelChunkGRect275
            x: 0
            y: 240
            width: 256
            height: 16
            onlyBottomSensors: true
        }
        layerB: true
        source: "../mm/tileset/71.png"
    }

    PLevelChunkVisual {
        id: image301
        x: 6075
        y: 2320
        layerB: true
        source: "../mm/tileset/152.png"
    }

    Image {
        id: image41
        x: 5120
        y: -528
        source: "../obj/obj/spikes.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual63
        x: 5376
        y: -496
        PLevelChunkGRect {
            id: pLevelChunkGRect276
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    PLevelChunkVisual {
        id: image202
        x: 5440
        y: -752
        PLevelChunkGRect {
            id: pLevelChunkGRect277
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image334
        x: 6400
        y: 528
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
            id: image335
            x: 38
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image336
            x: 83
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image337
            x: 122
            y: 176
            source: "../obj/obj/ring.png"
        }
        layerB: true
        source: "../mm/tileset/210.png"
    }

    PLevelChunkVisual {
        id: image338
        x: 6144
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image339
        x: 6656
        y: 784
        source: "../mm/tileset/186.png"

        PLevelChunkGRamp {
            id: pLevelChunkGRamp2
            x: 64
            y: 64
            reversed: true

            Image {
                id: image42
                x: 64
                y: 48
                source: "../obj/obj/spring.png"
            }
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect6
            x: 32
            y: 64
            width: 32
            height: 160
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect7
            x: 64
            y: 128
            width: 96
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect8
            x: 0
            y: 0
            width: 32
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect9
            x: 160
            y: 160
            width: 32
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect10
            x: 192
            y: 192
            width: 16
            height: 32
        }
    }

    PLevelChunkVisual {
        id: image340
        x: 6144
        y: 528
        PLevelChunkGRect {
            id: pLevelChunkGRect280
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect281
            x: 0
            y: 224
            width: 256
            height: 32
        }

        Image {
            id: image341
            x: 38
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image342
            x: 83
            y: 176
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image343
            x: 122
            y: 176
            source: "../obj/obj/ring.png"
        }
        layerB: true
        source: "../mm/tileset/127.png"
    }

    PLevelChunkVisual {
        id: image344
        x: 6400
        y: 784
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image302
        x: 6656
        y: 1040
        source: "../mm/tileset/188.png"

        PLevelChunkGRect {
            id: pLevelChunkGRect2
            x: 0
            y: 0
            width: 32
            height: 256
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect3
            x: 128
            y: 160
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect4
            x: 160
            y: 128
            width: 96
            height: 32
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect5
            x: 224
            y: 64
            width: 32
            height: 64
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp1
            x: 160
            y: 64
        }

        Image {
            id: image43
            x: 224
            y: 48
            source: "../obj/obj/spring-y.png"
        }

        Image {
            id: image44
            x: 128
            y: 144
            source: "../obj/obj/spring-y.png"
        }
    }

    PLevelChunkVisual {
        id: image303
        x: 6912
        y: 1040
        PLevelChunkGRect {
            id: pLevelChunkGRect231
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image305
        x: 6912
        y: 784
        PLevelChunkGRect {
            id: pLevelChunkGRect282
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual64
        x: 6144
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect284
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect285
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect286
            x: 190
            y: 192
            width: 66
            height: 64
        }

        Image {
            id: image307
            x: 90
            y: 134
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image308
            x: 126
            y: 145
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image309
            x: 165
            y: 159
            source: "../obj/obj/ring.png"
        }
        layerB: true
        source: "../mm/tileset/14.png"
    }

    PLevelChunkVisual {
        id: image345
        x: 6912
        y: 528
        PLevelChunkGRect {
            id: pLevelChunkGRect288
            x: 0
            y: 0
            width: 256
            height: 256
        }
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image346
        x: 6912
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect289
            x: 0
            y: 160
            width: 256
            height: 96
        }
        layerB: true
        source: "../mm/tileset/166.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual65
        x: 4864
        y: -752
        PLevelChunkGRect {
            id: pLevelChunkGRect290
            x: 0
            y: 0
            width: 256
            height: 97
        }
        layerB: true
        source: "../mm/tileset/11.png"
    }

    Image {
        id: image45
        x: 6656
        y: 432
        width: 256
        source: "../obj/obj/bridge.png"
    }

    PLevelChunkVisual {
        id: image152
        x: 6400
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect125
            x: 0
            y: 192
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect126
            x: 192
            y: 159
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp28
            x: 64
            y: 159
            width: 128
            height: 33
        }
        layerB: true
        source: "../mm/tileset/178.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual66
        x: 7168
        y: 272
        PLevelChunkGRect {
            id: pLevelChunkGRect287
            x: 0
            y: 160
            width: 67
            height: 16
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect291
            x: 62
            y: 176
            rotation: 14.03
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect292
            x: 190
            y: 192
            width: 66
            height: 64
        }
        layerB: true
        source: "../mm/tileset/14.png"
    }

    PLevelChunkVisual {
        id: image349
        x: 7168
        y: 528
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image347
        x: 7424
        y: 464
        PLevelChunkGRect {
            id: pLevelChunkGRect273
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect283
            x: 0
            y: 224
            width: 256
            height: 32
        }
        layerB: true
        source: "../mm/tileset/129.png"
    }

    PLevelChunkVisual {
        id: image348
        x: 7680
        y: 464
        PLevelChunkGRect {
            id: pLevelChunkGRect293
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect294
            x: 0
            y: 224
            width: 256
            height: 32
        }
        layerB: true
        source: "tileset/7.png"
    }

    PLevelChunkVisual {
        id: image350
        x: 7936
        y: 464
        PLevelChunkGRect {
            id: pLevelChunkGRect295
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect296
            x: 0
            y: 224
            width: 256
            height: 32
        }
        layerB: true
        source: "../mm/tileset/129.png"
    }

    PLevelChunkVisual {
        id: image351
        x: 8192
        y: 464
        PLevelChunkGRect {
            id: pLevelChunkGRect297
            x: 0
            y: 0
            width: 256
            height: 64
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect298
            x: 0
            y: 224
            width: 256
            height: 32
        }
        source: "tileset/7.png"
        layerB: true
    }

    Image {
        id: image95
        x: 5955
        y: 1386
        source: "../obj/obj/monitor-shield.png"
    }

    PLevelChunkVisual {
        id: image306
        x: 6144
        y: 1296
        layerB: true
        source: "../mm/tileset/152.png"
    }

    PLevelChunkObject {
        id: pLevelChunkObject2
        x: 4256
        y: 680
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject3
        x: 5376
        y: 1544
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject4
        x: 5472
        y: 1544
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject5
        x: 5568
        y: 1546
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject6
        x: 5280
        y: 2312
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject7
        x: 5280
        y: 2440
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject8
        x: 5984
        y: 2296
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }

    PLevelChunkObject {
        id: pLevelChunkObject9
        x: 6240
        y: 2296
        width: 64
        height: 8
        inPrefix: true
        objComponentName: "Spinner"
    }


    Image {
        id: image999
        x: 6520
        y: 1392
        source: "../obj/obj/checkpoint.png"
    }





}
