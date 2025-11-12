import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    width: 220
    color: "#0078d4"

    signal pageSelected(string pageName)
    property string currentPage: "Positions"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Label {
            text: "Robotine"
            color: "white"
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle { height: 1; color: "#2196f3"; Layout.fillWidth: true }

        Repeater {
            model: [
                { label: "Posições", page: "Positions" },
                { label: "Configurações", page: "Settings" },
                { label: "Rotinas", page: "Routines" },
                { label: "Movimentação", page: "Movement" }
            ]
            delegate: Rectangle {
                width: parent.width
                height: 40
                color: sidebar.currentPage === modelData.page ? "#2196f3" : "transparent"

                Text {
                    text: modelData.label
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.color = "#2196f3"
                    onExited: sidebar.currentPage === modelData.page ? parent.color = "#2196f3" : parent.color = "transparent"
                    onClicked: {
                        sidebar.currentPage = modelData.page
                        sidebar.pageSelected(modelData.page)
                    }
                }
            }
        }

        Rectangle { Layout.fillHeight: true; color: "transparent" }
    }

    id: sidebar
}
