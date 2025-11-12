import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15 
import Components 1.0

Rectangle {
    id: positionController
    Layout.fillWidth: true
    Layout.preferredHeight: 800
    radius: 30
    color: "transparent"

    ListModel { id: savedPositionsModel }

    Component.onCompleted: PositionController.load_poses()

    Connections {
        target: PositionController
        function onPosesLoaded(poses) {
            savedPositionsModel.clear()
            for (let pose of poses) {
                savedPositionsModel.append({
                    id: pose.id,
                    name: pose.name,
                    poses: {
                        posX: pose.x,
                        posY: pose.y,
                        posZ: pose.z,
                        posRX: pose.rx,
                        posRY: pose.ry,
                        posRZ: pose.rz
                    }
                })
            }
        }
    }

    PositionPopup {
        id: addPositionPopup
        onMainButtonClicked: {
            PositionController.save_pose(
                positionName,
                parseFloat(poseXValue),
                parseFloat(poseYValue),
                parseFloat(poseZValue),
                parseFloat(poseRXValue),
                parseFloat(poseRYValue),
                parseFloat(poseRZValue)
            )
            PositionController.load_poses()
        }
    }

    PositionPopup {
        id: editPositionPopup
        mainButtonText: "Editar"
        onMainButtonClicked: {
            PositionController.update_pose(
                actualPositionName,
                positionName,
                parseFloat(poseXValue),
                parseFloat(poseYValue),
                parseFloat(poseZValue),
                parseFloat(poseRXValue),
                parseFloat(poseRYValue),
                parseFloat(poseRZValue)
            )
            PositionController.load_poses()
        }
    }

    ColumnLayout {
        id: column
        anchors.fill: parent
        Layout.margins: 30

        Title { Layout.alignment: Qt.AlignJustify; titleText: "Lista de Posições" }

        RowLayout {
            id: buttonsControllers
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignJustify
            spacing: 0

            TextInputBar {
                id: positionInputBar
                buttonName: "Pesquisar"
                placeholder: "Insira o nome da posição"
            }

            CommonBtn {
                text: "Nova Posição"
                style: "primary"
                onClicked: {
                    addPositionPopup.openWith("", "", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                }
            }
        }

        Rectangle {
            height: 2
            color: "#b8b8b8"
            Layout.fillWidth: true
            Layout.margins: 5
        }

        ListView {
            id: savedPositionsList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: savedPositionsModel
            spacing: 12
            clip: true

            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

            delegate: PositionItem {
                nameText: name
                poses: model.poses

                onViewClicked: (itemId) => {
                    console.log("Ver posição", name)
                }

                onEditClicked: (itemId) => {
                    editPositionPopup.openWith(
                        itemId,
                        name,
                        poses.posX,
                        poses.posY,
                        poses.posZ,
                        poses.posRX,
                        poses.posRY,
                        poses.posRZ
                    )
                }

                onDeleteClicked: (itemId) => {
                    PositionController.delete_pose(name)
                }
            }
        }

        CommonBtn {
            text: "Deletar Lista"
            style: "danger"
            onClicked: {
               PositionController.delete_all_poses()
               PositionController.load_poses()
            }
        }
    }
}
