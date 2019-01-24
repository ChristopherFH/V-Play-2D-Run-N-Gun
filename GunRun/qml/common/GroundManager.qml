import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: groundManager
    entityType: "groundManager"

    property EntityBase borderLeft
    property EntityBase borderRight
    property GroundElement lastElement

    property int groundElementId: 1
    property int speed: 100
    height: 25

    function start() {
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(entity) {entity.removeEntity()})

        borderLeft = entityManager.getEntityById("border-left")
        borderRight = entityManager.getEntityById("border-right")

        spawnAt(0)

        while(lastElement.getX() <= groundManager.width) {
            spawnInitialNext()
        }
    }

    function stop() {
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(entity) {entity.stop()})
    }

    function spawnInitialNext() {
        //        console.log("Spawn next")
        spawnAt(lastElement.getX())
    }

    function spawnNext(){
        spawnAt(groundManager.width)
    }

    function spawnAt(atX) {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./GroundElement.qml"),
                                                        {"resetX": atX,
                                                            "resetY": groundManager.y,
                                                            "speed": speed,
                                                            "spawnable": ((atX + groundManager.height) >= groundManager.width),
                                                            "groundWidth": groundManager.width,
                                                            "entityId": groundElementId++})
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
