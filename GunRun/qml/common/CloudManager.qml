import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: cloudManager
    entityType: "cloudManager"

    Component.onCompleted: {
        cloudSpawnTimer.start()
    }

    Timer {
        id: cloudSpawnTimer
        interval: 4000
        running: false
        repeat: true
        onTriggered: spawnCloud()
    }


    function spawnCloud() {
        var yOffset = utils.generateRandomValueBetween(1,cloudManager.height / 2.3)
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Cloud.qml"),
                                                        {"x": cloudManager.width,
                                                            "y": yOffset,
                                                            "speed": 20 + yOffset/2,
                                                            "cloudNumber": utils.generateRandomValueBetween(1,9)});
    }

}
