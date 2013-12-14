Game = class("Game")

function Game:initialize()

    self.map = Map:new()

end

function Game:update(dt)

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    local mousex, mousey = love.mouse.getPosition()




end

function Game:draw()

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    self.map:draw()

end

function Game:mousePressed(mousex, mousey, button)



end

function Game:loadMap(name)

    self.map:loadFile("maps/" .. name .. ".map")

end
