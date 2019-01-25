import VPlay 2.0
import QtQuick 2.0

GroundElement {
    id: groundElementDown
    variationType: "down"
    height: 50

    Image {
        width: groundElementDown.width
        height: groundElementDown.height/2
        id: image
        anchors.bottom: image2.top
        source: "../../assets/img/tiles/tileBlue_10.png"
    }

    Image {
        width: groundElementDown.width
        height: groundElementDown.height/2
        id: image2
        anchors.bottom: parent.bottom
        source: "../../assets/img/tiles/tileBlue_19.png"
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
            Qt.point(0, parent.height), // bottom left
            Qt.point(parent.width, parent.height), // bottom right
            Qt.point(parent.width, parent.height/2) // top right
      ]
    }

    function getVerticalOffset() {
        return groundElementDown.height/2
    }

    function getNextTile(random) {
        if(random < 0.5)
            return "Flat"
        return "Down"
    }
}
