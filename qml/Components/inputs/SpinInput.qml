import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: spinInput
    Layout.fillWidth: true

    readonly property int titleH: 20
    readonly property int inputH: 48
    readonly property int vGap: 6
    implicitHeight: titleH + vGap + inputH
    Layout.preferredHeight: implicitHeight

    property alias value: ipInput.text
    property string nameInput: "Pose"

    ColumnLayout {
        anchors.fill: parent
        spacing: vGap

        Label {
            text: nameInput
            color: "#b6b3b3"
            font.pixelSize: 14
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: titleH
        }

        Rectangle {
            id: background
            Layout.fillWidth: true
            Layout.preferredHeight: inputH
            radius: height / 2
            color: "#ffffff"
            border.color: "#e6e6e6"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                Button {
                    id: fewerButton
                    text: "-"
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 32
                    background: Rectangle {
                        radius: height / 2
                        color: fewerButton.down ? "#17807E"
                              : fewerButton.hovered ? "#20B2AA"
                              : "#1CA8A4"
                    }
                    contentItem: Text {
                        text: fewerButton.text
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                        font.pixelSize: 18
                        font.bold: true
                    }
                    onClicked: updateValue(-0.1)
                }

                TextField {
                    id: ipInput
                    Layout.fillWidth: true
                    text: "0.00"
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    validator: DoubleValidator { bottom: -1000; top: 1000; decimals: 2 }
                    placeholderText: "0.00"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    color: "#333"
                    background: Rectangle { color: "transparent" }
                    onEditingFinished: updateValue(0)
                }

                Button {
                    id: addButton
                    text: "+"
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 32
                    background: Rectangle {
                        radius: height / 2
                        color: addButton.down ? "#17807E"
                              : addButton.hovered ? "#20B2AA"
                              : "#1CA8A4"
                    }
                    contentItem: Text {
                        text: addButton.text
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                        font.pixelSize: 18
                        font.bold: true
                    }
                    onClicked: updateValue(0.1)
                }
            }
        }
    }

    function updateValue(delta) {
        var current = parseFloat(ipInput.text || "0") || 0
        var newValue = current + delta
        newValue = Math.round(newValue * 100) / 100
        ipInput.text = newValue.toFixed(2)
        ipInput.placeholderText = newValue.toFixed(2)
    }
}
