import VPlay 2.0
import QtQuick 2.0

Item {
    id: button

    signal clicked
    signal pressed
    signal released

    width: 100
    height: 20

    property alias source: sprite.source

    MultiResolutionImage {
        height: parent.height
        width: parent.width
        id: sprite
    }

    MouseArea {
        id: mouseArea
        enabled: button.enabled
        anchors.fill: button
        hoverEnabled: true

        onClicked: button.clicked()
        onPressed: button.pressed()
        onReleased: button.released()
    }

    onClicked: {
    }

    onPressed: {
        opacity = 0.5
    }

    onReleased: {
        opacity = 1.0
    }
}
