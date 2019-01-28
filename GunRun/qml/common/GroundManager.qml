import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: groundManager
    entityType: "groundManager"

    property GroundElement lastElement: null

    property int seed: 1

    property int groundElementId: 1
    property int speed: 100
    height: 25
    property int currentVerticalOffset: 0

    property int newTileEvery: 3
    property int nextTileIn: 0
    property string lastTileType

    RandomGenerator {
        id: randomGenerator
    }

    function start() {
        randomGenerator.setSeed(seed)
        lastElement = null
        currentVerticalOffset = 0
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(entity) {entity.removeEntity()})

        spawnAt(0,"Flat")
        while(lastElement.getX() <= groundManager.width) {
            spawnInitialNext()
        }
    }

    function stop() {
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(entity) {entity.stop()})
    }

    function spawnInitialNext() {
        spawnAt(lastElement.getX(),"Flat")
    }

    function spawnNext(){
        spawnAt(groundManager.width-1,getNextTile())
    }

    function spawnAt(atX,element) {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./GroundElement"+element+".qml"),
                                                        {"resetX": atX,
                                                         "resetY": lastElement === null ? groundManager.y + currentVerticalOffset : lastElement.getY(),
                                                         "speed": speed,
                                                         "spawnable": ((atX + groundManager.height) >= groundManager.width),
                                                         "despawnX": groundManager.x,
                                                         "groundWidth": groundManager.width,
                                                         "entityId": groundElementId++})
        lastElement = entityManager.getLastAddedEntity()
        currentVerticalOffset += lastElement.getVerticalOffset()
        lastElement.spawnNext.connect(spawnNext)
    }

    function getNextTile() {
        if(nextTileIn === 0) {
            nextTileIn = newTileEvery - 1
            var random = randomGenerator.random()
            var tempTile = lastTileType
            lastTileType = lastElement.getNextTile(random)
        } else {
            nextTileIn--
        }
        return lastTileType
    }
}
