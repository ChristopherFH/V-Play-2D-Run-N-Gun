import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: groundElement
    entityType: "groundElement"
    poolingEnabled: true

    width: 25
    height: 25

    property double resetX: 0
    property double resetY: 0
    property int speed: 100
    property bool spawnable: false
    property int groundWidth: 0

    signal spawnNext()

    Component.onCompleted: {
        reset()
    }

    BoxCollider {
        collisionTestingOnlyMode: true
        categories: Box.Category7
        collidesWith: Box.Category5
        width: groundElement.width
        height: groundElement.height
    }

    function start() {
        animation.start()
    }

    function stop() {
        animation.stop()
    }

    function resetHook(){}

    function reset() {
        resetHook()
        groundElement.x = resetX
        groundElement.y = resetY

        if(spawnable)
            animation.minPropertyValue = groundWidth - groundElement.width
        else
            animation.minPropertyValue = -groundElement.width

        animation.start()
    }

    function getX() {
        return groundElement.x + groundElement.width * groundElement.scale
    }

    function initiateSpawn() {
        spawnNext()
        spawnable = false
        animation.minPropertyValue = -groundElement.width
    }

    function getVerticalOffset() {
        return 0
    }

    MovementAnimation {
        id: animation
        target: groundElement
        property: "x"
        velocity: -speed
        running: false
        onLimitReached: {
            if(spawnable)
                initiateSpawn()
            else
                removeEntity()
        }
    }
}
