import VPlay 2.0
import QtQuick 2.0

Item {
    property int speed: 150
    id: ground

    Rectangle {
        id: rect
        anchors.fill: ground
        color: "green"
    }

    Component.onCompleted: {
        console.log("Ground Top: " + ground.top)
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
