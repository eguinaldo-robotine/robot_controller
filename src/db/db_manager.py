import sqlite3
from pathlib import Path
from functools import lru_cache
from contextlib import contextmanager
from typing import Generator, Any


class DB_Manager:
    def __init__(self, db_name: str = "poses.db"):
        self._base_dir = Path(__file__).resolve().parent
        self._sql_dir = self._base_dir / "../../sql"
        self._migrations_dir = self._sql_dir / "migrations"
        self._db_path = self._base_dir / db_name

    @contextmanager
    def _connect(self) -> Generator[sqlite3.Connection, None, None]:
        connection = sqlite3.connect(self._db_path)
        connection.row_factory = sqlite3.Row
        try:
            yield connection
            connection.commit()
        except Exception:
            connection.rollback()
            raise
        finally:
            connection.close()

    @lru_cache(maxsize=128)
    def load_sql(self, *parts: str) -> str:
        sql_path = self._sql_dir.joinpath(*parts)
        if not sql_path.exists():
            raise FileNotFoundError(f"SQL file not found: {sql_path}")
        return sql_path.read_text(encoding="utf-8")

    def _get_latest_migration(self) -> Path | None:
        migration_files = sorted(self._migrations_dir.glob("*.sql"))
        return migration_files[-1] if migration_files else None

    def apply_latest_migration(self) -> None:
        latest = self._get_latest_migration()
        if not latest:
            print("[DB] No migration found.")
            return
        script = latest.read_text(encoding="utf-8")
        with self._connect() as connection:
            connection.executescript(script)
        print(f"[DB] Applied migration: {latest.name}")

    def execute(self, sql: str, params: dict[str, Any] | None = None) -> None:
        with self._connect() as connection:
            connection.execute(sql, params or {})

    def fetch_one(self, sql: str, params: dict[str, Any] | None = None) -> dict[str, Any] | None:
        with self._connect() as connection:
            result = connection.execute(sql, params or {}).fetchone()
            return dict(result) if result else None

    def fetch_all(self, sql: str, params: dict[str, Any] | None = None) -> list[dict[str, Any]]:
        with self._connect() as connection:
            rows = connection.execute(sql, params or {}).fetchall()
            return [dict(row) for row in rows]

    def init_database(self) -> None:
        print(f"[DB] Starting database: {self._db_path}")
        self.apply_latest_migration()
        print("[DB] Database ready")
