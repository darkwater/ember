Enemy = class("Enemy")

Enemy.image = love.graphics.newImage("img/enemy.png")

function Enemy:initialize(e_index, path, speed)

    self.e_index = e_index

    self.image = Enemy.image

    self.x = util.gridToPosition(path[1][1])
    self.y = util.gridToPosition(path[1][2])

    self.ang = math.pi * 0.5

    self.path = path
    self.nextTarget = 2
    self.speed = speed

    self.maxHealth = 18
    self.health    = 18
    self.size      = 12

    self.prize = speed / 5

end

function Enemy:update(dt)

    local target = self.path[self.nextTarget]
    local targetAng = math.atan2(util.gridToPosition(target[2]) - self.y, util.gridToPosition(target[1]) - self.x)

    if self.ang < targetAng - math.pi then self.ang = self.ang + math.tau end
    if self.ang > targetAng + math.pi then self.ang = self.ang - math.tau end

    self.ang = self.ang + (targetAng - self.ang) / 5


    self.x = self.x + math.cos(self.ang) * self.speed * dt
    self.y = self.y + math.sin(self.ang) * self.speed * dt


    local distance = math.sqrt((self.x - util.gridToPosition(target[1])) ^ 2 + (self.y - util.gridToPosition(target[2])) ^ 2)
    if distance < self.speed * 0.1 and self.path[self.nextTarget + 1] then
        self.nextTarget = self.nextTarget + 1
    end

end

function Enemy:draw()

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.x - 12, self.y - 12)

end

function Enemy:damage(hp)

    self.health = self.health - hp

    if self.health <= 0 then

        self:destroy()

    end

end

function Enemy:destroy()

    game:removeEnemy(self.e_index)
    game.money = game.money + self.prize

end
