import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: dragon
    entityType: "enemy"
    poolingEnabled: true

    scale: 0.3
    width: 128
    height: 148
    property int resetX: 0
    property int resetY: 0
    property int realFrameRate: 10
    property int dieFrameCount: 10
    property bool isDying: false

    Component.onCompleted: {
        reset()
    }

    Timer {
        id: dieTimer
        interval: (dieFrameCount-1) / realFrameRate * 1000
        running: false
        repeat: false
        onTriggered: {
            removeEntity()
        }
    }

    TexturePackerSpriteSequenceVPlay {
        id: dragonSprite
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        mirrorX: true

        TexturePackerSpriteVPlay {
            name: "idle"
            source: "../../assets/img/dragon.json"
            frameRate: realFrameRate
            to: {"idle": 1}
            frameNames: [
                "idle_01.png",
                "idle_02.png",
                "idle_03.png",
                "idle_04.png",
                "idle_05.png",
                "idle_06.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "die"
            source: "../../assets/img/dragon.json"
            frameRate: realFrameRate
            to: {"idle": 1}
            frameNames: [
                "die_001.png",
                "die_002.png",
                "die_003.png",
                "die_004.png",
                "die_005.png",
                "die_006.png",
                "die_007.png",
                "die_008.png",
                "die_009.png",
                "die_010.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "cast"
            source: "../../assets/img/dragon.json"
            frameRate: realFrameRate
            to: {"idle": 1}
            frameNames: [
                "attack_01.png",
                "attack_02.png",
                "attack_03.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "win"
            source: "../../assets/img/dragon.json"
            frameRate: realFrameRate
            to: {"win": 1}
            frameNames: [
                "win_01.png",
                "win_02.png"
            ]
        }
    }

    BoxCollider {
        collisionTestingOnlyMode: true
        categories: Box.Category3
        collidesWith: Box.Category5 | Box.Category2
        id: collider
        width: dragon.width
        height: dragon.height
        anchors.centerIn: parent
        bodyType: Body.Dynamic

        fixture.onBeginContact: {
            die()
        }
    }

    function reset() {
        dragon.x = resetX - dragon.width * dragon.scale
        dragon.y = resetY - dragon.height * dragon.scale + dragon.height/15 * dragon.scale
        collider.body.linearVelocity = Qt.point(0,0)
        dragonSprite.running = true
    }

    function die() {
        //stop moving here
        isDying = true
        dragonSprite.jumpTo("die")
        dieTimer.start()
    }

    function shoot() {
        //add projectile spawning here
        dragonSprite.jumpTo("cast")
    }

    function win() {
        //add projectile spawning here
        dragonSprite.jumpTo("win")
    }
}
