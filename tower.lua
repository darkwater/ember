Tower = class("Tower")

Tower.types =
{ --   name            cost  range  delay  speed  damage    base color         barrel color       bullet color
    { "Cannon",        100,   150,    0.9,   400,    1.9,  {  40,  41,  42 }, {   5,   5,   5 }, {   5,   5,   5 } },
    { "Machine gun",   500,   220,    0.4,   650,    1.5,  {  70,  70,  70 }, { 180,  90,  10 }, { 160, 180,  20 } },
    { "Plasma gun",    800,   300,    0.5,   500,    2.1,  {  10, 120, 160 }, {  60, 210, 200 }, {  60, 210, 200 } },
}

Tower.NAME = 1
Tower.COST = 2
Tower.RANGE = 3
Tower.DELAY = 4
Tower.SPEED = 5
Tower.DAMAGE = 6
Tower.BASE_COLOR = 7
Tower.BARREL_COLOR = 8
Tower.BULLET_COLOR = 9

function Tower:initialize(t_index, type, x, y)

    self.t_index = t_index

    self.x = x
    self.y = y

    self.cx = x + Tile.SIZE / 2
    self.cy = y + Tile.SIZE / 2

    self.type = type
    self.cost = Tower.types[type][Tower.COST]
    self.delay = Tower.types[type][Tower.DELAY]
    self.speed = Tower.types[type][Tower.SPEED]
    self.damage = Tower.types[type][Tower.DAMAGE]
    self.range = Tower.types[type][Tower.RANGE]

    self.nextFire = 0
    self.ang = math.pi * -.5

end

function Tower:draw(x, y, alpha)

    if not alpha and not alpha == 0 then alpha = 255 end
    local t = type(self) == "number" and self or self.type

    local x, y = x or self.x, y or self.y
    local cx, cy = x + Tile.SIZE/2, y + Tile.SIZE/2

    local ang = type(self) == "number" and math.pi * -.5 or self.ang

    local color = Tower.types[t][Tower.BASE_COLOR]
    color[4] = alpha
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x or self.x, y or self.y, Tile.SIZE, Tile.SIZE)

    color = Tower.types[t][Tower.BARREL_COLOR]
    color[4] = alpha
    love.graphics.setColor(color)
    love.graphics.setLineWidth(5)
    love.graphics.line(cx, cy, cx + math.cos(ang) * Tile.SIZE * 0.7, cy + math.sin(ang) * Tile.SIZE * 0.7)

end

function Tower:update(dt)

    local mindist = self.range ^ 2
    local enemy = nil

    for k,v in pairs(game.enemies) do

        local dist = (v.x - self.cx) ^ 2 + (v.y - self.cy) ^ 2

        if dist < mindist then

            mindist = dist
            enemy = v

        end

    end

    if enemy then

        self.ang = math.atan2(enemy.y - self.cy, enemy.x - self.cx)

        if self.nextFire < game.time then

            game:newBullet(self.cx, self.cy, self.ang, 500, self.damage, "tower", Tower.types[self.type][Tower.BULLET_COLOR])

            self.nextFire = game.time + self.delay

        end

    end

end

function Tower:destroy()

    game:removeTower(self.t_index)

end
