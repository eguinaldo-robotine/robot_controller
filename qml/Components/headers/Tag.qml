// File: Components/atoms/Tag.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: tag
    radius: height / 2
    implicitHeight: 30
    implicitWidth: textLabel.implicitWidth + 24

    property string text: "Tag"
    property color backgroundColor: '#ececec'
    property color textColor: '#b1b1b1'

    color: backgroundColor

    Text {
        id: textLabel
        anchors.centerIn: parent
        text: tag.text
        color: tag.textColor
        font.pixelSize: 14
        font.bold: false
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
