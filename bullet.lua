Bullet = class("Bullet")

function Bullet:initialize(b_index, x, y, ang, speed, damage, origin)

    self.b_index = b_index

    self.x      = x
    self.y      = y
    self.ang    = ang
    self.speed  = speed
    self.damage = damage
    self.origin = origin

end

function Bullet:update(dt)

    local Ax, Ay = self.x, self.y

    self.x = self.x + math.cos(self.ang) * self.speed * dt
    self.y = self.y + math.sin(self.ang) * self.speed * dt

    local Bx, By = self.x, self.y
    local Mx, My = Ax*.5 + Bx*.5, Ay*.5 + By*.5

    if Bx < Ax then
        Ax, Ay, Bx, By = Bx, By, Ax, Ay
    end

    for k,v in pairs(game.enemies) do

        local Cx, Cy, Cr = v.x, v.y, v.size
                                                -- will return a false negative on too large lines. FIX.
        if --[[ (Cx-Mx)^2 + (Cy-My)^2 < (Cr + (self.speed / 2))^2 and ]] util.lineCircleIntersect(Ax, Ay, Bx, By, Cx, Cy, Cr) then

            v.x = v.x + math.cos(self.ang) * self.damage
            v.y = v.y + math.sin(self.ang) * self.damage

            v:damage(self.damage)

            self:destroy()
            break

        end

    end

end

function Bullet:draw()

    love.graphics.setColor(30, 25, 20)
    love.graphics.circle("fill", self.x, self.y, 4, 5)

end

function Bullet:destroy()

    game:removeBullet(self.b_index)

end
