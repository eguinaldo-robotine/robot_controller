import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../components/organisms"

Rectangle {
    id: topBar
    height: 80
    color: "transparent"
    Layout.fillWidth: true

    ColumnLayout {
        id: column
        anchors.margins: 10
        spacing: 10
        width: parent.width

        ListPosition {
            Layout.fillWidth: true
            Layout.fillHeight: true 
            Layout.margins: 30
        }
    }
}
