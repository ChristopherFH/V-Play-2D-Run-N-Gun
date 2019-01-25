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
    scale: 0.3

    property int shootAtFrame : 2
    property int realFrameRate: 10
    property int invulnerabilityDuration: 2000 //ms
    property int invulnerabilityBlinks: 7
    property int invulnerabilityBlinksLeft: 0
    property int healthPoints: 3
    property int fixedY: 0
    property bool isJumping: false
    property bool isInvulnerable: false

    signal gameOver()
    Component.onCompleted: {
        reset()
    }

    onGameOver: {
        knightSprite.running = false
    }

    Timer {
        id: getInitialYTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            fixedY = player.y
            console.log("fixedY: " + fixedY)
            player.yChanged.connect(fixY)
        }
    }

    function fixY() {
        if((!isJumping && player.y !== fixedY) || (isJumping && player.y > fixedY)) {
            var difference = fixedY-player.y
            player.y = fixedY
            gameScene.moveGround(difference)
        }
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

    Timer {
        id: invulnerabilityTimer
        interval: invulnerabilityDuration / invulnerabilityBlinks
        running: false
        repeat: true
        onTriggered: {
            toggleVisibility()
            invulnerabilityBlinksLeft--
            if(invulnerabilityBlinksLeft === 0) {
                isInvulnerable = false
                invulnerabilityTimer.stop()
            }
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
            to: {"jumpend": 1}
            frameNames: [
                "Knight_jump_01.png"
            ]
        }

        TexturePackerSpriteVPlay {
            name: "jumpend"
            source: "../../assets/img/knight.json"
            frameRate: realFrameRate
            to: {"jumpend": 1}
            frameNames: [
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
            frameNames: []
        }
    }


    BoxCollider {
        fixedRotation: true
        categories: Box.Category12
        collidesWith: Box.Category7 | Box.Category16
        id: collider
        width: parent.width * parent.scale
        height: (parent.height-10) * parent.scale
        anchors.top: parent.top
        bodyType: Body.Dynamic

        fixture.onBeginContact: {
            if(other.getBody().target.entityType === "projectile") {
                updateHp()
            }else if(knightSprite.currentSprite === "jumpend") {
                isJumping = false
                knightSprite.jumpTo("walk")
            }
        }
    }

    function toggleVisibility() {
    }

    function updateHp(){
        healthPoints--
        gameScene.updateHealthPoints(healthPoints)

        if(healthPoints > 0 && healthPoints < 3) {
            invulnerabilityBlinksLeft = invulnerabilityBlinks
            isInvulnerable = true
            invulnerabilityTimer.start()
        }
    }

    function setHp() {
        healthPoints = 3
        gameScene.updateHealthPoints(healthPoints)
    }

    function reset() {
        setHp()
        player.x = resetX
        player.y = resetY
        collider.body.linearVelocity = Qt.point(0,0)
        knightSprite.running = true
        knightSprite.jumpTo("walk")
        getInitialYTimer.start()
    }

    function die() {
        knightSprite.jumpTo("die")
    }

    function shoot() {
        updateHp()
        knightSprite.jumpTo("cast")
        shootingTimer.start()
    }

    function jump() {
        if(isJumping)
            return

        isJumping = true
        collider.body.applyForceToCenter(Qt.point(0, -10000));
        knightSprite.jumpTo("jump")
    }
}
