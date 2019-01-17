import VPlay 2.0
import QtQuick 2.0

Item {
    width: spriteSequence.width
    height: spriteSequence.height

    SpriteSequenceVPlay {
        id: spriteSequence

        anchors.centerIn: parent

        SpriteVPlay {
            name: "running"

            frameCount: 2
            frameRate: 4

            frameWidth: 552
            frameHeight: 90
            source: "../../assets/img/landSprite.png"

        }
    }

//        Rectangle {
//            anchors.fill: parent
//            color: "#80ff0000"
//        }

    function reset() {
        spriteSequence.running = true
    }

    function stop() {
        spriteSequence.running = false
    }
}
