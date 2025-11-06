from dataclasses import dataclass, asdict
from typing import Optional, Any

@dataclass
class PositionModel:
    id: Optional[int] = None
    name: Optional[Any] = None
    robot_ip: Optional[str] = None 
    x: float = 0
    y: float = 0
    z: float = 0
    rx: float = 0
    ry: float = 0
    rz: float = 0
    created_at: Optional[str] = None 

    def as_dict(self) -> dict:
        return asdict(self)