import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: gameScene

    onActiveFocusChanged: {
        updatePositioningTimer.start()
        updateGamestartTimer.start()
    }

    property int score: 0
    property int gameStartCount: 3

    Level {
        id: level
        anchors.fill: parent
    }

    Ground {
        id: ground
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
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
        anchors.bottom: ground.top
        anchors.bottomMargin: -ground.height / 1.5
        resetX: gameScene.gameWindowAnchorItem.width/2
        resetY: gameScene.gameWindowAnchorItem.height/2

        onGameOver: {
            if(gameScene.state === "gameOver")
                return
            gameScene.state = "gameOver"
        }
    }

    Timer {
         id: updatePositioningTimer
         interval: 200
         running: false
         repeat: true
         onTriggered: gameScene.updatePosition()
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

            }
        }
    }

//    Numbers {
//        anchors.horizontalCenter: parent.horizontalCenter
//        y: 30
//        number: score
//    }

    function updateCount(){
        if(gameStartCount >= 0){
            count.text = (gameStartCount--).toString()
        }else{
            updateGamestartTimer.stop()
            level.start()
            gameScene.state = "running"
            count.text = ""
        }
    }

    function updatePosition() {
        if(player.x >= gameScene.gameWindowAnchorItem.width / 5){
            player.x  -= 8
        }else{
            updatePositioningTimer.stop()
        }
    }

    function startGame() {
        player.reset()
        level.reset()
        score = 0
        updatePositioningTimer.start()
        updateGamestartTimer.start()
    }

    function stopGame() {
        level.stop()
        gameScene.state = "gameOver"
    }

}
