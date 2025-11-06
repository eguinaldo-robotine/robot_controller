import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../atoms"

Rectangle {
    id: positionItem
    width: parent ? parent.width - 20 : 600
    implicitHeight: content.implicitHeight + 24
    radius: 20
    color: "#ffffff"
    border.color: "#e0e0e0"

    property string nameText
    property int poseId
    property var poses

    signal viewClicked(int poseId)
    signal editClicked(int poseId)
    signal deleteClicked(int poseId)

    RowLayout {
        id: content
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        Title { titleText: nameText; font.pixelSize: 16; font.bold: false; color: '#8f8f8f'}
        Item{ Layout.fillWidth: true }
        Tag { text: `X: ${poses.posX}` }
        Tag { text: `Y: ${poses.posY}` }  
        Tag { text: `Z: ${poses.posZ}` }  
        Tag { text: `RX: ${poses.posRX}`; backgroundColor: '#d6ffd7' }  
        Tag { text: `RY: ${poses.posRY}`; backgroundColor: "#d6ffd7"}  
        Tag { text: `RZ: ${poses.posRZ}`; backgroundColor: "#d6ffd7" }  


        RowLayout {
            spacing: 6

            IconBtn {
                iconSource: "../../../assets/icons/industrial-robot.png"
                onClicked: positionItem.viewClicked(poseId)
            }

            IconBtn {
                iconSource: "../../../assets/icons/edit.png"
                onClicked: positionItem.editClicked(poseId)
            }

            IconBtn {
                iconSource: "../../../assets/icons/trash-can.png"
                onClicked: positionItem.deleteClicked(poseId)
            }
        }
    }
}
