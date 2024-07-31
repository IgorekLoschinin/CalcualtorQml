import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Control {
    id: keybord

    Layout.fillHeight: true
    Layout.fillWidth: true

    Layout.preferredHeight: 385

    Layout.leftMargin: 10
    Layout.rightMargin: 10
    Layout.bottomMargin: bg.radius - 1

    function procMatOpt(operation) {

        let expression = displayArea.outputValue + operation;
        let result = expression.match(/([+\-x%\/]*)$/)[0];

        if (result.length === 1) {
            displayArea.outputValue += operation;
            return

        } else if (result.length === 2) {
            if (result[0] === "%") {
                displayArea.outputValue += operation;
                return
            }

            displayArea.outputValue = displayArea.outputValue.slice(0, -1) + operation;
            return
        }

    }

    function btnDigitClicked(value) {
        let replZero = displayArea.outputValue.match(/([+\-x%)\/]*0)$/);

        if (displayArea.outputValue === "0") {
            displayArea.outputValue = value
            return

        } else if (displayArea.outputValue === historyOut.histValue) {
            displayArea.outputValue = value
            return

        } else if (replZero !== null && replZero[0].endsWith("0")) {
            displayArea.outputValue = displayArea.outputValue.slice(0, -1) + value;
            return

        } else {
            displayArea.outputValue += value
        }

        return
    }


    contentItem: GridLayout {
        uniformCellHeights: true
        uniformCellWidths: true

        rows: 5
        columns: 4
        rowSpacing: 5
        columnSpacing: 5

        Repeater {
            model: ListModel {
                ListElement {
                    name: qsTr("C")

                    bgColorPos1: "#474d59"
                    bgColorPos2: "#646a7a"
                }
                ListElement {
                    name: qsTr("+/-")

                    bgColorPos1: "#474d59"
                    bgColorPos2: "#646a7a"
                }
                ListElement {
                    name: qsTr("%")

                    bgColorPos1: "#474d59"
                    bgColorPos2: "#646a7a"
                }
                ListElement {
                    name: qsTr("/")

                    bgColorPos1: "#ca5a10"
                    bgColorPos2: "#ea860a"
                }
                ListElement {
                    name: qsTr("7")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("8")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("9")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("x")

                    bgColorPos1: "#ca5a10"
                    bgColorPos2: "#ea860a"
                }
                ListElement {
                    name: qsTr("4")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("5")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("6")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("-")

                    bgColorPos1: "#ca5a10"
                    bgColorPos2: "#ea860a"
                }
                ListElement {
                    name: qsTr("1")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("2")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("3")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("+")

                    bgColorPos1: "#ca5a10"
                    bgColorPos2: "#ea860a"
                }
                ListElement {
                    name: qsTr("0")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"

                    layoutRowSpan: true
                    layoutColumnSpan: true

                }
                ListElement {
                    name: qsTr(".")

                    bgColorPos1: "#363a46"
                    bgColorPos2: "#292d36"
                }
                ListElement {
                    name: qsTr("=")

                    bgColorPos1: "#ca5a10"
                    bgColorPos2: "#ea860a"
                }
            }

            delegate: CustomBtn {
                text: model.name

                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.rowSpan: {
                    if (model.layoutRowSpan) {
                        return 1
                    }
                    return true
                }
                Layout.columnSpan: {
                    if (model.layoutColumnSpan) {
                        return 2
                    }
                    return true
                }

                bgColorPos1: model.bgColorPos1
                bgColorPos2: model.bgColorPos2

                onClicked: {
                    switch (model.name) {
                    case "C": displayArea.outputValue = 0
                        return

                    case "+/-": backend.changeSign(displayArea.outputValue)
                        return

                    case "%": procMatOpt("%")
                        return

                    case "/": procMatOpt("/")
                        return

                    case "x": procMatOpt("x")
                        return

                    case "-": procMatOpt("-")
                        return

                    case "+": procMatOpt("+")
                        return

                    case "=":
                        backend.calculate(displayArea.outputValue)
                        backend.history(displayArea.outputValue)
                        return

                    case ".": backend.addPoint(displayArea.outputValue)
                        return

                    case "0": btnDigitClicked(0)
                        return

                    case "1": btnDigitClicked(1)
                        return

                    case "2": btnDigitClicked(2)
                        return

                    case "3": btnDigitClicked(3)
                        return

                    case "4": btnDigitClicked(4)
                        return

                    case "5": btnDigitClicked(5)
                        return

                    case "6": btnDigitClicked(6)
                        return

                    case "7": btnDigitClicked(7)
                        return

                    case "8": btnDigitClicked(8)
                        return

                    case "9": btnDigitClicked(9)
                        return
                    }
                }
            }
        }
    }
}

