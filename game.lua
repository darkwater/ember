Game = class("Game")

function Game:initialize()

    self.map = Map:new()
    self.player = Player:new()
    self.dashboard = Dashboard:new()

    self.enemy = Enemy:new()

end

function Game:update(dt)

    local window_width, window_height = love.window.getDimensions()
    local mousex, mousey = love.mouse.getPosition()

    self.dashboard:update()

end

function Game:draw()

    local window_width, window_height = love.window.getDimensions()

    love.graphics.setScissor(0, 0, window_width, window_height - 120)
        self.map:draw()
        self.player:draw()
    love.graphics.setScissor()

    self.dashboard:draw()

    self.enemy:draw()

end

function Game:mousePressed(x, y, button)

    self.dashboard:mousePressed(x, y, button)

end

function Game:loadMap(obj)

    if type(obj) == "string" then

        self.map:loadFile("maps/" .. name .. ".map")

    else

        self.map:loadData(obj)

    end

end
