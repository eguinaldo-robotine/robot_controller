import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../atoms"

import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: toast
    modal: true
    focus: true
    width: 600
    height: 650
    anchors.centerIn: parent

    closePolicy: Popup.CloseOnPressOutside
    
    background: Rectangle {
        width: toast.width
        height: toast.height
        color: '#eeeeee'
        radius: 20
        border.color: "#d0d0d0"
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 180 }
        NumberAnimation { property: "scale"; from: 0.9; to: 1; duration: 180; easing.type: Easing.OutCubic }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 180 }
        NumberAnimation { property: "scale"; from: 1; to: 0.9; duration: 180; easing.type: Easing.InCubic }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        Label {
            text: "Adicionar nova posição"
            color: "#525252"
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
        }

        Rectangle {
            id: background
            Layout.fillWidth: true
            Layout.preferredHeight: 55
            Layout.margins: 12 
            radius: height / 2
            color: "#ffffff"

            property string placeholder: "Insira o nome da posição"

            RowLayout {
                id: row
                anchors.fill: parent
                spacing: 8

                TextField {
                    id: textInput
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 12
                    implicitHeight: 40
                    placeholderText: background.placeholder
                    font.pixelSize: 16
                    color: "#333"
                    verticalAlignment: TextInput.AlignVCenter
                    background: Rectangle { color: "transparent" }
                    padding: 8              
                }
            }
        }

        Rectangle {
            height: 1
            color: '#b8b8b8'
            Layout.fillWidth: true
            Layout.margins: 1
        }

        GridLayout {
            id: grid
            columns: 3
            rowSpacing: 10
            columnSpacing: 10
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.alignment: Qt.AlignHCenter

            PoseInput { id: poseX; nameInput: "Pose X" }
            PoseInput { id: poseY; nameInput: "Pose Y" }
            PoseInput { id: poseZ; nameInput: "Pose Z" }
            PoseInput { id: poseRX; nameInput: "Pose RX" }
            PoseInput { id: poseRY; nameInput: "Pose RY" }
            PoseInput { id: poseRZ; nameInput: "Pose RZ" }
        }

        RowLayout{
            id: positionButtons
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 0

            CommonBtn {
                text: "Posição Atual"
                style: "info"  
            }

            Item{ Layout.fillWidth: true }

            CommonBtn {
                text: "Mover"
                style: "secondary"  
            }

        }

        Rectangle {
            height: 1
            color: '#b8b8b8'
            Layout.fillWidth: true
            Layout.margins: 1
        }

        RowLayout{
            id: buttonsControllers
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter  
            spacing: 0

            CommonBtn {
                text: "Cancelar"
                style: "danger"
                onClicked: toast.close()
            }

            CommonBtn { 
                text: "Editar"
                style: "success"

                onClicked: {
                    if (textInput.text.length === 0) return
                    PositionController.save_pose(
                        textInput.text,
                        parseFloat(poseX.value),
                        parseFloat(poseY.value),
                        parseFloat(poseZ.value),
                        parseFloat(poseRX.value),
                        parseFloat(poseRY.value),
                        parseFloat(poseRZ.value)
                    )
                    textInput.text = ""
                    PositionController.load_poses()
                    toast.close()
                }
            }
        }
    }
}

