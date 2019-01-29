import VPlay 2.0
import QtQuick 2.0

GroundElement {
    id: groundElementFlat
    variationType: "flat"
    width: column.width
    height: column.height

    Column {
        id: column
        Image {
            width: partsize
            height: partsize
            source: "../../assets/img/tiles/tileBlue_05.png"
        }
        Repeater {
            model: 21
            Image {
                width: partsize
                height: partsize
                source: "../../assets/img/tiles/tileBlue_03.png"
            }
        }
    }

    BoxCollider {
        bodyType: Body.Dynamic
        friction: 0.0
        gravityScale: 0.00000
        density: 10000
        fixedRotation: true
        collisionTestingOnlyMode: false
        categories: Box.Category7
        collidesWith: Box.Category12
        width: parent.width
        height: parent.height
    }

    function getNextTile(random) {
        if(random < 0.33)
            return "Up"
        else if(random < 0.66)
            return "Down"
        return "Flat"
    }
}
