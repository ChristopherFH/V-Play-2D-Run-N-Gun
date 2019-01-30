import VPlay 2.0
import QtQuick 2.0

GroundElement {
    id: groundElementUp
    variationType: "up"
    width: column.width
    height: column.height
    property alias colliderAlias: collider

    Column {
        id: column
        Image {
            width: partsize
            height: partsize
            source: "../../assets/img/tiles/tileBlue_09.png"
        }
        Image {
            width: partsize
            height: partsize
            source: "../../assets/img/tiles/tileBlue_18.png"
        }
        Repeater {
            model: 20
            Image {
                width: partsize
                height: partsize
                source: "../../assets/img/tiles/tileBlue_03.png"
            }
        }
    }

    PolygonCollider {
        id: collider
        bodyType: Body.Dynamic
        friction: 0.0
        gravityScale: 0.00000
        density: 10000
        fixedRotation: true
        collisionTestingOnlyMode: false
        categories: Box.Category7
        collidesWith: Box.Category12
        vertices: [
            Qt.point(0, partsize), // top left
            Qt.point(0, parent.height), // bottom left
            Qt.point(parent.width, parent.height), // bottom right
            Qt.point(parent.width, 0) // top right
        ]
    }

    function resetHook() {
        resetY += getVerticalOffset()
    }

    function getVerticalOffset() {
        return -partsize
    }

    function getY() {
        return groundElementUp.y
    }

    function getNextTile(random) {
        if(random < 0.5)
            return "Flat"
        return "Up"
    }
}
