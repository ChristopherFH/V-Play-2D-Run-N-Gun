import VPlay 2.0
import VPlayApps 1.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: highscoreScene

    signal playLevel(int seed)

    ListView {
        id: myListView
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        property real widthIndex: width / 6
        property real widthScore: width / 4
        property real widthSeed: width / 4
        property real widthPlayButton: width / 4
        property real itemRowSpacing: dp(20)

        width: parent.width / 2
        height: parent.height / 2

        model: loadModel()

        header: Row {
            spacing: myListView.itemRowSpacing

            Text {
                text: "Index"
                width: myListView.widthIndex
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "Score"
                width: myListView.widthScore
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "World"
                width: myListView.widthSeed
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: ""
                width: myListView.widthPlayButton
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        section.property: "index"
        section.delegate: SimpleSection {
            enabled: true
            onSelected: {
                console.log("Section Selected: "+section)
            }
        }

        delegate: Row {
            id: listviewDelegate
            spacing: myListView.itemRowSpacing

            Text {
                id: indexText
                width: myListView.widthIndex
                text: modelData.index
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: modelData.distance + "m"
                width: myListView.widthScore
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: modelData.seed
                width: myListView.widthSeed
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            GameOverButton {
                anchors.verticalCenter: parent.verticalCenter
                width: myListView.widthPlayButton
                height: indexText.height + dp(4)
                anchors.top: indexText.top
                anchors.bottom: indexText.bottom
                anchors.topMargin: dp(2)
                anchors.bottomMargin: dp(2)
                onClicked: {
                    playLevel(modelData.seed)
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
        }
    }

    CloudManager {
        id: cloudManager
        width: highscoreScene.gameWindowAnchorItem.width
        height: 80
        anchors.top: highscoreScene.gameWindowAnchorItem.top
    }

    SimpleGroundManager {
        id: groundManager
        anchors.horizontalCenter: highscoreScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: highscoreScene.gameWindowAnchorItem.bottom
        width: highscoreScene.gameWindowAnchorItem.width
    }

    Player {
        id: player
        resetX: groundManager.width/2 + groundManager.x - player.width/2*player.scale
        resetY: groundManager.y - player.height * player.scale + player.height / 20 * player.scale
    }

    DataManager {
        id: dataManager
    }

    function startScene() {
        cloudManager.start()
        groundManager.start()
    }

    function stopScene() {
        cloudManager.stop()
        groundManager.stop()
    }

    function loadModel() {
        var jsonString = dataManager.loadeValue()
        var model = []
        if (jsonString !== undefined) {
            var temp = JSON.parse(jsonString)
            temp.sort(function(a, b){
                var keyA = parseInt(a.distance)
                var keyB = parseInt(b.distance)

                if(keyA < keyB)
                    return 1
                if(keyA > keyB)
                    return -1
                return 0
            });
            var index = 1
            temp.forEach(function(entry) {
                model.push({index:index, distance: entry.distance, seed: entry.seed});
                index++;
            });
            myListView.model = model
            return model
        }
        return []
    }
}
