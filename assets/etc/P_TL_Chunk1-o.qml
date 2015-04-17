import QtQuick 2.0
import ".." 1.0
import "../obj" 1.0

PLevelChunk {

    width: 4096
    height: 4096

    PLevelChunkVisual
    {
        source: "testlevel.png"
        layerB: true

        Image {
            id: image4
            x: 928
            y: 881
            source: "../obj/obj/spring.png"
        }

        Image {
            id: image5
            x: 960
            y: 881
            source: "../obj/obj/spring.png"
        }

        Image {
            id: image6
            x: 950
            y: 651
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image7
            x: 950
            y: 681
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image8
            x: 950
            y: 712
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image9
            x: 950
            y: 745
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image10
            x: 48
            y: 356
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image11
            x: 76
            y: 356
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image12
            x: 103
            y: 356
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image1
            x: 736
            y: 740
            source: "../obj/obj/obstacle.png"
        }

        Image {
            id: image2
            x: 375
            y: 804
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image3
            x: 412
            y: 814
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image13
            x: 336
            y: 814
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image14
            x: 810
            y: 552
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image15
            x: 837
            y: 552
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image18
            x: 197
            y: 922
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image21
            x: 312
            y: 460
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image19
            x: 312
            y: 430
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image20
            x: 312
            y: 400
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image22
            x: 312
            y: 373
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image30
            x: 264
            y: 496
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image29
            x: 712
            y: 269
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image31
            x: 712
            y: 295
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image32
            x: 712
            y: 322
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image33
            x: 721
            y: 244
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image34
            x: 703
            y: 244
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image35
            x: 703
            y: 226
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image36
            x: 721
            y: 226
            source: "../obj/obj/ring.png"
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect12
            x: 992
            y: -1
            width: 32
            height: 481
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc13
            x: 32
            y: 32
            width: 128
            height: 128
            quadrant: 1
        }

        Image {
            id: image40
            x: 992
            y: 504
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image41
            x: 567
            y: 504
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image42
            x: 503
            y: 504
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image43
            x: 535
            y: 504
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image45
            x: 304
            y: 496
            source: "obj/spring-y.png"
        }

        Image {
            id: image48
            x: 705
            y: 496
            source: "obj/spring-y.png"
        }

        Image {
            id: image129
            x: 194
            y: 416
            source: "obj/monitor-rings.png"
        }

        Image {
            id: image275
            x: 163
            y: 416
            source: "obj/monitor-eshield.png"
        }

        PLevelChunkVisual {
            id: pLevelChunkVisual40
            x: 124
            y: 560
        }
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect1
        x: 0
        y: 960
        width: 1024
        height: 64
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect2
        x: 256
        y: 528
        width: 512
        height: 32
        layerB: true
        onlyBottomSensors: false
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect3_1
        x: 640
        y: 896
        width: 384
        height: 64
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc1
        x: 192
        y: 640
        width: 64
        height: 64
        quadrant: 0
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc2
        x: 128
        y: 640
        width: 64
        height: 64
        quadrant: 1
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc3
        x: 768
        y: 768
        width: 128
        height: 128
        quadrant: 3
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect4
        x: 992
        y: 528
        width: 32
        height: 368
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect5
        x: 896
        y: 640
        width: 32
        height: 256
        clip: false
        visible: true
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc4
        x: 511
        y: 832
        width: 128
        height: 128
        quadrant: 3
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc5
        x: 448
        y: 896
        quadrant: 2
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc6
        x: 384
        y: 832
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc7
        x: 320
        y: 832
        quadrant: 1
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc8
        x: 32
        y: 832
        quadrant: 2
        width: 128
        height: 128

        Image {
            id: image16
            x: 97
            y: 89
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image17
            x: 133
            y: 89
            source: "../obj/obj/ring.png"
        }
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect6
        x: 0
        y: 32
        width: 32
        height: 928
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect7
        x: 304
        y: 512
        width: 32
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect8
        x: 704
        y: 512
        width: 32
    }

    PLevelChunkGTop {
        id: pLevelChunkGRect9
        x: 800
        y: 576
        width: 64
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect10
        x: 160
        y: 448
        width: 64
        height: 16
        onlyBottomSensors: true
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc9
        x: 128
        y: 704
        quadrant: 2
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc10
        x: 192
        y: 704
        quadrant: 3
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc11
        x: 256
        y: 896
        quadrant: 3
    }

    PLevelChunkGArc {
        id: pLevelChunkGArc12
        x: 640
        y: 832
        quadrant: 2
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect3
        x: 0
        y: 0
        width: 995
        height: 33
    }

    Image {
        id: image24
        x: -369
        y: -512
        width: 369
        height: 2048
        fillMode: Image.Tile
        source: "transparent.png"
    }

    Image {
        id: image25
        x: 1024
        y: -447
        width: 512
        height: 927
        fillMode: Image.Tile
        source: "transparent.png"
    }

    Image {
        id: image27
        x: 0
        y: -512
        width: 1024
        height: 512
        fillMode: Image.Tile
        source: "transparent.png"
    }

    Image {
        id: image37
        x: 1024
        y: 528
        width: 512
        height: 927
        fillMode: Image.Tile
        source: "transparent.png"
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect13
        x: 1024
        y: 528
        width: 512
        height: 16
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect14
        x: 1024
        y: 351
        width: 512
        height: 129
    }

    PLevelChunkGRect {
        id: pLevelChunkGRect15
        x: 896
        y: 528
        width: 96
        height: 16
        onlyBottomSensors: true
    }

    Image {
        id: image38
        x: 1056
        y: 504
        source: "../obj/obj/ring.png"
    }

    Image {
        id: image39
        x: 1024
        y: 504
        source: "../obj/obj/ring.png"
    }


    PLevelChunkVisual {
        id: pLevelChunkVisual1
        x: 992
        y: 480
        width: 256
        height: 48
        doNotFlatten: true
        layerB: true

        Image {
            id: image28
            x: 0
            y: 0
            width: 544
            height: 48
            z: parent.z
            fillMode: Image.Tile
            source: "transparent.png"
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: 544
            height: 48
            color: "#80000000"
            z: parent.z
        }
    }

    PLevelChunkGTop {
        id: pLevelChunkGTop1
        x: 32
        y: 384
        width: 96
        height: 16
    }

    ObjTrigger {
        id: objTrigger1
        x: 1186
        y: 480
        width: 32
        height: 48

        onTriggered:{ bg.bgSource = Qt.resolvedUrl("bg.png"); bg.bgParallaxSource = Qt.resolvedUrl("bg-parallax.png"); bgm.volume = 1; bgm2.volume = 0; }
    }

    ObjTrigger {
        id: objTrigger2
        x: 1250
        y: 480
        width: 32
        height: 48

        onTriggered:{ bg.bgSource = Qt.resolvedUrl("../mm/bg.png"); bg.bgParallaxSource = Qt.resolvedUrl("../mm/bg-parallax.png"); bgm.volume = 0; bgm2.volume = 1;}
    }

    PLevelChunkVisual {
        id: image44
        x: 1536
        y: 528
        source: "../mm/tileset/1.png"

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
            x: 37
            y: 0
            source: "obj/monitor-rings.png"
        }

        Image {
            id: image281
            x: 65
            y: 0
            source: "obj/monitor-rings.png"
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

            Image {
                id: image279
                x: 256
                y: 16
                source: "obj/spring-y.png"
            }
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
            source: "obj/monitor-rings.png"
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
            id: image126
            x: 171
            y: 224
            source: "../obj/obj/badnik.png"
        }

Image {
    id: image59
    x: 131
    y: 175
    source: "../obj/obj/ring.png"
}

Image {
    id: image58
        x: 99
        y: 175
        source: "../obj/obj/ring.png"
}

Image {
    id: image56
    x: 67
    y: 175
    source: "../obj/obj/ring.png"
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

        Image {
            id: image164
            x: 32
            y: 16
            source: "../obj/obj/spring-y.png"
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
            source: "obj/bumper.png"
        }

        Image {
            id: image306
            x: 189
            y: 42
            source: "obj/ring.png"
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
            source: "obj/monitor-shield.png"
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
        id: image139
        x: 2304
        y: -496
        layerB: true
        source: "../mm/tileset/24.png"

        PLevelChunkGArc {
            id: pLevelChunkGArc22
            x: 216
            y: 144
            width: 24
            height: 24
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc23
            x: 192
            y: 144
            width: 24
            height: 24
            quadrant: 1
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc24
            x: 192
            y: 168
            width: 24
            height: 24
            quadrant: 2
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc25
            x: 216
            y: 168
            width: 24
            height: 24
            quadrant: 3
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc26
            x: 56
            y: 64
            width: 24
            height: 24
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc27
            x: 32
            y: 64
            width: 24
            height: 24
            quadrant: 1
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc28
            x: 32
            y: 88
            width: 24
            height: 24
            quadrant: 2
        }

        PLevelChunkGArc {
            id: pLevelChunkGArc29
            x: 56
            y: 88
            width: 24
            height: 24
            quadrant: 3
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp22
            x: 68
            y: 69
            width: 166
            height: 83
            reversed: true
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp23
            x: 45
            y: 109
            width: 166
            height: 83
            reversed: true
        }

        Image {
            id: image310
            x: 16
            y: 48
            width: 240
            height: 160
            source: "obj/TriggerConveyor.png"
        }
    }

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
            x: 236
            y: 127
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
            y: 204
            source: "obj/ring.png"
        }

        Image {
            id: image314
            x: 74
            y: 204
            source: "obj/ring.png"
        }

        Image {
            id: image315
            x: 126
            y: 204
            source: "obj/ring.png"
        }
        source: "../mm/tileset/11.png"
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
            id: image276
            x: 213
            y: 63
            source: "obj/monitor-rings.png"
        }

        Image {
            id: image277
            x: 185
            y: 63
            source: "obj/monitor-rings.png"
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
            id: image165
            x: 131
            y: 175
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image166
            x: 99
            y: 175
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image167
            x: 67
            y: 175
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

        Image {
            id: image278
            x: 189
            y: 128
            source: "obj/monitor-destroyed.png"
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
        id: image187
        x: 4193
        y: -62
        source: "../obj/obj/obstacle.png"
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
        id: image215
        x: 5376
        y: 1296
        source: "../mm/tileset/1.png"
        PLevelChunkGRect {
            id: pLevelChunkGRect153
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
        source: "../mm/tileset/1.png"
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
            id: image223
            x: 64
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
            source: "obj/ring.png"
        }

        Image {
            id: image257
            x: 163
            y: 194
            source: "obj/ring.png"
        }

        Image {
            id: image258
            x: 218
            y: 194
            source: "obj/ring.png"
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
            source: "obj/spring-y.png"
        }

        Image {
            id: image52
            x: 179
            y: 192
            source: "obj/spikes.png"
        }

        Image {
            id: image230
            x: 187
            y: 157
            source: "obj/ring.png"
        }

        Image {
            id: image231
            x: 187
            y: 120
            source: "obj/ring.png"
        }

        Image {
            id: image237
            x: 187
            y: 82
            source: "obj/ring.png"
        }
    }

    PLevelChunkVisual {
        id: image229
        x: 5632
        y: 1552

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
            source: "../obj/obj/spring.png"
        }

        Image {
            id: image255
            x: 154
            y: 80
            source: "obj/bubbler.png"
        }
    }

    PLevelChunkVisual {
        id: image248
        x: 5632
        y: 1296
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image249
        x: 5888
        y: 1296
        source: "../mm/tileset/1.png"
    }

    PLevelChunkVisual {
        id: image250
        x: 6144
        y: 1296
        source: "../mm/tileset/1.png"
    }

    Image {
        id: image251
        x: 5696
        y: 1880
        source: "obj/bumper-32.png"
    }

    Image {
        id: image252
        x: 5814
        y: 2016
        source: "obj/bumper-32.png"
    }

    Image {
        id: image253
        x: 5790
        y: 1830
        source: "obj/bumper-32.png"
    }

    Image {
        id: image254
        x: 5728
        y: 2196
        source: "obj/bumper-32.png"
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual35
        x: 5888
        y: 1552
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
            source: "obj/spikes.png"
        }
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual36
        x: 6144
        y: 1552
        layerB: true
        source: "../mm/tileset/48.png"
        visualBg: true
        PLevelChunkGRect {
            id: pLevelChunkGRect190
            x: 0
            y: 0
            width: 256
            height: 97
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect191
            x: 64
            y: 224
            width: 64
            height: 32
        }

        Image {
            id: image261
            x: 100
            y: 208
            source: "obj/bubbler.png"
        }
    }

    Image {
        id: image259
        x: 6112
        y: 1830
        source: "obj/bumper-32.png"
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
            y: 159
            width: 64
            height: 33
        }

        PLevelChunkGRamp {
            id: pLevelChunkGRamp17
            x: 64
            y: 159
            width: 128
            height: 33
        }

        Image {
            id: image270
            x: 0
            y: 160
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image271
            x: 32
            y: 160
            source: "../obj/obj/spikes.png"
        }

        Image {
            id: image274
            x: 208
            y: 143
            source: "obj/spring.png"
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
            y: 32
            width: 32
            height: 224
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect197
            x: 224
            y: 160
            width: 32
            height: 96
        }

        PLevelChunkGRect {
            id: pLevelChunkGRect198
            x: 224
            y: 32
            width: 32
            height: 32
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

    Image {
        id: image285
        x: 0
        y: 1024
        width: 1024
        height: 2048
        source: "transparent.png"
        fillMode: Image.Tile
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
            x: 77
            y: 120
            source: "obj/ring.png"
        }

        Image {
            id: image292
            x: 113
            y: 131
            source: "obj/ring.png"
        }

        Image {
            id: image293
            x: 152
            y: 145
            source: "obj/ring.png"
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
            source: "obj/spring.png"
        }

        Image {
            id: image289
            x: 120
            y: 184
            source: "obj/ring.png"
        }

        Image {
            id: image290
            x: 120
            y: 221
            source: "obj/ring.png"
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
            source: "obj/ring.png"
        }

        Image {
            id: image91
            x: 83
            y: 176
            source: "obj/ring.png"
        }

        Image {
            id: image92
            x: 122
            y: 176
            source: "obj/ring.png"
        }

        Image {
            id: image93
            x: 182
            y: 192
            source: "obj/monitor-shield.png"
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
        source: "obj/ring.png"
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

    Image {
        id: image295
        x: 5346
        y: 1520
        source: "obj/monitor-shield.png"
    }

    Image {
        id: image296
        x: 3840
        y: 1076
        source: "obj/bumper.png"
    }

    Image {
        id: image297
        x: 3980
        y: 1076
        source: "obj/bumper.png"
    }

    Image {
        id: image298
        x: 3912
        y: 1181
        source: "obj/bumper.png"
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

    Image {
        id: image301
        x: 4051
        y: 1181
        source: "obj/bumper.png"
    }

    Image {
        id: image302
        x: 3912
        y: 978
        source: "obj/bumper.png"
    }

    Image {
        id: image303
        x: 3918
        y: 1082
        source: "obj/ring.png"
    }

    Image {
        id: image304
        x: 3846
        y: 1187
        source: "obj/ring.png"
    }

    Image {
        id: image305
        x: 3986
        y: 1187
        source: "obj/ring.png"
    }

    Image {
        id: image307
        x: 4057
        y: 1082
        source: "obj/ring.png"
    }

    Image {
        id: image308
        x: 3846
        y: 984
        source: "obj/ring.png"
    }

    Image {
        id: image309
        x: 3986
        y: 984
        source: "obj/ring.png"
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
            source: "obj/TriggerConveyor.png"
        }

        Image {
            id: image312
            x: 73
            y: 120
            width: 191
            height: 48
            rotation: 180
            source: "obj/TriggerConveyor.png"
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
        id: pLevelChunkVisual49
        x: 4608
        y: -1008
        PLevelChunkGRect {
            id: pLevelChunkGRect230
            x: 0
            y: 0
            width: 256
            height: 160
        }
        source: "../mm/tileset/75.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual50
        x: 4864
        y: -1008
        PLevelChunkGRect {
            id: pLevelChunkGRect231
            x: 0
            y: 0
            width: 256
            height: 192
        }
        source: "../mm/tileset/9.png"
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
            source: "obj/TriggerConveyor.png"
        }

        Image {
            id: image319
            x: 73
            y: 120
            width: 191
            height: 48
            source: "obj/TriggerConveyor.png"
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
            source: "obj/TriggerConveyor.png"
        }

        Image {
            id: image321
            x: 73
            y: 120
            width: 191
            height: 48
            source: "obj/TriggerConveyor.png"
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
            source: "obj/TriggerConveyor.png"
        }

        Image {
            id: image323
            x: 73
            y: 120
            width: 191
            height: 48
            source: "obj/TriggerConveyor.png"
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
            source: "obj/TriggerConveyor.png"
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
            source: "obj/TriggerConveyor.png"
            rotation: 180
        }
        source: "../mm/tileset/137.png"
        layerB: true
    }

    PLevelChunkVisual {
        id: pLevelChunkVisual56
        x: 6144
        y: 2576
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
            source: "obj/TriggerConveyor.png"
        }

        Image {
            id: image327
            x: 73
            y: 120
            width: 191
            height: 48
            source: "obj/TriggerConveyor.png"
            rotation: 180
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
            id: image247
            x: 38
            y: 176
            source: "obj/ring.png"
        }

        Image {
            id: image317
            x: 83
            y: 176
            source: "obj/ring.png"
        }

        Image {
            id: image328
            x: 122
            y: 176
            source: "obj/ring.png"
        }
        source: "../mm/tileset/129.png"
    }

    PLevelChunkVisual {
        id: image329
        x: 5888
        y: 528
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
            source: "obj/ring.png"
        }

        Image {
            id: image331
            x: 83
            y: 176
            source: "obj/ring.png"
        }

        Image {
            id: image332
            x: 122
            y: 176
            source: "obj/ring.png"
        }
        source: "../mm/tileset/127.png"
    }

    PLevelChunkVisual {
        id: image333
        x: 5888
        y: 784
        source: "../mm/tileset/1.png"
    }





}
