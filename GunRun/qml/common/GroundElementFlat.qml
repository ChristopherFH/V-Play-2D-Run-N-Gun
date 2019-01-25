import VPlay 2.0
import QtQuick 2.0

GroundElement {
    id: groundElementFlat
    variationType: "flat"

    Image {
        width: groundElementFlat.width
        height: groundElementFlat.height
        id: image
        anchors.bottom: parent.bottom
        source: "../../assets/img/tiles/tileBlue_05.png"
    }

    BoxCollider {
        gravityScale: 0.00000
        density: 10000
        fixedRotation: true
        collisionTestingOnlyMode: false
        categories: Box.Category7
        collidesWith: Box.Category12
        width: groundElementFlat.width
        height: groundElementFlat.height
    }

    function getNextTile(random) {
        if(random < 0.33)
            return "Up"
        else if(random < 0.66)
            return "Down"
        return "Flat"
    }
}
