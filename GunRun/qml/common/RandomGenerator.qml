import VPlay 2.0
import QtQuick 2.0

Item {
    id: randomGenerator
    property int seed: 123456789

    // Takes any integer
    function setSeed(i) {
        seed = i % 2147483647
        if(seed <= 0)
            seed += 2147483646
    }

    // Returns number between 0 (inclusive) and 1.0 (exclusive),
    // just like Math.random().
    function random() {
        return next() / 2147483646
    }

    function next() {
        seed = (seed * 16807) % 2147483647
        return seed
    }

}
