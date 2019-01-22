import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: fireball
    entityType: "projectile"

    scale: 0.3
    width: fireballSprite.width
    height: fireballSprite.height
    property int speed: 350
    property int realFrameRate: 10

    Component.onCompleted: {
        animation.start()
    }

    Component.onDestruction: {
        console.log("Fireball destroyed!")
    }

    TexturePackerSpriteSequenceVPlay {
        id: fireballSprite
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        TexturePackerSpriteVPlay {
            name: "fly"
            source: "../../assets/img/dragon.json"
            frameRate: realFrameRate
            frameNames: [
                "fireball_01.png",
                "fireball_02.png",
                "fireball_03.png"
            ]
            to:{"fly":1}
        }
    }

    BoxCollider {
        collisionTestingOnlyMode: true
        categories: Box.Category2
        collidesWith: Box.Category5 | Box.Category3
        id: collider
        width: fireball.width
        height: fireball.height
        bodyType: Body.Dynamic

        fixture.onBeginContact: {
            console.log("collision started: " + other.getBody().target.entityType)
        }

        fixture.onEndContact: {
            console.log("collision ended: " + other.getBody().target.entityType)
            if(other.getBody().target.entityType === "border")
                removeEntity()
        }
    }

    MovementAnimation {
        id: animation
        target: parent
        property: "x"
        velocity: speed
        running: false
    }
}
