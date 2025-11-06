import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Label {
    property string titleText: "Title"
    id: title
    text: titleText
    color: '#525252'
    font.bold: true
    font.pixelSize: 36
    Layout.alignment: Qt.AlignHCenter
    Layout.topMargin:20
    Layout.margins: 20
}