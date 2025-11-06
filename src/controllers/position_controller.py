from PySide6.QtCore import QObject, Slot, Signal
from repository.position_repository import PositionRepository
from model.position_model import PositionModel
from services.robot_service import RobotService

_SERVICE = RobotService()

class PositionController(QObject):
    posesLoaded = Signal(list)
    currentPoseLoaded = Signal(dict)

    def __init__(self):
        super().__init__()
        self.repo = PositionRepository()
    
    @Slot()
    def get_current_pose(self): 
        position_model = _SERVICE.get_current_pose()
        if position_model:
            self.currentPoseLoaded.emit(position_model.as_dict())

    @Slot(str, float, float, float, float, float, float)
    def move_j(self, name, x, y, z, rx, ry, rz): 
        points = PositionModel(
            id=None,
            name=name,
            robot_ip="192.168.15.8",
            x=x,
            y=y,
            z=z,
            rx=rx,
            ry=ry,
            rz=rz
        )

        _SERVICE.move(points)

    @Slot()
    def load_poses(self):
        poses = self.repo.get_all_poses()
        self.posesLoaded.emit([pose.as_dict() for pose in poses])

    @Slot()
    def delete_all_poses(self):
        self.repo.delete_all_poses()
        self.load_poses()

    @Slot(str)
    def delete_pose(self, name):
        self.repo.delete_pose(name)
        self.load_poses()

    @Slot(str, float, float, float, float, float, float)
    def save_pose(self, name, x, y, z, rx, ry, rz): 
        poses = self.repo.get_all_poses()  
        for p in poses:
            if p.name == name:
                return
            
        pose = PositionModel(
            id=None,
            name=name,
            robot_ip="192.168.15.8", 
            x=x,
            y=y,
            z=z,
            rx=rx,
            ry=ry,
            rz=rz,
            created_at=None
        )
        self.repo.insert_pose(pose)
        self.load_poses()

    @Slot( str, str, float, float, float, float, float, float)
    def update_pose(self,actualName, name, x, y, z, rx, ry, rz):

        if actualName != name:
            poses = self.repo.get_all_poses()  
            for p in poses:
                if p.name == name:
                    return
                
        pose = PositionModel(
            id=None,
            name=name,
            robot_ip="192.168.15.8",
            x=x, 
            y=y, 
            z=z,
            rx=rx, 
            ry=ry, 
            rz=rz
        )
        self.repo.update_pose(pose, actualName)
        self.load_poses()

