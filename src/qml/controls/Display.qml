import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 80

    Layout.leftMargin: 10
    Layout.rightMargin: 10

    property string outputValue: "0"

    TextField {
        id: disOutputText
        anchors.fill: parent

        text: outputValue
        font.pixelSize: 50
        color: "white"

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignTop

        background: null
    }
}
