import QtQuick 2.0
import VPlay 2.0
import "../scenes"

Item {
    id: scoreBoard
    anchors.centerIn: parent
    width: parent.width
    height: parent.height

    opacity: 0
    visible: opacity === 0 ? false : true
    enabled: visible

    property int distance: 0

    signal playAgainPressed()
    signal exitPressed()

    Text{
        id: textGameOver
        anchors.top: parent.top
        anchors.topMargin: parent.height / 5
        anchors.horizontalCenter: parent.horizontalCenter
        color: "black"
        text: "Game Over!"
        font.pixelSize: 20
        font.family: fontloader.name
    }

    Row {
        spacing: 18
        anchors.top: textGameOver.bottom
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: panel.height

        GameOverButton {
            id: menuItem
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                playAgainPressed()
            }
            source: "../../assets/img/pixel-art/uipack_fixed/PNG/blue_button03.png"

            Text {
                color: "white"
                anchors.verticalCenterOffset: -parent.height / 10
                text: "play"
                anchors.centerIn: parent
                font.pixelSize: parent.height / 2.5
                font.family: fontloader.name
            }
        }

        MultiResolutionImage {
            id: panel
            height: scoreBoard.height / 2
            width: scoreBoard.width / 3
            source: "../../assets/img/hud/shield.png"

            Text{
                id: textScore
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -parent.height / 10
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
                text: distance.toString() + "m"
                font.pixelSize: 20
                font.family: fontloader.name
            }

        }

        GameOverButton {

            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                exitPressed()
            }
            source: "../../assets/img/pixel-art/uipack_fixed/PNG/blue_button03.png"

            Text {
                color: "white"
                anchors.verticalCenterOffset: -parent.height / 10
                text: "exit"
                anchors.centerIn: parent
                font.pixelSize: parent.height / 2.5
                font.family: fontloader.name
            }
        }
    }


}

