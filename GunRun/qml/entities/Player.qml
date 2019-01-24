import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"

    property real upwardforce: -280
    property int resetX: 0
    property int resetY: 0

    width: 128
    height: 148

    property int shootAtFrame : 2
    property int realFrameRate: 10

    signal gameOver()

    Component.onCompleted: {
        reset()
    }
    scale: 0.4

    onGameOver: {
        knightSprite.running = false
    }

    Timer {
        id: shootingTimer
        interval: shootAtFrame / realFrameRate * 1000
        running: false
        repeat: false
        onTriggered: {
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FireBall.qml"),
                                                            {"x": (player.x + player.width / 2 * player.scale), "y": player.y + player.height/2*player.scale, "speed": 350});
        }
    }


    TexturePackerSpriteSequenceVPlay {
        id: knightSprite
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        TexturePackerSpriteVPlay {
            name: "walk"
            source: "../../assets/img/knight.json"
            frameRate: realFrameRate
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
            frameRate: realFrameRate
            to: {"castend": 1}
            frameNames: [
                "Knight_cast_01.png",
                "Knight_cast_02.png",
                "Knight_cast_03.png",
                "Knight_cast_04.png"
            ]

        }

        TexturePackerSpriteVPlay {
            name: "castend"
            source: "../../assets/img/knight.json"
            frameRate: realFrameRate
            to: {"walk": 1}
            frameNames: [
                "Knight_cast_05.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "jump"
            source: "../../assets/img/knight.json"
            frameRate: realFrameRate
            to: {"walk": 1}
            frameNames: [
                "Knight_jump_01.png",
                "Knight_jump_02.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "die"
            source: "../../assets/img/knight.json"
            frameRate: realFrameRate
            to: {"dieend": 1}
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

        TexturePackerSpriteVPlay {
            name: "dieend"
            source: "../../assets/img/knight.json"
            frameRate: realFrameRate
            to: {"dieend": 1}
            frameNames: [

            ]
        }
    }


    BoxCollider {
        categories: Box.Category1
        collidesWith: Box.Category5
        id: collider
        width: player.width
        height: player.height
        anchors.centerIn: player
        bodyType: Body.Dynamic

        fixture.onBeginContact: {
            updateHp()
        }
    }

    function updateHp(){
        gameScene.updateHeartPoints()
    }

    function reset() {
        player.x = resetX
        player.y = resetY
        collider.body.linearVelocity = Qt.point(0,0)
        knightSprite.running = true
        knightSprite.jumpTo("walk")
    }

    function die() {
        //stop moving here
        knightSprite.jumpTo("die")
    }

    function shoot() {
        //add projectile spawning here
        knightSprite.jumpTo("cast")
        shootingTimer.start()
    }

    function jump() {
        //add some velocity here
        knightSprite.jumpTo("jump")
    }
}
