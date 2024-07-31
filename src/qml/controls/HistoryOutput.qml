import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Control {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 80
    Layout.topMargin: bg.radius

    Layout.leftMargin: 10
    Layout.rightMargin: 10

    property string histValue: "0"

    contentItem: Text {
        id: output
        anchors.fill: parent

        text: histValue
        color: "white"

        font.pointSize: 16
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignBottom
    }
}
