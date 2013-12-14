Game = class("Game")

function Game:initialize()

    self.map       = Map:new()
    self.player    = Player:new()
    self.dashboard = Dashboard:new()

    self.enemies = {}
    self.bullets = {}

    self.spawnRate = 1

    self.time = 0

end

function Game:update(dt)

    self.time = self.time + dt

    local window_width, window_height = love.window.getDimensions()
    local mousex, mousey = love.mouse.getPosition()

    self.dashboard:update(dt)

    self.player:update(dt)

    if math.floor(self.time / self.spawnRate) > math.floor((self.time - dt) / self.spawnRate) then

        table.insert(self.enemies, Enemy:new(self.map.paths[1], math.random(50, 500)))

    end

    for i,v in ipairs(self.enemies) do
        v:update(dt)
    end

    for i,v in ipairs(self.bullets) do
        v:update(dt)
    end

end

function Game:draw()

    local window_width, window_height = love.window.getDimensions()


    love.graphics.setScissor(0, 0, window_width, window_height - 120)

        self.map:draw()
        self.player:draw()

        for i,v in ipairs(self.enemies) do
            v:draw()
        end

        for i,v in ipairs(self.bullets) do
            v:draw()
        end

    love.graphics.setScissor()


    self.dashboard:draw()

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

function Game:newBullet(...)

    local i = #self.bullets + 1
    local bullet = Bullet:new(i, ...)
    self.bullets[i] = bullet

end
