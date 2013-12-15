Enemy = class("Enemy")

function Enemy:initialize(e_index, path, health, speed, size, prize, color)

    self.e_index = e_index

    self.x = util.gridToPosition(path[1][1])
    self.y = util.gridToPosition(path[1][2])

    self.ang = math.pi * 0.5

    self.path = path
    self.nextTarget = 2

    self.health    = health
    self.speed     = speed
    self.size      = size
    self.prize     = prize
    self.color     = color

    self.maxHealth = health

end

function Enemy:update(dt)

    local target = self.path[self.nextTarget]
    local targetAng = math.atan2(util.gridToPosition(target[2]) - self.y, util.gridToPosition(target[1]) - self.x)

    if self.ang < targetAng - math.pi then self.ang = self.ang + math.tau end
    if self.ang > targetAng + math.pi then self.ang = self.ang - math.tau end

    self.ang = self.ang + (targetAng - self.ang) / (300 * dt)


    self.x = self.x + math.cos(self.ang) * self.speed * dt
    self.y = self.y + math.sin(self.ang) * self.speed * dt


    local distance = math.sqrt((self.x - util.gridToPosition(target[1])) ^ 2 + (self.y - util.gridToPosition(target[2])) ^ 2)
    if distance < self.speed * 0.1 then

        if self.path[self.nextTarget + 1] then

            self.nextTarget = self.nextTarget + 1

        else

            game:over(self.x, self.y)

        end

    end

end

function Enemy:draw()

    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.size - 1, 30)

    love.graphics.setColor(54, 54, 54)
    love.graphics.setLineWidth(1)
    love.graphics.circle("line", self.x, self.y, self.size, 30)


    love.graphics.setColor(10, 100, 0, 160)
    love.graphics.setLineWidth(2)

    local vertices = {}
    local x, y = self.x, self.y

    for i = 0, math.ceil(self.health / self.maxHealth * 36) do

        local theta = i * 10 / 180 * math.pi

        table.insert(vertices, x + math.cos(theta) * (self.size + 5))
        table.insert(vertices, y + math.sin(theta) * (self.size + 5))
        
    end

    if #vertices > 3 then
        love.graphics.line(unpack(vertices))
    end

end

function Enemy:damage(hp)

    self.health = self.health - hp

    if self.health <= 0 then

        self:destroy()

    end

end

function Enemy:destroy()

    game:removeEnemy(self.e_index)
    game:giveCash(self.prize, self.x, self.y)

end
