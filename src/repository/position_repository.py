from db.db_manager import DB_Manager
from model.position_model import PositionModel

class PositionRepository:
    def __init__(self):
        self.db = DB_Manager()

    def get_all_poses(self) -> list[PositionModel]:
        sql = self.db.load_sql("poses", "select_all.sql")
        rows = self.db.fetch_all(sql)
        return [PositionModel(**row) for row in rows]

    def insert_pose(self, pose: PositionModel) -> None:
        sql = self.db.load_sql("poses", "insert_pose.sql")
        self.db.execute(sql, {
            "robot_ip": pose.robot_ip,
            "name": pose.name,  
            "x": pose.x,
            "y": pose.y,
            "z": pose.z,
            "rx": pose.rx,
            "ry": pose.ry,
            "rz": pose.rz
        })

    def delete_all_poses(self) -> None:
        sql = self.db.load_sql("poses", "delete_all.sql")
        self.db.execute(sql)
    
    def delete_pose(self, name) -> None:
        sql = self.db.load_sql("poses", "delete_pose.sql")
        self.db.execute(sql, {
            "name": name
        })
      
    def update_pose(self, pose: PositionModel, actualName: str) -> None:
        sql = self.db.load_sql("poses", "update_pose.sql")
        self.db.execute(sql, {
            "actualName": actualName,
            "name": pose.name,
            "x": pose.x,
            "y": pose.y,
            "z": pose.z,
            "rx": pose.rx,
            "ry": pose.ry,
            "rz": pose.rz
        })
