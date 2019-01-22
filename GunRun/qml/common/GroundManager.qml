import VPlay 2.0
import QtQuick 2.0

EntityBase {
    property int speed: 150
    id: ground

    property EntityBase borderLeft
    property EntityBase borderRight

    Component.onCompleted: {
        borderLeft = EntityManager.getEntityById("border-left")
        borderRight = EntityManager.getEntityById("border-right")

        createInitialGround()
    }

    Rectangle {
        id: rect
        anchors.fill: ground
        color: "green"
    }

    function createInitialGround() {

    }

//    MovementAnimation {
//        id: animation
//        target: parent
//        property: "x"
//        velocity: -speed
//        running: false
//        minPropertyValue: scene.gameWindowAnchorItem.x-pipeElement.width*1.5
//        onLimitReached: {
//            reset()
//        }
//    }
}
