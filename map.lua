Map = class("Map")


function Map:initialize()

    self.name        = "No map loaded"
    self.description = "uhm wat"
    self.mapdata     = {}
    self.paths       = {}
    self.waves       = {}

end

function Map:draw()
    local window_width = love.window.getWidth()
    local window_height = love.window.getHeight() - ember.screens[ember.currentScreen].dashboard.tpanel.height
    
    love.graphics.setColor(Tile.types[1][Tile.COLOR]) --fill the gameworld area with floor color
    love.graphics.rectangle("fill", -ember.screens[ember.currentScreen].offset_x, -ember.screens[ember.currentScreen].offset_y, window_width, window_height)
    
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


    for _,v in ipairs({"paths"}) do

        self[v] = {}
        for i, item in ipairs(obj[v]) do

            table.insert(self[v], item)

        end

    end

end

function Map:loadFile(name)

    local filedata = love.filesystem.read(name)
    local obj = json.decode(filedata)
    self:loadData(obj)

end
