import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"

SceneBase {
    id: menuScene

    signal startGame()
    signal startHighscore()

    CloudManager {
        id: cloudManager
        width: menuScene.gameWindowAnchorItem.width
        height: 80
        anchors.top: menuScene.gameWindowAnchorItem.top
    }

    // the "logo"
    Image {
        scale: 0.6
        z: 100
        anchors.topMargin: 15
        anchors.horizontalCenter: menuScene.horizontalCenter
        anchors.top:  menuScene.top
        source: "../../assets/img/KnightRun.png"
    }

    SimpleGroundManager {
        id: groundManager
        anchors.horizontalCenter: menuScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        width: menuScene.gameWindowAnchorItem.width
    }

    Player {
        id: player
        resetX: groundManager.width/2 + groundManager.x - player.width/2*player.scale
        resetY: groundManager.y - player.height * player.scale + player.height / 20 * player.scale
    }

    // menu
    Menu {
        anchors.centerIn: parent
        z: 100

        onScorePressed: {
            startHighscore()
        }

        onPlayPressed: {
            startGame()
        }
    }

    function startScene() {
        cloudManager.start()
        groundManager.start()
    }

    function stopScene() {
        cloudManager.stop()
        groundManager.stop()
    }
}
