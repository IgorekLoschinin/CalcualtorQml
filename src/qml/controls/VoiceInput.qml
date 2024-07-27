import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    hoverEnabled: false

    Layout.preferredHeight: 50
    Layout.preferredWidth: 50

    Layout.topMargin: 15
    Layout.leftMargin: 15
    Layout.rightMargin: 15



    contentItem: Image {
        source: "../../icons/icons8-microphone-48.png"

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        topLeftRadius: bg.radius + 5
        topRightRadius: 30
        bottomRightRadius: 30

        gradient: Gradient {
            GradientStop { position: 0.5; color: "#5a5e67" }
            GradientStop { position: 1.0; color: "#5f6774" }
        }
        border.color: voiceEnter.down ? "#5f6774" : "#5a5e67"
        border.width: 2.5

    }
}
