Map = class("Map")


function Map:initialize()

    self.name        = "No map loaded"
    self.description = "uhm wat"
    self.mapdata     = {}

end

function Map:draw()

    for y, row in ipairs(self.mapdata) do
        for x, tile in ipairs(row) do
    
            tile:draw()
    
        end
    end

end

function Map:loadFile(name)

    local filedata = love.filesystem.read(name)
    local mapobj = json.decode(filedata)

    self.name        = mapobj.name
    self.description = mapobj.description

    self.mapdata = {}
    for y, row in ipairs(mapobj.mapdata) do

        local targetRow = {}

        for x, tile in ipairs(row) do

            table.insert(targetRow, Tile:new(tile, Tile.SIZE * (x - 1), Tile.SIZE * (y - 1)))

        end

        table.insert(self.mapdata, targetRow)

    end

end
