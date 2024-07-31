import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./controls"


ApplicationWindow {
    id: appCalculation
    title: qsTr("Calculation")
    visible: true
    width: 300
    height: 600

    minimumHeight: 600
    minimumWidth: 300

    Rectangle {
        id: bg
        anchors.fill: parent

        radius: 42
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#24292f" }
            GradientStop { position: 1.0; color: "#1e1f24" }
        }

        ColumnLayout {
            spacing: 2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            // Голосовой ввод с иконкой
            VoiceInput {
                id: voiceEnter
            }

            // Вывод истории
            HistoryOutput {
                id: historyOut
            }

            // Дисплей
            Display {
                id: displayArea
            }

            // Разделительная линия
            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.bottomMargin: 10
                Layout.leftMargin: 10
                Layout.rightMargin: 10

                height: 0.5
                border.color: "#b8bbc2"
            }

            Keyboard {
                id: numpadGrid
            }

            AlertError {
                id: popup
            }
        }

    }

    Connections {
        target: backend

        function onCalExp(exp) {
            displayArea.outputValue = exp
        }

        function onErrMsgSig(flag) {
            if (!flag) {
                popup.open()
            }

        }

        function onOptChangeSign(expres) {
            displayArea.outputValue = expres
        }

        function onOptPoint(exp) {
            displayArea.outputValue = exp
        }

        function onHistOutput(value) {
            historyOut.histValue = value
        }

    }

}
