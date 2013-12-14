Enemy = class("Enemy")

Enemy.image = love.graphics.newImage("img/enemy.png")

function Enemy:initialize()

    self.image = Enemy.image

    self.x = 200
    self.y = 50

end

function Enemy:update(dt)

end

function Enemy:draw()

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.image, self.x, self.y)

end
