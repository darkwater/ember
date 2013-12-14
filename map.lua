Map = class("Map")


function Map:initialize()

    self.name        = "No map loaded"
    self.description = "uhm wat"
    self.mapdata     = {}
    self.paths       = {}

end

function Map:draw()

    love.graphics.setColor(255, 255, 255)

    for y, row in ipairs(self.mapdata) do
        for x, tile in ipairs(row) do
    
            tile:draw()
    
        end
    end

end

function Map:loadData(obj)

    self.name        = obj.name or "- none -"
    self.description = obj.description or "- none -"


    self.mapdata = {}
    for y, row in ipairs(obj.mapdata) do

        local targetRow = {}

        for x, tile in ipairs(row) do

            table.insert(targetRow, Tile:new(tile, Tile.SIZE * (x - 1), Tile.SIZE * (y - 1)))

        end

        table.insert(self.mapdata, targetRow)

    end


    self.paths = {}
    for i, path in ipairs(obj.paths) do

        table.insert(self.paths, path)

    end

end

function Map:loadFile(name)

    local filedata = love.filesystem.read(name)
    local obj = json.decode(filedata)
    self:loadData(obj)

end
