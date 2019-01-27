import VPlay 2.0
import VPlayApps 1.0
import QtQuick 2.0
import "../common"
import "../entities"
import "../game"

SceneBase {
    id: highscoreScene

//    Component.onCompleted: {
//        myListView.model = loadModel()
//    }

    ListView {
        id: myListView
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        property real widthIndex: dp(20)
        property real widthScore: dp(30)
        property real widthSeed: dp(20)
        property real itemRowSpacing: dp(20)

        width: parent.width / 2
        height: parent.height / 2

        model: loadModel()
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

        header: Row {
            spacing: myListView.itemRowSpacing

            Text {
                text: "Index"
                width: myListView.widthIndex
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "Score"
                width: myListView.widthScore
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "Seed"
                width: myListView.widthSeed
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
        resetX: highscoreScene.gameWindowAnchorItem.width / 2 - player.width / 2 * player.scale
        resetY: highscoreScene.gameWindowAnchorItem.height - groundManager.height
                - player.height * player.scale + player.height / 20 * player.scale
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
                var keyA = a.distance,
                    keyB = b.distance;
                if(keyA < keyB) return -1;
                if(keyA > keyB) return 1;
                return 0;
            });
            var index = 1
            temp.forEach(function(entry) {
                model.push({index:index, distance: entry.distance, seed: entry.seed});
                index++;
            });
            return model
        }
        return []
    }
}
