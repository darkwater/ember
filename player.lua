Player = class("Player")

function Player:initialize()

    self.image = Player.image

    self.x     = 100
    self.y     = 100
    self.ang   = 0
    self.speed = 150
    self.size  = 12

    self.nextFire    = 0.5
    self.fireDelay   = 0.2
    self.energy      = 100
    self.maxEnergy   = 100
    self.fireCost    = 2
    self.energyRegen = 5 -- per second

    self.buildRange = 150

end

function Player:update(dt)

    self.energy = math.min(self.maxEnergy, self.energy + self.energyRegen * dt)

    local window_width, window_height = love.window.getDimensions()
    local mousex, mousey = love.mouse.getPosition()

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

    if love.mouse.isDown("l") and mousey < window_height - 120 and self.nextFire < game.time and self.energy > 0 then

        local dx = mousex - self.x
        local dy = mousey - self.y
        local ang = math.atan2(dy, dx)

        game:newBullet(self.x, self.y, ang, 550, 1.64, "player", { 30, 25, 20 })

        self.nextFire = game.time + self.fireDelay
        self.energy = self.energy - self.fireCost

    end

end

function Player:draw()

    love.graphics.setColor(90, 148, 255)
    love.graphics.circle("fill", self.x, self.y, self.size - 1, 30)

    love.graphics.setColor(54, 54, 54)
    love.graphics.setLineWidth(1)
    love.graphics.circle("line", self.x, self.y, self.size, 30)


    love.graphics.setColor(10, 30, 80, 170)
    love.graphics.setLineWidth(2)

    local vertices = {}
    local x, y = self.x, self.y

    for i = 0, math.ceil(self.energy / self.maxEnergy * 36) do
        local theta = i * 10 / 180 * math.pi

        table.insert(vertices, x + math.cos(theta) * (self.size + 5))
        table.insert(vertices, y + math.sin(theta) * (self.size + 5))
    end

    if #vertices > 3 then
        love.graphics.line(unpack(vertices))
    end

end
