import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"

    property real upwardforce: -280
    property int resetX: 0
    property int resetY: 0

    width: collider.radius * 2
    height: collider.radius * 2


    signal gameOver() 

    Component.onCompleted: reset()
    scale: 0.5

    onGameOver: {
        spriteSequence.running = false
    }

    TexturePackerSpriteSequenceVPlay {
        id: knightSprite
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        TexturePackerSpriteVPlay {
            name: "walk"
            source: "../../assets/img/knight.json"
            frameRate: 6
            frameNames: [
                "Knight_walk_01.png",
                "Knight_walk_02.png",
                "Knight_walk_03.png",
                "Knight_walk_04.png",
                "Knight_walk_05.png",
                "Knight_walk_06.png"
            ]
            to:{"walk":1}
        }

        TexturePackerSpriteVPlay {
            name: "cast"
            source: "../../assets/img/knight.json"
            frameRate: 5
            to: {"walk": 1}
            frameNames: [
                "Knight_cast_01.png",
                "Knight_cast_02.png",
                "Knight_cast_03.png",
                "Knight_cast_04.png",
                "Knight_cast_05.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "jump"
            source: "../../assets/img/knight.json"
            frameRate: 2
            to: {"walk": 1}
            frameNames: [
                "Knight_jump_01.png",
                "Knight_jump_02.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "die"
            source: "../../assets/img/knight.json"
            frameRate: 8
            to: {"walk": 1}
            frameNames: [
                "Knight_die_01.png",
                "Knight_die_02.png",
                "Knight_die_03.png",
                "Knight_die_04.png",
                "Knight_die_05.png",
                "Knight_die_06.png",
                "Knight_die_07.png",
                "Knight_die_08.png"
            ]
        }
    }

    BoxCollider {
        id: collider
        width: player.width
        height: player.height
        anchors.centerIn: parent
        bodyType: Body.Dynamic
    }

    function reset() {
        player.x = resetX
        player.y = resetY
        collider.body.linearVelocity = Qt.point(0,0)
        spriteSequence.running = true
    }

    function die() {
        //stop moving here
        knightSprite.jumpTo("die")
    }

    function shoot() {
        //add projectile spawning here
        knightSprite.jumpTo("cast")
    }

    function jump() {
        //add some velocity here
        knightSprite.jumpTo("jump")
    }
}
