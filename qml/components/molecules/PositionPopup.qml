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

    property string mainButtonText: "Salvar"
    property var poses
    property string actualPositionName: ""
    property string id: ""
    property alias positionName: textInput.text
    property alias poseXValue: poseX.value
    property alias poseYValue: poseY.value
    property alias poseZValue: poseZ.value   
    property alias poseRXValue: poseRX.value
    property alias poseRYValue: poseRY.value
    property alias poseRZValue: poseRZ.value   

    signal mainButtonClicked()
    
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

    Connections {
        target: PositionController

        function onCurrentPoseLoaded(pose) {
            textInput.text = actualPositionName
            poseX.value = pose.x.toFixed(2)
            poseY.value = pose.y.toFixed(2)
            poseZ.value = pose.z.toFixed(2)
            poseRX.value = pose.rx.toFixed(2)
            poseRY.value = pose.ry.toFixed(2)
            poseRZ.value = pose.rz.toFixed(2)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        Label {
            text: `${mainButtonText} nova posição`
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

            PoseInput { id: poseX; nameInput: "Pose X"; value: poses ? `${poses.posX}` : "0.0"}
            PoseInput { id: poseY; nameInput: "Pose X"; value: poses ? `${poses.posY}`: "0.0"}
            PoseInput { id: poseZ; nameInput: "Pose X"; value: poses ? `${poses.posZ}`: "0.0"}
            PoseInput { id: poseRX; nameInput: "Pose RX"; value: poses ? `${poses.posRX}`: "0.0"}
            PoseInput { id: poseRY; nameInput: "Pose RY"; value: poses ? `${poses.posRY}`: "0.0"}
            PoseInput { id: poseRZ; nameInput: "Pose RZ"; value: poses ? `${poses.posRZ}`: "0.0"}
        }

        RowLayout{
            id: positionButtons
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 0

            CommonBtn {
                text: "Posição Atual"
                style: "info"  
                onClicked: {
                    PositionController.get_current_pose()
                }
            }

            Item{ Layout.fillWidth: true }

            CommonBtn {
                text: "Mover"
                style: "secondary"  
                onClicked: {
                    PositionController.move_j(
                        textInput.text,
                        parseFloat(poseX.value),
                        parseFloat(poseY.value),
                        parseFloat(poseZ.value),
                        parseFloat(poseRX.value),
                        parseFloat(poseRY.value),
                        parseFloat(poseRZ.value)
                    )
                }
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
                text: mainButtonText
                style: "success"

                onClicked: {
                    if (textInput.text.length === 0) return
                    mainButtonClicked()  
                    toast.close()
                }
            }
        }
    }
}

