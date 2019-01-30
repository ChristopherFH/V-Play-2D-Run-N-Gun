import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: fireball
    entityType: "projectile"
    variationType: "good"
    poolingEnabled: true
    z:30

    scale: 0.25
    width: fireballSprite.width
    height: fireballSprite.height
    property int speed: 350
    property int realFrameRate: 10
    property int maxValueX: 2000
    property int minValueX: 0

    property alias sprite: fireballSprite
    property alias movement: animation
    property variant category: Box.Category2
    property variant collidingWith: Box.Category3

    Component.onCompleted: {
        animation.start()
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
        fixedRotation: true
        collisionTestingOnlyMode: true
        categories: category
        collidesWith: collidingWith
        id: collider
        width: parent.width * parent.scale
        height: parent.height * parent.scale
        anchors.top: parent.top
        bullet: true
        bodyType: Body.Dynamic
    }

    MovementAnimation {
        id: animation
        target: parent
        property: "x"
        velocity: speed
        running: false
        maxPropertyValue: maxValueX
        minPropertyValue: minValueX
        onLimitReached: {
            removeEntity()
        }
    }
}
