import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: fireball
    entityType: "projectile"

    width: collider.radius * 2
    height: collider.radius * 2
    property int frameRate: 10

    TexturePackerSpriteSequenceVPlay {
        id: fireballSprite
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        TexturePackerSpriteVPlay {
            name: "fly"
            source: "../../assets/img/dragon.json"
            frameRate: frameRate
            frameNames: [
                "fireball_01.png",
                "fireball_02.png",
                "fireball_03.png"
            ]
            to:{"fly":1}
        }
    }

    BoxCollider {
        id: collider
        width: fireball.width
        height: fireball.height
        anchors.centerIn: parent
        bodyType: Body.Dynamic
    }

}
