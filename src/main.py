from PySide6.QtCore import QUrl, QDir
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from controllers.position_controller import PositionController
from utils.robot_singleton import RobotSingletonRCP
import sys


def main() -> None:
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    engine.addImportPath(QDir.current().filePath("qml"))

    robot = RobotSingletonRCP("192.168.15.8")
    robot.RobotEnable(True)
    robot.DragTeachSwitch(False)

    controller = PositionController()
    engine.rootContext().setContextProperty("PositionController", controller)

    qml_file = QUrl.fromLocalFile("qml/main.qml")
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
