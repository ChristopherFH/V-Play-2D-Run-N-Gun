import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: dragon
    entityType: "enemy"

    width: collider.radius * 2
    height: collider.radius * 2
    property int frameRate: 10


    TexturePackerSpriteSequenceVPlay {
        id: dragonSprite
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        mirrorX: true

        TexturePackerSpriteVPlay {
            name: "idle"
            source: "../../assets/img/dragon.json"
            frameRate: frameRate
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
            frameRate: frameRate
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
            frameRate: frameRate
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
            frameRate: frameRate
            to: {"win": 1}
            frameNames: [
                "win_01.png",
                "win_02.png"
            ]
        }
    }

    BoxCollider {
        id: collider
        width: dragon.width
        height: dragon.height
        anchors.centerIn: parent
        bodyType: Body.Dynamic
    }

    function reset() {
        dragon.x = resetX
        dragon.y = resetY
        collider.body.linearVelocity = Qt.point(0,0)
        spriteSequence.running = true
    }

    function die() {
        //stop moving here
        dragonSprite.jumpTo("die")
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
