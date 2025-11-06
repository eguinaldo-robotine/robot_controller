import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
 
Button {
    id: control
    text: "button"

    property string style: "primary"
    readonly property var colorPalette: ({
        primary:  { normal: "#007BFF", hover: "#0069D9", press: "#0056B3" },
        success:  { normal: "#28A745", hover: "#218838", press: "#1E7E34" },
        warning:  { normal: "#FFC107", hover: "#E0A800", press: "#D39E00" },
        danger:   { normal: "#DC3545", hover: "#C82333", press: "#BD2130" },
        info:     { normal: "#17A2B8", hover: "#138496", press: "#117A8B" },
        secondary:{ normal: "#6C757D", hover: "#5A6268", press: "#545B62" }
    })

    Layout.alignment: Qt.AlignLeft
    Layout.preferredWidth: 130
    Layout.preferredHeight: 50
    Layout.margins: 20

    background: Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: control.down
            ? control.colorPalette[control.style].press
            : control.hovered
                ? control.colorPalette[control.style].hover
                : control.colorPalette[control.style].normal
    }

    contentItem: Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment:   Text.AlignVCenter
        text: control.text
        color: "white"
        font.pixelSize: 16
        elide: Text.ElideRight
    }
}