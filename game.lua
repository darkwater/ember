Game = class("Game")

function Game:initialize()

    self.map       = Map:new()
    self.player    = Player:new()
    self.dashboard = Dashboard:new()

    self.enemies   = {}
    self.bullets   = {}
    self.towers    = {}
    self.cashSigns = {}

    self.nextSpawn = 10
    self.spawnRate = 2
    self.difficulty = 1

    self.time = 0

    self.money = 200

end

function Game:update(dt)

    self.time = self.time + dt

    local window_width, window_height = love.window.getDimensions()
    local mousex, mousey = love.mouse.getPosition()

    self.dashboard:update(dt)

    self.player:update(dt)

    if self.nextSpawn <= self.time then

        local enemyType = ({ "scout", "soldier", "hoovy" })[math.random(1, 3)]
        local boss = math.random(1, 30) == 1

        local color, health, speed, size = nil

        if enemyType == "scout" then        color  = {  20,  50, 220 }
                                            health = math.random(   1 + self.difficulty *  0.5,   2 + self.difficulty *  0.7)
                                            speed  = math.random( 150 + self.difficulty *  8.0, 190 + self.difficulty * 11.0)
                                            size   = math.random(  11 - self.difficulty *  0.4,  12 - self.difficulty *  0.3)

        elseif enemyType == "soldier" then  color  = {  60, 210,  60 }
                                            health = math.random(  10 + self.difficulty *  0.8,  16 + self.difficulty *  1.3)
                                            speed  = math.random(  80 + self.difficulty *  5.0, 100 + self.difficulty * 10.0)
                                            size   = math.random(  11 + self.difficulty *  0.1,  12 + self.difficulty *  0.2)

        elseif enemyType == "hoovy" then    color  = { 200,  80,  40 }
                                            health = math.random(  15 + self.difficulty *  1.1,  20 + self.difficulty *  2.2)
                                            speed  = math.random(  50 + self.difficulty *  4.0,  70 + self.difficulty *  6.0)
                                            size   = math.random(  12 + self.difficulty *  0.2,  14 + self.difficulty *  0.5)
        end

        if boss then               health = health * math.random( 700 + self.difficulty *  1.4, 900 + self.difficulty *  1.8) / 100
                                   speed  = speed  * math.random(  40 + self.difficulty *  0.4,  70 + self.difficulty *  0.6) / 100
                                   size   = size   * math.random( 130 + self.difficulty *  0.2, 170 + self.difficulty *  0.3) / 100
        end

        prize  = math.floor(health * 1.0 + speed * 0.1 - size * 0.2)

        if boss then prize = prize * math.random(14, 17) / 10 end


        local limits =
        {
            health = {  1, 20000 },
            speed  = { 30,   421 }, -- don't blaze it fagets
            size   = {  4,    16 },
            prize  = { 10, 50000 }
        }

        health = math.max( limits.health[1], math.min( limits.health[2], health ))
        speed  = math.max( limits.speed[1],  math.min( limits.speed[2],  speed  ))
        size   = math.max( limits.size[1],   math.min( limits.size[2],   size   ))
        prize  = math.max( limits.prize[1],  math.min( limits.prize[2],  prize  ))


        self:newEnemy(self.map.paths[math.random(1, #self.map.paths)], health, speed, size, prize, color)

        self.nextSpawn = self.time + (boss and math.random(12, 20) or self.spawnRate) -- small break after bosses

        self.difficulty = self.difficulty + 0.03
        self.spawnRate = self.spawnRate * 0.996 -- reaches 1s in about 365 spawns

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

    for k,v in pairs(self.cashSigns) do

        v[3] = v[3] - dt * 30
        v[4] = v[4] - dt * 180

        if v[4] <= 0 then

            table.remove(self.cashSigns, k)

        end

    end

end

function Game:draw()

    local window_width, window_height = love.window.getDimensions()


    love.graphics.setScissor(0, 0, window_width, window_height - 120)

        self.map:draw()

        for i,n in ipairs({"enemies", "towers", "bullets"}) do

            for k,v in pairs(self[n]) do
                v:draw()
            end

        end

        self.player:draw()


        love.graphics.setFont(ember.fonts[18])

        for k,v in pairs(self.cashSigns) do

            love.graphics.setColor(100, 150, 10, v[4])
            love.graphics.printf("$" .. v[1], v[2], v[3], 100, "center")

        end

    love.graphics.setScissor()


    self.dashboard:draw()

end

function Game:mousePressed(x, y, button)

    self.dashboard:mousePressed(x, y, button)

end

function Game:loadMap(obj)

    self.map       = Map:new()
    self.player    = Player:new()
    self.dashboard = Dashboard:new()

    self.enemies = {}
    self.bullets = {}
    self.towers  = {}

    self.time = 0
    self.money = 200

    if type(obj) == "string" then

        self.map:loadFile("maps/" .. name .. ".map")

    else

        self.map:loadData(obj)

    end

end

function Game:cashSign(cash, x, y)

    table.insert(self.cashSigns, { cash, x - 50, y - 15, 255 })

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
