import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: border
    entityType: "border"



    BoxCollider {
        collisionTestingOnlyMode: true
        categories: Box.Category5
        collidesWith: Box.Category2
        anchors.fill: border

        Rectangle {
            id: rect
            anchors.fill: parent
            color: "#8000ff00"
        }
    }

}
