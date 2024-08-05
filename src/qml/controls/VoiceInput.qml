import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    hoverEnabled: false

    Layout.topMargin: 15
    Layout.leftMargin: 15
    Layout.rightMargin: 15

    contentItem: ColorImage {
        source: "../../icons/microphone-svgrepo-com.svg"

        fillMode: Image.PreserveAspectFit
        anchors.centerIn: bgBtnVI
        sourceSize.height: 25
        color: "white"
    }

    background: Rectangle {
        id: bgBtnVI

        width: 55
        height: 40

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
