import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"

    property real upwardforce: -280
    property int resetX: 0
    property int resetY: 0

    width: collider.radius * 2
    height: collider.radius * 2


    signal gameOver()

    Component.onCompleted: reset()
    scale: 0.5

    onGameOver: {
        spriteSequence.running = false
    }

    TexturePackerAnimatedSpriteVPlay {
        id: spriteSequenceRun

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        frameRate: 6
        frameNames: [
            "Knight_walk_01.png",
            "Knight_walk_02.png",
            "Knight_walk_03.png",
            "Knight_walk_04.png",
            "Knight_walk_05.png",
            "Knight_walk_06.png"
        ]
        source: "../../assets/img/knight.json"
        rotation: wabbleX.running ? 0 : collider.linearVelocity.y/10
    }

    BoxCollider {
        id: collider
        width: player.width
        height: player.height
        anchors.centerIn: parent
        bodyType: Body.Dynamic
    }

    function reset() {
        player.x = resetX
        player.y = resetY
        collider.body.linearVelocity = Qt.point(0,0)
        activateWabbling()
        spriteSequence.running = true
    }


}
