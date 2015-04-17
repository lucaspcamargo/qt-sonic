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
            x: 838
            y: 496
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image15
            x: 865
            y: 496
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
            x: 945
            y: 285
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image31
            x: 945
            y: 311
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image32
            x: 945
            y: 338
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image33
            x: 954
            y: 260
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image34
            x: 936
            y: 260
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image35
            x: 936
            y: 242
            source: "../obj/obj/ring.png"
        }

        Image {
            id: image36
            x: 954
            y: 242
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
            id: image129
            x: 194
            y: 416
            source: "obj/monitor-rings.png"
        }

        Image {
            id: image275
            x: 163
            y: 416
            source: "obj/monitor-fshield.png"
        }

        PLevelChunkVisual {
            id: pLevelChunkVisual40
            x: 124
            y: 560
        }

        Image {
            id: image92
            x: 639
            y: 42
            source: "obj/redRing.png?0"
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

        Image {
            id: image48
            x: 512
            y: 0
            source: "obj/bridge.png"
        }
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

    PLevelChunkGRect {
        id: pLevelChunkGRect15
        x: 959
        y: 528
        width: 33
        height: 16
        onlyBottomSensors: true
    }


    PLevelChunkGTop {
        id: pLevelChunkGTop1
        x: 32
        y: 384
        width: 96
        height: 16
    }





}
