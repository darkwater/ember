Player = class("Player")

Player.image = love.graphics.newImage("img/player.png")

function Player:initialize()

    self.image = Player.image

    self.x     = 100
    self.y     = 100
    self.ang   = 0
    self.speed = 150

    self.nextFire  = 0
    self.fireDelay = 0.1

end

function Player:update(dt)

    local dirx = (love.keyboard.isDown("a") and -1 or 0) + (love.keyboard.isDown("d") and 1 or 0)
    local diry = (love.keyboard.isDown("w") and -1 or 0) + (love.keyboard.isDown("s") and 1 or 0)

    if dirx ~= 0 or diry ~= 0 then

        local ang = math.atan2(diry, dirx)

        if self.ang < ang - math.pi then self.ang = self.ang + math.tau end
        if self.ang > ang + math.pi then self.ang = self.ang - math.tau end

        self.ang = self.ang + (ang - self.ang) / 2

        self.x = self.x + math.cos(self.ang) * self.speed * dt
        self.y = self.y + math.sin(self.ang) * self.speed * dt

    end

    if love.mouse.isDown("l") and self.nextFire < game.time then

        local dx = love.mouse.getX() - self.x
        local dy = love.mouse.getY() - self.y
        local ang = math.atan2(dy, dx)

        game:newBullet(self.x, self.y, ang, 500, 2, "player")

        self.nextFire = game.time + self.fireDelay

    end

end

function Player:draw()

    love.graphics.draw(self.image, self.x - 12, self.y - 12)

end
