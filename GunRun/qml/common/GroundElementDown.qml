import VPlay 2.0
import QtQuick 2.0

GroundElement {
    id: groundElementDown
    variationType: "down"
    width: column.width
    height: column.height

    Column {
        id: column
        Image {
            width: partsize
            height: partsize
            source: "../../assets/img/tiles/tileBlue_10.png"
        }

        Image {
            width: partsize
            height: partsize
            source: "../../assets/img/tiles/tileBlue_19.png"
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
        bodyType: Body.Static
        friction: 0.0
        gravityScale: 0.00000
        density: 10000
        fixedRotation: true
        collisionTestingOnlyMode: false
        categories: Box.Category7
        collidesWith: Box.Category12
        vertices: [
            Qt.point(0, 0), // top left
            Qt.point(0, parent.height), // bottom left
            Qt.point(parent.width, parent.height), // bottom right
            Qt.point(parent.width, partsize) // top right
        ]
    }

    function getVerticalOffset() {
        return partsize
    }

    function getNextTile(random) {
        if(random < 0.5)
            return "Flat"
        return "Down"
    }
}
