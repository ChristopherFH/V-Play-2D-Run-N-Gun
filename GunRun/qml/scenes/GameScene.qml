import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: gameScene

    property int score: 0
    property int gameStartCount: 3
    signal returnToMenu

    property int startingGroundElementId
    property int playerPosition: gameScene.width / 10

    state: "wait"

    Level {
        id: level
        anchors.fill: parent
    }

    DataManager {
        id: dataManager
    }

    GroundManager {
        id: groundManager
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        width: gameScene.gameWindowAnchorItem.width
    }

    Text {
        id: distance
        visible: false
        text: (groundManager.groundElementId - startingGroundElementId).toString()
        anchors.topMargin: 0
        anchors.rightMargin: 10
        color: "white"
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.right: gameScene.gameWindowAnchorItem.right
        font.pixelSize: 20
        font.family: fontloader.name
    }

    Row {
        id: heartPoints_row
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.left: gameScene.gameWindowAnchorItem.left

        Image {
            height: player.height / 4
            width: player.width / 4
            id: heart_one
            source: "../../assets/img/hud/hudHeart_full.png"
        }

        Image {
            height: player.height / 4
            width: player.width / 4
            id: heart_two
            source: "../../assets/img/hud/hudHeart_full.png"
        }

        Image {
            height: player.height / 4
            width: player.width / 4
            id: heart_three
            source: "../../assets/img/hud/hudHeart_full.png"
        }
    }

    BorderElement {
        id: borderLeft
        height: gameScene.height - groundManager.height - 4
        width: 20
        anchors.left: gameScene.left
        anchors.leftMargin: playerPosition - 1 - player.circleColliderWidth * player.scale / 2
        anchors.top: gameScene.top
    }

    BorderElement {
        id: borderRight
        height: gameScene.height - groundManager.height - 4
        width: 20
        anchors.left: gameScene.left
        anchors.leftMargin: playerPosition + 1 + player.circleColliderWidth * player.scale
        anchors.top: gameScene.top
        visible: false
    }

    Text {
        id: count
        text: gameStartCount.toString()
        color: "white"
        anchors.centerIn: parent
        font.pixelSize: 25
        font.family: fontloader.name
    }

    Player {
        id: player
        resetX: groundManager.width/2 + groundManager.x - player.width/2*player.scale
        resetY: groundManager.y - player.height * player.scale + player.height / 20 * player.scale

        onGameOver: {
            if (gameScene.state === "gameOver")
                return
            gameScene.state = "gameOver"
        }
    }

    Timer {
        id: updateGamestartTimer
        interval: 1000
        running: false
        repeat: true
        onTriggered: gameScene.updateCount()
    }

    MouseArea {
        //        property double pressTime: 0
        property int holdDuration: 100
        property int dragDistance: mouseControl.height / 4
        property int startPosition: 0

        id: mouseControl
        anchors.fill: gameScene.gameWindowAnchorItem
        onPressed: {
            //            pressTime = new Date().getTime()
            startPosition = mouse.y
        }

        onReleased: {
            if (gameScene.state == "running") {
                if (isSwipe(mouse.y)) {
                    player.jump()
                } else {
                    player.shoot()
                }
            }
        }

        function isSwipe(releaseX) {

            //            var timeDiff = (new Date().getTime()) - pressTime
            console.log("swipe called: distance: " + (startPosition - releaseX)
                        + "/" + dragDistance)
            return /*timeDiff > holdDuration &&*/ startPosition - releaseX > dragDistance
        }
    }

    CloudManager {
        id: cloudManager
        width: gameScene.gameWindowAnchorItem.width
        height: 80
        anchors.top: gameScene.gameWindowAnchorItem.top

        //        Rectangle {
        //            width: cloudManager.width
        //            height: cloudManager.height
        //            anchors.centerIn: cloudManager
        //            color: "#80ff0000"
        //        }
    }

    DialogBase {
        id: gameOverPanel
        anchors.centerIn: parent
        onPlayAgainPressed: {
            startScene()
        }
        onExitPressed: {
            returnToMenu()
        }
    }

    function updateCount() {
        if (gameStartCount > 1) {
            count.text = (--gameStartCount).toString()
        } else {
            borderLeft.x = player.x - borderLeft.width
            borderRight.visible = true
            updateGamestartTimer.stop()
            level.start()
            spawnEnemy()
            gameScene.state = "running"
            count.text = ""
            startingGroundElementId = groundManager.groundElementId
            distance.visible = true
        }
    }

    PropertyAnimation {
        id: playerToStartAnimation
        target: player
        property: "x"
        to: playerPosition
        duration: 3000
    }

    function moveGround(difference) {
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function (element) {
            element.y += difference
        })
        //        groundManager.y += difference
    }

    function updateHealthPoints(healthPoints) {
        switch (healthPoints) {
        case 0:
            heart_one.source = "../../assets/img/hud/hudHeart_empty.png"
            break
        case 1:
            heart_two.source = "../../assets/img/hud/hudHeart_empty.png"
            break
        case 2:
            heart_three.source = "../../assets/img/hud/hudHeart_empty.png"
            break
        }

        if (healthPoints === 0) {
            stopGame()
        }
    }

    function spawnEnemy() {
        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("../entities/Dragon.qml"), {
                        "resetX": gameScene.gameWindowAnchorItem.width - 10,
                        "resetY": gameScene.gameWindowAnchorItem.height - groundManager.height
                    })
    }

    function startScene(seed) {
        state = "wait"
        borderRight.visible = false
        cloudManager.start()
        groundManager.start(seed)

        player.reset()
        level.reset()
        heart_one.source = "../../assets/img/hud/hudHeart_full.png"
        heart_two.source = "../../assets/img/hud/hudHeart_full.png"
        heart_three.source = "../../assets/img/hud/hudHeart_full.png"
        score = 0
        gameStartCount = 3
        playerToStartAnimation.start()
        updateGamestartTimer.start()
    }

    function stopGame() {
        if(state === "gameOver")
            return

        console.log("STOP GAME")
        // show dialog
        level.stop()
        player.die()
        groundManager.stop()
        cloudManager.stop()
        gameScene.state = "gameOver"
        gameOverPanel.distance = distance.text
        distance.visible = false
        dataManager.storeValue(distance.text, groundManager.seed)
    }

    states: [
        State {
            name: "gameOver"
            PropertyChanges {
                target: gameOverPanel
                opacity: 1
            }
        },
        State {
            name: "wait"
            PropertyChanges {
                target: gameOverPanel
                opacity: 0
            }
        }
    ]
}
