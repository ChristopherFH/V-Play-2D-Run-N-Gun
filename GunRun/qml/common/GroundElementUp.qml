import VPlay 2.0
import QtQuick 2.0

GroundElement {
    id: groundElementUp
    variationType: "up"
    height: 50

    Column {
        Image {
            width: groundElementUp.width
            height: groundElementUp.height/2
            id: image
            anchors.bottom: image2.top
            source: "../../assets/img/tiles/tileBlue_09.png"
        }

        Image {
            width: groundElementUp.width
            height: groundElementUp.height/2
            id: image2
            anchors.top: parent.bottom
            source: "../../assets/img/tiles/tileBlue_18.png"
        }
    }

    PolygonCollider {
        gravityScale: 0.00000
        density: 10000
        fixedRotation: true
        collisionTestingOnlyMode: false
        categories: Box.Category7
        collidesWith: Box.Category12
        vertices: [
            Qt.point(0, 0), // top left
            Qt.point(0, parent.height/2), // bottom left
            Qt.point(parent.width, parent.height/2), // bottom right
            Qt.point(parent.width, -parent.height/2) // top right
      ]
    }

    function getVerticalOffset() {
        return -groundElementUp.height/2
    }

    function getNextTile(random) {
        if(random < 0.5)
            return "Flat"
        return "Up"
    }
}
