import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: gameScene

    property int score: 0
    property int gameStartCount: 3

    Level {
        id: level
        anchors.fill: parent
    }

    GroundManager {
        id: ground
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        width: gameScene.gameWindowAnchorItem.width
        height: 20
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
        resetY: gameScene.gameWindowAnchorItem.height - ground.height - player.height * player.scale + player.height/15 * player.scale

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

    //    Numbers {
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        y: 30
    //        number: score
    //    }

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

    function spawnEnemy() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Dragon.qml"),
                                                        {"resetX": gameScene.gameWindowAnchorItem.width - 10,
                                                        "resetY": gameScene.gameWindowAnchorItem.height - ground.height})
    }

    function startGame() {
        console.log("Start game called")
        player.reset()
        level.reset()
        score = 0
        playerToStartAnimation.start()
        updateGamestartTimer.start()
    }

    function stopGame() {
        level.stop()
        gameScene.state = "gameOver"
    }

}
