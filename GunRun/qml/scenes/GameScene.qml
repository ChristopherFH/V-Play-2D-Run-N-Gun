import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: gameScene

    property int score: 0

    Level {
        id: level
        anchors.fill: parent
    }

    Ground {
        id: ground
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
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

    MouseArea {
        id: mouseControl
        anchors.fill: gameScene.gameWindowAnchorItem
        onPressed: {
            if(gameIsRunning) {

            }
        }
    }

    Numbers {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        number: score
    }


    function initGame() {
        player.reset()
        level.reset()
        score = 0
    }

    function startGame() {
        level.start()
    }

    function stopGame() {
        level.stop()
    }

}
