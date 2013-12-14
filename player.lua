Player = class("Player")

Player.image = love.graphics.newImage("img/player.png")

function Player:initialize()

    self.image = Player.image

    self.x = 100
    self.y = 100

end

function Player:update(dt)

end

function Player:draw()

    love.graphics.draw(self.image, self.x, self.y)

end
