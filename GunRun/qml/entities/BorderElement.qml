import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: border
    entityType: "border"

    Rectangle {
        id: rect
        anchors.fill: border
        color: "red"
    }

    BoxCollider {
        anchors.fill: border
    }

}
