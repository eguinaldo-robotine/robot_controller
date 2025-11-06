ALTER TABLE cartesian_pose RENAME TO old_cartesian_pose;

CREATE TABLE cartesian_pose (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  name       TEXT NOT NULL,
  x          REAL NOT NULL,
  y          REAL NOT NULL,
  z          REAL NOT NULL,
  rx         REAL NOT NULL,
  ry         REAL NOT NULL,
  rz         REAL NOT NULL,
  created_at TEXT DEFAULT (datetime('now'))
);

INSERT INTO cartesian_pose (id, name, x, y, z, rx, ry, rz, created_at)
SELECT id, name, x, y, z, rx, ry, rz, created_at
FROM old_cartesian_pose;

DROP TABLE old_cartesian_pose;
