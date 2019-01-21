import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../common"

Item {
    id: level

    Ground {
        id: ground
        anchors.horizontalCenter: menuScene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
    }

    function random(seed) {
        var x = Math.sin(seed++) * 10000;
        return x - Math.floor(x);
    }

    function reset() {

    }

    function stop() {

    }

    function start() {

    }
}
