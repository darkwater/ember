Game = class("Game")

function Game:initialize()

    self.map       = Map:new()
    self.player    = Player:new()
    self.dashboard = Dashboard:new()

    self.enemies = {}
    self.bullets = {}
    self.towers  = {}

    self.spawnRate = 1

    self.time = 0

    self.money = 200

end

function Game:update(dt)

    self.time = self.time + dt

    local window_width, window_height = love.window.getDimensions()
    local mousex, mousey = love.mouse.getPosition()

    self.dashboard:update(dt)

    self.player:update(dt)

    if math.floor(self.time / self.spawnRate) > math.floor((self.time - dt) / self.spawnRate) then

        self:newEnemy(self.map.paths[math.random(1, #self.map.paths)], math.random(80, 120))

    end

    for k,v in pairs(self.enemies) do
        v:update(dt)
    end

    for k,v in pairs(self.towers) do
        v:update(dt)
    end

    for k,v in pairs(self.bullets) do
        v:update(dt)
    end

end

function Game:draw()

    local window_width, window_height = love.window.getDimensions()


    love.graphics.setScissor(0, 0, window_width, window_height - 120)

        self.map:draw()
        self.player:draw()

        for k,v in pairs(self.enemies) do
            v:draw()
        end

        for k,v in pairs(self.towers) do
            v:draw()
        end

        for k,v in pairs(self.bullets) do
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

function Game:removeBullet(i)

    self.bullets[i] = nil

end

function Game:newEnemy(...)

    local i = #self.enemies + 1
    local enemy = Enemy:new(i, ...)
    self.enemies[i] = enemy

end

function Game:removeEnemy(i)

    self.enemies[i] = nil

end

function Game:newTower(...)

    local i = #self.towers + 1
    local tower = Tower:new(i, ...)
    self.towers[i] = tower

end

function Game:removeTower(i)

    self.towers[i] = nil

end
