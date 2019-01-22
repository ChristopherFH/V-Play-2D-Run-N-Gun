import VPlay 2.0
import QtQuick 2.0

Item {
    id: randomGenerator

    property int m_w: 123456789
    property int m_z: 987654321
    property int mask: 0x7fffffff

    // Takes any integer
    function seed(i) {
        m_w = (123456789 + i) & mask;
        m_z = (987654321 - i) & mask;
    }

    // Returns number between 0 (inclusive) and 1.0 (exclusive),
    // just like Math.random().
    function random()
    {
        m_z = 36969 * (m_z & 65535) + (m_z >> 16);
        m_w = 18000 * (m_w & 65535) + (m_w >> 16);
        var result = (m_z << 16) + m_w;
        return (Math.abs(result) + 1.0) * 2.328306435454494e-10;
    }

}
