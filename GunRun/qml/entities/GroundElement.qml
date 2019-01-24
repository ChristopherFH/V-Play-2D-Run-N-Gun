import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: groundElement
    entityType: "groundElement"
    poolingEnabled: true

    width: image.width
    height: image.height

    property double resetX: 0
    property double resetY: 0
    property int speed: 100
    property bool spawnable: false
    property int groundWidth: 0

    //scale: 0.40625 // 26px
    signal spawnNext()

    Component.onCompleted: {
        reset()
    }

    Image {
        width: 25
        height: 25
        id: image
        anchors.bottom: parent.bottom
        source: "../../assets/img/tiles/tileBlue_05.png"
    }

    BoxCollider {
        collisionTestingOnlyMode: true
        categories: Box.Category7
        collidesWith: Box.Category5
        width: groundElement.width
        height: groundElement.height

//        fixture.onEndContact: {
//            var otherItem = other.getBody().target
//            //            console.log("End Contact: " + otherItem.entityId)

//            if(otherItem.entityType === "border") {
//                if(otherItem.entityId === "border-left") {
//                    removeEntity()
//                }
//            }
//        }
    }

    function start() {
        animation.start()
    }

    function stop() {
        animation.stop()
    }

    function reset() {
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
        console.log("initiate spawn")
        spawnNext()
        spawnable = false
        animation.minPropertyValue = -groundElement.width
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
