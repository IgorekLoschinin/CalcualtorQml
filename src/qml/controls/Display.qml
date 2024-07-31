import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Control {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 80

    Layout.leftMargin: 10
    Layout.rightMargin: 10

    property string outputValue: "0"

    contentItem: TextField {
        id: disOutputText
        anchors.fill: parent

        text: outputValue
        font.pixelSize: 50
        color: "white"

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignTop

        readOnly: true

        background: null
    }
}
