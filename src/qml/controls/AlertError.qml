import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material


Popup {
    id: popup
    visible: false

    width: parent.width - 20
    height: 40
    x: 10
    y: parent.height - 100 // Начальная позиция

    contentItem: Text {
        text: "Использован недопустимый формат."
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }

    background: Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: 0.8

        radius: 21
    }
}
