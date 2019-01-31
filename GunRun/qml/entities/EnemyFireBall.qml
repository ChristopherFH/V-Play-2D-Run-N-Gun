import VPlay 2.0
import QtQuick 2.0

FireBall {
    id: fireBall
    variationType: "bad"
    scale: 0.15

    Component.onCompleted: {
        category = Box.Category11
        collidingWith = Box.Category12
        speed = -speed
        sprite.mirrorX = true
        movement.start()
    }
}
