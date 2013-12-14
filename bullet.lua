Bullet = class("Bullet")

function Bullet:initialize(b_index, x, y, ang, speed, origin)

    self.b_index = b_index

    self.x      = x
    self.y      = y
    self.ang    = ang
    self.speed  = speed
    self.origin = origin

end

function Bullet:update(dt)

    self.x = self.x + math.cos(self.ang) * self.speed * dt
    self.y = self.y + math.sin(self.ang) * self.speed * dt

end

function Bullet:draw()

    love.graphics.circle("fill", self.x, self.y, 5, 5)

end

function Bullet:destroy()

    game:removeBullet(b_index)

end
