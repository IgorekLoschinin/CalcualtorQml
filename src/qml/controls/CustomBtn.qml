import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: customBtn
    anchors.fill: parent

    font.pointSize: 16

    property string bgColorPos1: "#0000"
    property string bgColorPos2: "#0000"

    contentItem: Text {
        text: customBtn.text
        font: customBtn.font
        color: "#d5d5df"
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0.5; color: bgColorPos1 }
            GradientStop { position: 1.0; color: bgColorPos2 }
        }
        border.color: customBtn.down ? bgColorPos2 : bgColorPos1
        border.width: 2.5
        radius: 19
    }
}
