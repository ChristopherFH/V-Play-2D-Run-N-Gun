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

    function getVerticalOffset() {
        return -groundElementUp.height/2
    }

    function getNextTile(random) {
        if(random < 0.5)
            return "Flat"
        return "Up"
    }
}
