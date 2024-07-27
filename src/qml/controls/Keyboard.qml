import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

GridLayout {
    Layout.fillHeight: true
    Layout.fillWidth: true

    Layout.alignment: Qt.AlignCenter
    Layout.preferredHeight: 385

    Layout.leftMargin: 10
    Layout.rightMargin: 10
    Layout.bottomMargin: bg.radius

    rows: 5
    columns: 4
    rowSpacing: 5
    columnSpacing: 5

    Item {
        id: optClear

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 0
        Layout.column: 0

        CustomBtn {
            text: qsTr("C")

            bgColorPos1: "#474d59"
            bgColorPos2: "#646a7a"

            onClicked: {displayArea.outputValue = 0}
        }
    }

    Item {
        id: optSumDiff

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 0
        Layout.column: 1

        CustomBtn {
            text: qsTr("+/-")

            bgColorPos1: "#474d59"
            bgColorPos2: "#646a7a"

            onClicked: {
                backend.changeSign(displayArea.outputValue)
            }
        }
    }

    Item {
        id: optPercentage

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 0
        Layout.column: 2

        CustomBtn {
            text: qsTr("%")

            bgColorPos1: "#474d59"
            bgColorPos2: "#646a7a"

            onClicked: buttonClicked("%")
        }
    }

    Item {
        id: optDivision

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 0
        Layout.column: 3

        CustomBtn {
            text: qsTr("/")

            bgColorPos1: "#ca5a10"
            bgColorPos2: "#ea860a"

            onClicked: buttonClicked("/")
        }
    }

    Item {
        id: optMultiplication

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 1
        Layout.column: 3

        CustomBtn {
            text: qsTr("x")

            bgColorPos1: "#ca5a10"
            bgColorPos2: "#ea860a"

            onClicked: buttonClicked("x")
        }
    }

    Item {
        id: optDiff

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 2
        Layout.column: 3

        CustomBtn {
            text: qsTr("-")

            bgColorPos1: "#ca5a10"
            bgColorPos2: "#ea860a"

            onClicked: buttonClicked("-")
        }
    }

    Item {
        id: optSum

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 3
        Layout.column: 3

        CustomBtn {
            text: qsTr("+")

            bgColorPos1: "#ca5a10"
            bgColorPos2: "#ea860a"

            onClicked: buttonClicked("+")
        }
    }

    Item {
        id: optEqualse

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 4
        Layout.column: 3

        CustomBtn {
            text: qsTr("=")

            bgColorPos1: "#ca5a10"
            bgColorPos2: "#ea860a"

            onClicked: {
                backend.calculate(displayArea.outputValue)
                backend.history(displayArea.outputValue)
            }
        }
    }

    Item {
        id: optPoint

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 4
        Layout.column: 2

        CustomBtn {
            text: qsTr(".")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: {
                if (displayArea.outputValue === "0") {
                    displayArea.outputValue += "."
                }
            }
        }
    }

    Item {
        id: digit0

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 4
        Layout.column: 0
        Layout.rowSpan: 1
        Layout.columnSpan: 2

        CustomBtn {
            text: qsTr("0")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(0)
        }
    }

    Item {
        id: digit1

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 3
        Layout.column: 0

        CustomBtn {
            text: qsTr("1")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(1)
        }
    }

    Item {
        id: digit2

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 3
        Layout.column: 1

        CustomBtn {
            text: qsTr("2")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(2)
        }
    }

    Item {
        id: digit3

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 3
        Layout.column: 2

        CustomBtn {
            text: qsTr("3")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(3)
        }
    }

    Item {
        id: digit4

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 2
        Layout.column: 0

        CustomBtn {
            text: qsTr("4")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(4)
        }
    }

    Item {
        id: digit5

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 2
        Layout.column: 1

        CustomBtn {
            text: qsTr("5")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(5)
        }
    }

    Item {
        id: digit6

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 2
        Layout.column: 2

        CustomBtn {
            text: qsTr("6")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(6)
        }
    }

    Item {
        id: digit7

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 1
        Layout.column: 0

        CustomBtn {
            text: qsTr("7")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(7)
        }
    }

    Item {
        id: digit8

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 1
        Layout.column: 1

        CustomBtn {
            text: qsTr("8")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(8)
        }
    }

    Item {
        id: digit9

        Layout.fillHeight: true
        Layout.fillWidth: true

        Layout.row: 1
        Layout.column: 2

        CustomBtn {
            text: qsTr("9")

            bgColorPos1: "#363a46"
            bgColorPos2: "#292d36"

            onClicked: buttonClicked(9)
        }
    }

}
