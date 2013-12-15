Tile = class("Tile")

Tile.types =
{ --  nice name        image name       walkable  buildable  enemy path  target   color
    { "Floor tile",    "plain_tile",    true,     true,      false,      false,  { 210, 211, 212 } },
    { "Enemy path",    "enemy_path",    true,     false,     true,       false,  { 180, 200, 230 } },
    { "Nuclear bomb",  "nuclear_bomb",  false,    false,     true,       true,   { 210, 150,  20 } },
}

Tile.NICE_NAME  = 1
Tile.IMAGE_NAME = 2
Tile.WALKABLE   = 3
Tile.BUILDABLE  = 4
Tile.ENEMY_PATH = 5
Tile.TARGET     = 6
Tile.COLOR      = 7

Tile.SIZE = 32

function Tile:initialize(type, x, y)

    self.x = x
    self.y = y
    self.type = type

    self.niceName  = Tile.types[type][Tile.NICE_NAME]
    self.imageName = Tile.types[type][Tile.IMAGE_NAME]
    self.walkable  = Tile.types[type][Tile.WALKABLE]
    self.buildable = Tile.types[type][Tile.BUILDABLE]
    self.enemyPath = Tile.types[type][Tile.ENEMY_PATH]
    self.target    = Tile.types[type][Tile.TARGET]

end

function Tile:draw()

    love.graphics.setColor(Tile.types[self.type][Tile.COLOR])
    love.graphics.rectangle("fill", self.x, self.y, Tile.SIZE, Tile.SIZE)

end
