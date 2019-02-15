import VPlay 2.0
import QtQuick 2.0
import "../entities/ground"

EntityBase {
    id: groundManager
    entityType: "groundManager"
    height: 100

    property GroundElement lastElement: null

    property int seed: 1

    property int groundElementId: 1
    property int enemyId: 1
    property int speed: 100
    property int partsize: 25
    property int currentVerticalOffset: 0

    property int newTileEvery: 3
    property int nextTileIn: 0
    property string lastTileType

    RandomGenerator {
        id: randomGenerator
    }

    function start(startSeed) {
        if(typeof startSeed !== "undefined" && startSeed !== null)
            seed = startSeed

        console.log("groundWidth: " + groundManager.x + "/" + groundManager.width)
        randomGenerator.setSeed(seed)
        lastElement = null
        currentVerticalOffset = 0
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(entity) {entity.removeEntity()})

        spawnAt(groundManager.x,"Flat",false)
        while(lastElement.getX() <= groundManager.x + groundManager.width) {
            spawnInitialNext()
        }
        console.log("something")
    }

    function stop() {
        var groundElements = entityManager.getEntityArrayByType("groundElement")
        groundElements.forEach(function(entity) {entity.stop()})
    }

    function spawnInitialNext() {
        spawnAt(lastElement.getX(),"Flat", false)
    }

    function spawnNext(){
        spawnAt(groundManager.x + groundManager.width-1,getNextTile(), true)
    }

    function spawnAt(atX,element, allowEnemy) {
        var atY = lastElement === null ? groundManager.y + currentVerticalOffset : lastElement.getY()

        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/ground/GroundElement"+element+".qml"),
                                                        {"resetX": atX,
                                                            "resetY": atY,
                                                            "nextTo": lastElement,
                                                            "speed": speed,
                                                            "spawnable": ((atX + partsize) >= groundManager.x + groundManager.width),
                                                            "despawnX": groundManager.x,
                                                            "groundWidth": groundManager.x + groundManager.width,
                                                            "entityId": groundElementId++})
        lastElement = entityManager.getLastAddedEntity()
        currentVerticalOffset += lastElement.getVerticalOffset()
        lastElement.spawnNext.connect(spawnNext)

        if(allowEnemy && nextTileIn < newTileEvery - 1 && lastElement.spawnEnemy(randomGenerator.random())) {
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/Dragon.qml"),
                                                            {"resetX": atX,
                                                                "resetY": atY,
                                                                "speed": speed,
                                                                "despawnX": groundManager.x,
                                                                "entityId": enemyId++})
        }
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
