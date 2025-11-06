CREATE TABLE IF NOT EXISTS cartesian_pose (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  robot_ip   TEXT NOT NULL,
  x          REAL NOT NULL,
  y          REAL NOT NULL,
  z          REAL NOT NULL,
  rx         REAL NOT NULL,
  ry         REAL NOT NULL,
  rz         REAL NOT NULL,
  created_at TEXT DEFAULT (datetime('now'))
);
