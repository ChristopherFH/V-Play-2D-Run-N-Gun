import QtQuick 2.0

Row {
    signal playPressed()
    signal networkPressed()

    spacing: 18
    anchors.horizontalCenter: parent.horizontalCenter
    height: menuItem.height

    MenuButton {
        id: menuItem
        onClicked: {
            playPressed()
        }
        source: "../../assets/img/pixel-art/uipack_fixed/PNG/blue_button03.png"

        Text {
            color: "white"
            anchors.verticalCenterOffset: -parent.height / 10
            text: "play"
            anchors.centerIn: parent
            font.pixelSize: parent.height / 2.5
            font.family: fontloader.name
        }
    }

    MenuButton {
        onClicked: {
            networkPressed()
        }
        source: "../../assets/img/pixel-art/uipack_fixed/PNG/blue_button03.png"

        Text {
            color: "white"
            anchors.verticalCenterOffset: -parent.height / 10
            text: "score"
            anchors.centerIn: parent
            font.pixelSize: parent.height / 2.5
            font.family: fontloader.name
        }
    }
}
