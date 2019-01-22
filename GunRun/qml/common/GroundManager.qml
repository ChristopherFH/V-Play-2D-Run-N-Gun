import VPlay 2.0
import QtQuick 2.0

EntityBase {
    property int speed: 150
    id: groundManager
    entityType: "groundManager"

    property EntityBase borderLeft
    property EntityBase borderRight
    property GroundElement lastElement

    property bool stopped: false


    function start() {
        borderLeft = entityManager.getEntityById("border-left")
        borderRight = entityManager.getEntityById("border-right")

        spawnAt(0)

        while(lastElement.getX() <= (borderRight.x + borderRight.width)) {
            spawnNext()
        }
    }

    function stop() {
        stopped = true
    }

    function spawnNext() {
//        console.log("Spawn next")
        if(!stopped)
            spawnAt(lastElement.getX())
    }

    function spawnAt(atX) {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./GroundElement.qml"),{"resetX": atX ,"resetY": groundManager.y})
        lastElement = entityManager.getLastAddedEntity()
        lastElement.spawnNext.connect(spawnNext)
    }


//    MovementAnimation {
//        id: animation
//        target: parent
//        property: "x"
//        velocity: -speed
//        running: false
//        minPropertyValue: scene.gameWindowAnchorItem.x-pipeElement.width*1.5
//        onLimitReached: {
//            reset()
//        }
//    }
}
