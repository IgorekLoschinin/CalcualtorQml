import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./controls"


ApplicationWindow {
    id: appCalculation
    title: qsTr("Calculation")
    visible: true
    width: 290
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
            anchors.fill: parent

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
