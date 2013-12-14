Tile = class("Tile")

Tile.types =
{ --  nice name        image name       walkable  buildable  enemy path  target
    { "Floor tile",    "plain_tile",    true,     true,      false,      false },
    { "Enemy path",    "enemy_path",    true,     false,     true,       false },
    { "Nuclear bomb",  "nuclear_bomb",  false,    false,     true,       true  },
}

Tile.NICE_NAME  = 1
Tile.IMAGE_NAME = 2
Tile.WALKABLE   = 3
Tile.BUILDABLE  = 4
Tile.ENEMY_PATH = 5
Tile.TARGET     = 6

Tile.SIZE = 32

Tile.imageCache = {}
for i,v in ipairs(Tile.types) do

    Tile.imageCache[v[Tile.IMAGE_NAME]] = love.graphics.newImage("tiles/" .. v[Tile.IMAGE_NAME] .. ".png")

end

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

    self.image = Tile.imageCache[self.imageName]

end

function Tile:draw()

    love.graphics.draw(self.image, self.x, self.y)

end
