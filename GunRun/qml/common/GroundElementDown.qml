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
        anchors.bottom: parent.bottom
        source: "../../assets/img/tiles/tileBlue_10.png"
    }

    Image {
        width: groundElementDown.width
        height: groundElementDown.height/2
        id: image2
        anchors.top: image.bottom
        source: "../../assets/img/tiles/tileBlue_19.png"
    }

    function getVerticalOffset() {
        return groundElementDown.height/2
    }

    function resetHook() {
        resetY -= getVerticalOffset()
    }

    function getNextTile(random) {
        if(random < 0.5)
            return "Flat"
        return "Down"
    }
}
