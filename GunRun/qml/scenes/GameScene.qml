import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: gameScene

    property int score: 0
    property int gameStartCount: 3
    property int heartPoints: 3

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
        height: 25.6
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
                updateHeartPoints()
            }
        }
    }

    BorderElement {
        entityId: "border-left"
        id: leftBorder
        anchors.bottom: gameScene.bottom
        anchors.right: gameScene.gameWindowAnchorItem.left
        width: 20
        height: gameScene.height
    }

    BorderElement {
        entityId: "border-right"
        id: rightBorder
        anchors.bottom: gameScene.bottom
        anchors.left: gameScene.gameWindowAnchorItem.right
        width: 20
        height: gameScene.height
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
            startGame()
        }
        onExitPressed: {
           window.state = "menu"
        }
    }

    function updateCount(){
        if(gameStartCount > 1) {
            count.text = (--gameStartCount).toString()
        } else {
            updateGamestartTimer.stop()
            level.start()
            spawnEnemy()
            gameScene.state = "running"
            count.text = ""
        }
    }

    PropertyAnimation { id: playerToStartAnimation;
        target: player;
        property: "x";
        to: 10;
        duration: 3000 }

    function updateHeartPoints(){
            heartPoints--
            switch(heartPoints) {
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
            if(heartPoints === 0){
                stopGame()
            }
    }

    function spawnEnemy() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Dragon.qml"),
                                                        {"resetX": gameScene.gameWindowAnchorItem.width - 10,
                                                        "resetY": gameScene.gameWindowAnchorItem.height - groundManager.height})
    }

    function startScene() {
        console.log("Start game called")
        state = "wait"
        cloudManager.start()
        groundManager.start()

        player.reset()
        level.reset()
        heart_one.source = "../../assets/img/hud/hudHeart_full.png"
        heart_two.source = "../../assets/img/hud/hudHeart_full.png"
        heart_three.source = "../../assets/img/hud/hudHeart_full.png"
        heartPoints = 3
        score = 0
        gameStartCount = 3
        playerToStartAnimation.start()
        updateGamestartTimer.start()
    }

    function stopGame() {
        // show dialog
        level.stop()
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
