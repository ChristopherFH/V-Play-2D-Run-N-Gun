import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: cloud
    entityType: "decorative"
    poolingEnabled: true

    scale: 0.4

    property int speed: 50
    property int cloudNumber: 1
    width: cloudImage.width
    height: cloudImage.height

    Component.onCompleted: {
        cloudAnimation.start()
    }

    Image {
        id: cloudImage
        source: "../../assets/img/clouds/cloud"+cloudNumber+".png"
    }

    BoxCollider {
        collisionTestingOnlyMode: true
        categories: Box.Category6
        collidesWith: Box.Category5
        id: collider
        width: cloud.width
        height: cloud.height
        bodyType: Body.Dynamic

        fixture.onBeginContact: {
//            console.log("collision started: " + other.getBody().target.entityType)
        }

        fixture.onEndContact: {
            var collidedEntity = other.getBody().target;

//            console.log("collision ended: " + collidedEntity.entityType)
            if(collidedEntity.entityType === "border" && collidedEntity.entityId === "left")
                removeEntity()
        }
    }


    MovementAnimation {
        id: cloudAnimation
        target: parent
        property: "x"
        velocity: -speed
        running: false
    }
}
