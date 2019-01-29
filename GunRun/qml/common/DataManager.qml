import VPlay 2.0
import VPlayApps 1.0
import QtQuick 2.5
import "../scenes"

App {
    id: app

    height: 0
    width: 0

    property string key: "highscore"

    Storage {
        id: storage
        cacheEnabled: false

        onStorageError: {
            console.debug("there was an error:", errorData.message)
        }
    }

    function loadeValue() {
        return storage.getValue(key)
    }

    function storeValue(value, seed) {
        var jsonString = loadeValue()
        if (jsonString !== undefined) {
            var temp = JSON.parse(jsonString)
            temp.push({
                          distance: value,
                          seed: seed
                      })
            temp.sort(function (a, b) {
                var keyA = parseInt(a.distance), keyB = parseInt(b.distance)
                if (keyA > keyB)
                    return -1
                if (keyA < keyB)
                    return 1
                return 0
            })
            storage.setValue(key, JSON.stringify(temp))
            return
        }
        var model = []
        model.push({
                      distance: value,
                      seed: seed
                  })
        storage.setValue(key, JSON.stringify(model))
    }
}
