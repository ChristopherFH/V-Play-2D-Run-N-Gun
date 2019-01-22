import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"

SceneBase {
    id: menuScene

    signal startGame()

    // the "logo"
    Image {
        scale: 0.6
        anchors.topMargin: 15
        anchors.horizontalCenter: menuScene.horizontalCenter
        anchors.top:  menuScene.top
        source: "../../assets/img/KnightRun.png"
    }

    GroundManager {
        id: ground
        anchors.horizontalCenter: menuScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        width: menuScene.gameWindowAnchorItem.width
        height: 20
    }

    Player {
        id: player
        resetX: menuScene.gameWindowAnchorItem.width/2 - player.width/2*player.scale
        resetY: menuScene.gameWindowAnchorItem.height - ground.height - player.height * player.scale + player.height / 15 * player.scale
    }

    // menu
    Menu {
        anchors.centerIn: parent

        //        onScorePressed: scoreAction()
        onPlayPressed: {
            startGame()
        }
    }
}
