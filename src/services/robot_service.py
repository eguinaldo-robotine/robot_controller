from typing import Optional
from model.position_model import PositionModel
from repository.position_repository import PositionRepository
from utils.robot_singleton import RobotSingletonRCP
from datetime import datetime

class RobotService:

    def __init__(self):
        self._repo = PositionRepository()

    def get_current_pose(self) -> "PositionModel":
        robot = RobotSingletonRCP()
        result = robot.GetActualTCPPose()
        timestamp = datetime.now().isoformat()
        ip_result = robot.GetControllerIP()

        if isinstance(result, tuple):
            error, pose = result
            x, y, z, rx, ry, rz = pose
        else:
            error = result
            x = y = z = rx = ry = rz = 0.0

        ip = ip_result[1] if isinstance(ip_result, tuple) else "0.0.0.0"

        return PositionModel(
            id=None,
            name='nome do ponto',
            x=float(x),
            y=float(y),
            z=float(z),
            rx=float(rx),
            ry=float(ry),
            rz=float(rz),
            created_at=timestamp
        )
        
    def get_sdk_version(self):
        robot = RobotSingletonRCP()
        return robot.GetSDKVersion()

    def save_current_pose(self, robotModel: PositionModel):
        robotModel.id = 1
        robotModel.name = "nome do ponto"
        self._repo.insert_pose(robotModel)    

    def move(self, points: PositionModel):
        
        robot = RobotSingletonRCP()
        timestamp = datetime.now().isoformat()
        ip_result = robot.GetControllerIP()

        print("Pontos recebidos para mover o robo:", points)
        print("IP do robo:", ip_result)
        print("Timestamp da operacao:", timestamp)
        print("Iniciando movimento...")

        desc_pos1 = [points.x, 
                     points.y, 
                     points.z, 
                     points.rx, 
                     points.ry, 
                     points.rz
                     ]
        
        result = robot.GetInverseKin(desc_pos = desc_pos1, type = 0, config = -1)
        if(isinstance(result, tuple)):
            error, position = result
            if(error != 0): return False
            success = robot.MoveJ(joint_pos = position, tool = 1, user = 2, vel = 200)
            print("Movendo o robo para a posicao salva", success)
            return bool(success == 0)