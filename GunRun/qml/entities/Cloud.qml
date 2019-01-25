import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: cloud
    entityType: "cloudElement"
    poolingEnabled: true

    scale: 0.4

    property int speed: 50
    property int cloudNumber: 1
    width: cloudImage.width
    height: cloudImage.height

    Component.onCompleted: {
        cloudAnimation.start()
    }

    Image {
        id: cloudImage
        source: "../../assets/img/clouds/cloud"+cloudNumber+".png"
    }

    function start() {
        cloudAnimation.start()
    }

    function stop() {
        cloudAnimation.stop()
    }

    MovementAnimation {
        id: cloudAnimation
        target: parent
        property: "x"
        velocity: -speed
        running: false
        minPropertyValue: -cloud.width
        onLimitReached: {
            removeEntity()
        }
    }
}
