import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components/organisms"
import "pages"

ApplicationWindow {
    id: mainWindow
    visible: true
    title: "Robotine Controller"

    width: 1600
    height: 900
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    

    Rectangle {
        anchors.fill: parent
        color: "#f5f7fa"

        RowLayout {
            anchors.fill: parent

            Sidebar {
                Layout.preferredWidth: 220
                Layout.fillHeight: true

                onPageSelected: {
                    console.log("Mudando para:", pageName)

                    const pageUrl = Qt.resolvedUrl("pages/" + pageName + "Page.qml")

                    if (stackView.currentItem && stackView.currentItem.source == pageUrl) {
                        console.log("Página já está ativa:", pageUrl)
                        return
                    }

                    if (Qt.resolvedUrl("pages/" + pageName + "Page.qml") !== "") {
                        stackView.push(pageUrl)
                    } else {
                        console.error("Arquivo da página não encontrado:", pageUrl)
                    }
                }

                Component.onCompleted: {
                    pageSelected("Positions")
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 0

                StackView {
                    id: stackView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    initialItem: Qt.resolvedUrl("pages/PositionsPage.qml")
                    clip: true
                    focus: true

                    pushEnter: Transition {
                        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
                    }
                    popExit: Transition {
                        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 200 }
                    }
                }
            }
        }
    }
}
