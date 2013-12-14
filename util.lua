util = {}

function util.gridToPosition(x, y)

    return (x - 0.5) * Tile.SIZE

end

function util.rectPointIntersect(ax, ay, bx, by, cx, cy)
    left   = math.min(ax, bx)
    top    = math.min(ay, by)
    right  = math.max(ax, bx)
    bottom = math.max(ay, by)
    return cx >= left and cx <= right and cy >= top and cy <= bottom
end

function util.lineCircleIntersect(Ax, Ay, Bx, By, Cx, Cy, Cr)
    local distAB = math.sqrt( (Bx-Ax) ^ 2+(By-Ay) ^ 2 )   -- compute the euclidean distance between A and B

    local Dx = (Bx - Ax) / distAB                         -- compute the direction vector D from A to B
    local Dy = (By - Ay) / distAB

    -- Now the line equation is x = Dx*t + Ax, y = Dy*t + Ay with 0 <= t <= 1.
    local t = Dx*(Cx-Ax) + Dy*(Cy-Ay)                     -- compute the value t of the closest point to the circle center (Cx, Cy)

    -- Calculate the projection of C on the line from A to B.
    local Ex = t * Dx + Ax                                -- compute the coordinates of the point E on line and closest to C
    local Ey = t * Dy + Ay

    local distEC = math.sqrt((Ex-Cx) ^ 2+(Ey-Cy) ^ 2)     -- compute the euclidean distance from E to C

    local collide = distEC <= Cr                          -- test if the line intersects the circle

    if collide and dt == dt then
        local dt = math.sqrt(Cr ^ 2 - distEC ^ 2)         -- compute distance from t to circle intersection point

        Fx = (t - dt) * Dx + Ax                     -- compute first intersection point
        Fy = (t - dt) * Dy + Ay

        Gx = (t + dt) * Dx + Ax                     -- compute second intersection point
        Gy = (t + dt) * Dy + Ay

        collide = util.rectPointIntersect(Ax, Ay, Bx, By, Fx, Fy) or util.rectPointIntersect(Ax, Ay, Bx, By, Gx, Gy)
    end

    return collide
end
