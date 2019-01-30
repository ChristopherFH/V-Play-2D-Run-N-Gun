import VPlay 2.0
import QtQuick 2.0

GroundManager {
    id: groundManager

    function getNextTile() {
        return "Flat"
    }

    function spawnNext(){
        spawnAt(groundManager.x + groundManager.width-1,getNextTile(), false)
    }
}
