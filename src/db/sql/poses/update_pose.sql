UPDATE cartesian_pose
SET 
    name = :name,
    x = :x,
    y = :y,
    z = :z,
    rx = :rx,
    ry = :ry,
    rz = :rz
WHERE name = :actualName
