import VPlay 2.0
import QtQuick 2.0
import "scenes"

GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 540

    Component.onCompleted: {
        menuScene.startScene()
    }

    // You get free licenseKeys from https://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://v-play.net/licenseKey>"

    PhysicsWorld {
        id: physicsWorld
        gravity.y: 9.81
//        debugDrawVisible: true
    }


    // create and remove entities at runtime
    EntityManager {
        id: entityManager
        entityContainer: activeScene
    }

    FontLoader {
        id: fontloader
        source: "../assets/font/Pixeled.ttf"

        Component.onCompleted: {
            if (system.platform === System.Android)
                name = "Pixeled"
        }
    }


    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onStartGame: {
            window.state = "game"
            menuScene.stopScene()
            gameScene.startScene(utils.generateRandomValueBetween(1,100000))
        }
        onStartHighscore: {
            window.state = "highscore"
            menuScene.stopScene()
            highscoreScene.startScene()
            highscoreScene.loadModel()
        }

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }
        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                // only quit, if the activeScene is menuScene - the messageBox might also get opened from other scenes in your code
                if(accepted && window.activeScene === menuScene)
                    Qt.quit()
            }
        }
    }

    // game scene
    GameScene {
        id: gameScene

        onReturnToMenu: {
            window.state = "menu"
            menuScene.startScene()
            gameScene.stopGame()
        }

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            window.state = "menu"
            menuScene.startScene()
            gameScene.stopGame()
        }
    }

    // game scene
    HighscoreScene {
        id: highscoreScene

        onPlayLevel: {
            window.state = "game"
            highscoreScene.stopScene()
            gameScene.startScene(seed)
        }

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            window.state = "menu"
            menuScene.startScene()
            highscoreScene.stopGame()
        }
    }

    // menuScene is our first scene, so set the state to menu initially
    state: "menu"
    activeScene: menuScene

    // state machine, takes care reversing the PropertyChanges when changing the state, like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameScene; opacity: 0}
            PropertyChanges {target: highscoreScene; opacity: 0}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "game"
            PropertyChanges {target: menuScene; opacity: 0}
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: highscoreScene; opacity: 0}
            PropertyChanges {target: window; activeScene: gameScene}
        },
        State {
            name: "highscore"
            PropertyChanges {target: menuScene; opacity: 0}
            PropertyChanges {target: gameScene; opacity: 0}
            PropertyChanges {target: highscoreScene; opacity: 1}
            PropertyChanges {target: window; activeScene: highscoreScene}
        }
    ]
}
