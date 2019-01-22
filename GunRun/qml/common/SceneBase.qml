import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../common"

Scene {
    id: sceneBase

    // by default, set the opacity to 0 - this is changed from the main.qml with PropertyChanges
    opacity: 0
    // we set the visible property to false if opacity is 0 because the renderer skips invisible items, this is an performance improvement
    visible: opacity > 0
    // if the scene is invisible, we disable it. In Qt 5, components are also enabled if they are invisible. This means any MouseArea in the Scene would still be active even we hide the Scene, since we do not want this to happen, we disable the Scene (and therefore also its children) if it is hidden
    enabled: visible

    // background
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/img/background/bg_layer1.png"
    }
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/img/background/bg_layer2.png"
    }
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/img/background/bg_layer3.png"
    }
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/img/background/bg_layer4.png"
    }

    // every change in opacity will be done with an animation
    Behavior on opacity {
        NumberAnimation {property: "opacity"; easing.type: Easing.InOutQuad}
    }

}
