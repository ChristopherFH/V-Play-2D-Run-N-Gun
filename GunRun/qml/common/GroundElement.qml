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

    scale: 0.4
    signal spawnNext()

    Component.onCompleted: {
        reset()
    }

    Image {
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

        fixture.onEndContact: {
            var otherItem = other.getBody().target

            console.log("End Contact: " + otherItem.entityId)

            if(otherItem.entityType === "border") {
                if(otherItem.entityId === "border-left") {
                    removeEntity()
                } else {
                    spawnNext()
                }
            }
        }
    }

    function reset() {
        groundElement.x = resetX
        groundElement.y = resetY
        animation.start()
    }

    function getX() {
        return groundElement.x + groundElement.width * groundElement.scale
    }

    MovementAnimation {
        id: animation
        target: groundElement
        property: "x"
        velocity: -speed
        running: false
    }
}
