from PySide6.QtQml import QQmlApplicationEngine
from controllers.position_controller import PositionController
from controllers.robot_controller import RobotController

class ControllerManager:
    def __init__(self, engine: QQmlApplicationEngine):
        self.engine = engine
        self._controllers = {}

        self._register_controllers()

    def _register_controllers(self):

        self._controllers["PositionController"] = PositionController()
        self._controllers["RobotController"] = RobotController()

        for name, instance in self._controllers.items():
            self.engine.rootContext().setContextProperty(name, instance)

    def get(self, name: str):
        return self._controllers.get(name)
