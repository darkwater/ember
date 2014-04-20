Dashboard = class("Dashboard")

function Dashboard:initialize()

    local window_width, window_height = love.window.getDimensions()

    self.optionList = ButtonList:new(window_width - 120, window_height - 110, 100, 25, 5, ember.fonts[18], "right")
    self.optionList:addButton("Menu", function ()
        ember.setScreen("mainmenu")
    end)


    self.tpanel = {}
    self.tpanel.hover = 0
    setmetatable(self.tpanel, { __index = _G })

    self.placingTower = 0
    self.placingValid = false

    self:updatePanel(window_width, window_height)

end

function Dashboard:updatePanel(width, height)

    self.tpanel.left    = 10
    self.tpanel.top     = height - 110
    self.tpanel.width   = width / 2 - 30
    self.tpanel.height  = 100
    self.tpanel.right   = self.tpanel.left + self.tpanel.width
    self.tpanel.bottom  = self.tpanel.top + self.tpanel.height
    self.tpanel.padding = 5
    self.tpanel.spacing = 10

end

function Dashboard:update(dt)

    local mousex, mousey = love.mouse.getPosition()

    self.optionList:update(dt)


    local t = self.tpanel
    t.hover = 0

    if self.placingTower == 0
        and mousex > t.left + t.padding
        and mousey > t.top + t.padding
        and mousex < t.right
        and mousex < t.left + (Tile.SIZE + 40 + t.spacing) * #Tower.types - t.spacing
        and mousey < t.bottom - t.padding
        and (mousex - t.left - t.padding) % (Tile.SIZE + 40 + t.spacing) < Tile.SIZE + 40 then

        t.hover = math.floor((mousex - t.left) / (Tile.SIZE + 40 + t.spacing)) + 1

        if Tower.types[t.hover][Tower.COST] > game.money then

            t.hover = 0

        end

    end
    
    for k,v in pairs(Tower.types) do --hotkeys for tower placement
        if love.keyboard.isDown(k) then
            self.placingTower = k
        end
    end
    
    if self.placingTower ~= 0 then
        if Tower.types[self.placingTower][Tower.COST] > game.money then
            self.placingTower = 0
        end
    end
    
end

function Dashboard:draw()

    local window_width, window_height = love.window.getDimensions()
    local mousex, mousey = love.mouse.getPosition()


    if self.placingTower > 0 then

        local x, y = math.floor(mousex / Tile.SIZE) * Tile.SIZE, math.floor(mousey / Tile.SIZE) * Tile.SIZE

        self.placingValid = math.sqrt((x - game.player.x) ^ 2 + (y - game.player.y) ^ 2) < game.player.buildRange

        love.graphics.setColor(self.placingValid and 100 or 250, self.placingValid and 250 or 100, 80, 100)
        love.graphics.rectangle("fill", x - 6, y - 6, Tile.SIZE + 12, Tile.SIZE + 12)

        love.graphics.setColor(250, 250, 250, 150)
        love.graphics.rectangle("fill", x - 4, y - 4, Tile.SIZE + 8, Tile.SIZE + 8)

        Tower.draw(self.placingTower, x, y, 150)

    end


    love.graphics.setColor(0, 0, 0, 50)
    for i = 1, 5 do
        love.graphics.rectangle("fill", 0, window_height - 120 - i, window_width, i)
    end

    love.graphics.setColor(29, 31, 33)
    love.graphics.rectangle("fill", 0, window_height - 120, window_width, 120)


    do --== Towers panel ==--

        setfenv(1, self.tpanel)

        love.graphics.setColor(25, 25, 25)
        love.graphics.rectangle("fill", left, top, width, height)

        love.graphics.setScissor(left, top, width, height)

            local x = left + padding
            local y = top + padding

            love.graphics.setFont(ember.fonts[14])

            for i,v in ipairs(Tower.types) do

                local alpha = v[Tower.COST] > game.money and 50 or self.placingTower > 0 and 150 or 255

                Tower.draw(i, x + 20, y + 10, alpha)

                love.graphics.setColor(220, 220, 220, alpha)
                love.graphics.printf(v[Tower.NAME], x, y + 20 + Tile.SIZE, Tile.SIZE + 40, "center")

                if hover == i then

                    love.graphics.setColor(255, 255, 255, 30)
                    love.graphics.rectangle("fill", x, y, Tile.SIZE + 40, height - padding * 2)

                end

                x = x + Tile.SIZE + 40 + spacing

            end

        love.graphics.setScissor()

        love.graphics.setLineWidth(2)

        love.graphics.setColor(10, 10, 10)
        love.graphics.line(left, bottom, left, top)
        love.graphics.line(left, top, right, top)

        love.graphics.setColor(50, 50, 50)
        love.graphics.line(right, top, right, bottom)
        love.graphics.line(right, bottom, left, bottom)

    end ---------------------


    love.graphics.setFont(ember.fonts[18])

    love.graphics.setColor(90, 240, 80)
    love.graphics.print("$" .. math.floor(game.money), window_width / 2, window_height - 110)

    love.graphics.setColor(80, 190, 240)
    love.graphics.print("Difficulty: " .. math.floor(game.difficulty), window_width / 2, window_height - 85)


    local timeleft = (game.nextSpawn - game.time)
    love.graphics.setColor(80, 240, 190)
    love.graphics.setFont(ember.fonts[14])
    love.graphics.print("Next spawn in " .. ((timeleft <= 2) and "..." or (math.ceil(timeleft) .. "s")), window_width / 2, window_height - 30)
    love.graphics.rectangle("fill", window_width / 2, window_height - 8, timeleft / 15 * (window_width / 2), 2)


    self.optionList:draw()

end

function Dashboard:mousePressed(mousex, mousey, button)

    self.optionList:mousePressed(mousex, mousey, button)

    if self.tpanel.hover > 0 then

        self.placingTower = self.tpanel.hover

    end

    if self.placingTower > 0 and mousey < love.window.getHeight() - 120 then
        
        if button == "l" and self.placingValid then

            local cost = Tower.types[self.placingTower][Tower.COST]

            if cost <= game.money then

                local x, y = math.floor(mousex / Tile.SIZE) * Tile.SIZE, math.floor(mousey / Tile.SIZE) * Tile.SIZE

                game:newTower(self.placingTower, x, y)

                game.money = game.money - cost

                game.player.nextFire = math.max(game.player.nextFire, game.time + 1)

            end

            self.placingTower = 0

            game.player.nextFire = math.max(game.player.nextFire, game.time + 0.1)

        end

        self.placingTower = 0

        game.player.nextFire = math.max(game.player.nextFire, game.time + 0.1)

    end

end
