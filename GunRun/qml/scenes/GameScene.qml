import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: gameScene

    property int score: 0
    property int gameStartCount: 3
    signal returnToMenu()

    state : "wait"

    Level {
        id: level
        anchors.fill: parent
    }

    GroundManager {
        id: groundManager
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        width: gameScene.gameWindowAnchorItem.width
    }

    Row{
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
        anchors.leftMargin: 9 - player.width * player.scale/2
        anchors.top: gameScene.top
    }

    BorderElement {
        id: borderRight
        height: gameScene.height - groundManager.height - 4
        width: 20
        anchors.left: gameScene.left
        anchors.leftMargin: 11 + player.width * player.scale
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
        resetX: gameScene.gameWindowAnchorItem.width/2 - player.width/2 * player.scale
        resetY: gameScene.gameWindowAnchorItem.height - groundManager.height - player.height * player.scale + player.height/20 * player.scale

        onGameOver: {
            if(gameScene.state === "gameOver")
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
        id: mouseControl
        anchors.fill: gameScene.gameWindowAnchorItem
        onPressed: {
            if(gameScene.state == "running") {
                player.shoot()
            }
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

    function updateCount(){
        if(gameStartCount > 1) {
            count.text = (--gameStartCount).toString()
        } else {
            borderLeft.x = player.x - borderLeft.width
            borderRight.visible = true
            updateGamestartTimer.stop()
            level.start()
            spawnEnemy()
            gameScene.state = "running"
            count.text = ""
        }
    }

    PropertyAnimation {
        id: playerToStartAnimation
        target: player
        property: "x"
        to: 10
        duration: 3000
    }

    function moveGround(difference) {
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(element) {
            element.y += difference
        })
//        groundManager.y += difference
    }

    function updateHealthPoints(healthPoints){
        switch(healthPoints) {
        case 0:
            heart_one.source = "../../assets/img/hud/hudHeart_empty.png"
            break;
        case 1:
            heart_two.source = "../../assets/img/hud/hudHeart_empty.png"
            break;
        case 2:
            heart_three.source = "../../assets/img/hud/hudHeart_empty.png"
            break;
        }

        if(healthPoints === 0){
            stopGame()
        }
    }

    function spawnEnemy() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Dragon.qml"),
                                                        {"resetX": gameScene.gameWindowAnchorItem.width - 10,
                                                            "resetY": gameScene.gameWindowAnchorItem.height - groundManager.height})
    }

    function startScene() {
        state = "wait"
        borderRight.visible = false
        cloudManager.start()
        groundManager.start()

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
        console.log("STOP GAME")
        // show dialog
        level.stop()
        player.die()
        groundManager.stop()
        cloudManager.stop()
        gameScene.state = "gameOver"
    }

    states: [
        State {
            name: "gameOver"
            PropertyChanges {target: gameOverPanel; opacity: 1}
        },
        State {
            name: "wait"
            PropertyChanges {target: gameOverPanel; opacity: 0}
        }
    ]

}
