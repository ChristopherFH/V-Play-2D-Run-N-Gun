import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"

SceneBase {
    id: menuScene

    signal startGame()

    CloudManager {
        id: cloudManager
        width: menuScene.gameWindowAnchorItem.width
        height: 80
        anchors.top: menuScene.gameWindowAnchorItem.top
    }

    // the "logo"
    Image {
        scale: 0.6
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
        resetX: menuScene.gameWindowAnchorItem.width/2 - player.width/2*player.scale
        resetY: menuScene.gameWindowAnchorItem.height - groundManager.height - player.height * player.scale + player.height / 20 * player.scale
    }

    // menu
    Menu {
        anchors.centerIn: parent

        onScorePressed: scoreAction()
        onPlayPressed: {
            startGame()
        }
    }

    function scoreAction() {
        player.jump()
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
