import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./controls"


ApplicationWindow {
    title: qsTr("Calculation")
    visible: true
    width: 300
    height: 600

    minimumHeight: 600
    minimumWidth: 300

    function buttonClicked(value) {
        if (displayArea.outputValue === "0") {
            displayArea.outputValue = value
        } else {
            displayArea.outputValue += value
        }
    }

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

                Connections {
                    target: backend

                    function onHistOutput(value) {
                        historyOut.histValue = value
                    }
                }
            }

            // Дисплей
            Display {
                id: displayArea

                Connections {
                    target: backend

                    function onCalExp(exp) {
                        displayArea.outputValue = exp
                    }

                    function onOptChangeSign(expres) {
                        displayArea.outputValue = expres
                    }

                    function onOptPoint(exp) {
                        displayArea.outputValue = exp
                    }
                }
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

            // Область с цифрами и мат операциями
            Keyboard {
                id: numpadGrid
            }

        }

    }

}
