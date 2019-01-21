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

    Ground {
        id: ground
        anchors.horizontalCenter: menuScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
    }

    Player {
        id: player
        anchors.bottom: ground.top
        anchors.bottomMargin: -ground.height / 1.5
        resetX: menuScene.gameWindowAnchorItem.width/2
        resetY: menuScene.gameWindowAnchorItem.height/2
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
