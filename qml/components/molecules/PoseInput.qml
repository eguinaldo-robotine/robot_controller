import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: poseInput
    height: 60
    color: "transparent"
    Layout.fillWidth: true
    Layout.fillHeight: true

    property alias value: ipInput.text
    property string nameInput: "Pose"

    ColumnLayout {
        anchors.fill: parent
        spacing: 6

        Label {
            text: nameInput
            color: "#b6b3b3"
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle {
            id: background
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 55
            radius: height / 2
            color: "#ffffff"

            RowLayout {
                id: rowButtons
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                Button {
                    id: fewerButton
                    text: "-"
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40

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
                    text: "0.0"
                    placeholderText: "Digite um número..."
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    color: "#333"
                    background: Rectangle { color: "transparent" }
                }

                Button {
                    id: addButton
                    text: "+"
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40

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
        newValue = Math.round(newValue * 10) / 10
        ipInput.text = newValue.toFixed(2)
        ipInput.placeholderText = newValue.toFixed(2)
    }
}
