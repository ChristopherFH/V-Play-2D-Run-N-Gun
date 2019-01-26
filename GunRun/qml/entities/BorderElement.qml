import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: border
    entityType: "border"

    BoxCollider {
        gravityScale: 0.0
        density: 10000
        fixedRotation: true
        collisionTestingOnlyMode: false
        categories: Box.Category16
        collidesWith: Box.Category12
        anchors.fill: border

//        Rectangle {
//            id: rect
//            anchors.fill: parent
//            color: "#8000ff00"
//        }
    }

}
