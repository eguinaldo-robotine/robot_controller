from threading import Lock
from typing import Optional
from fairino import Robot


class RobotSingletonRCP:
    _instance: Optional[Robot.RPC] = None
    _lock = Lock()
    _ip: Optional[str] = None

    def __new__(cls, ip: Optional[str] = None) -> Robot.RPC:
        with cls._lock:
            if cls._instance is None:
                if ip is None:
                    raise ValueError("É necessário informar o IP na primeira conexão.")
                cls._ip = ip
                cls._instance = Robot.RPC(ip)
                print(f"[Robot] Conectado a {ip}")
            elif ip and ip != cls._ip:
                try:
                    if cls._instance is not None:
                        cls._instance.CloseRPC()
                except Exception:
                    pass
                cls._ip = ip
                cls._instance = Robot.RPC(ip)
                print(f"[Robot] Reconectado a {ip}")
            return cls._instance

    @classmethod
    def disconnect(cls) -> None:
        with cls._lock:
            if cls._instance is None:
                return
            try:
                cls._instance.CloseRPC()
                print(f"[Robot] Desconectado de {cls._ip}")
            finally:
                cls._instance = None
                cls._ip = None
