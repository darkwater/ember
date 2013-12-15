LevelSelect = class("LevelSelect")

function LevelSelect:initialize()

    self.hover = 0
    self.active = 0
    self.hoveringPlay = false
    self.hoveringBack = false

    self.levels = {}

    for i,name in ipairs(love.filesystem.getDirectoryItems("maps")) do

        local filedata = love.filesystem.read("maps/" .. name)
        local obj = json.decode(filedata)
        self.levels[obj.index] = obj

    end

    self.startx  = 50
    self.starty  = 200
    self.width   = 150
    self.height  = 180
    self.margin  = 30
    self.padding = 10

end

function LevelSelect:update(dt)

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    local mousex, mousey = love.mouse.getPosition()


    self.hover = 0

    if mousey > self.starty and mousey < self.starty + self.height then

        local x = self.startx
        for i,v in ipairs(self.levels) do

            if mousex > x and mousex < x + self.width then

                self.hover = i

            end


            x = x + self.width + self.margin

        end

    end


    self.hoveringBack = mousey > window_height - 60 and mousex > window_width - 200
    self.hoveringPlay = self.active > 0 and not self.hoveringBack and mousey > window_height - 140 and mousex > window_width - 200

end

function LevelSelect:draw()

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    love.graphics.setFont(ember.fonts[48])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Ember", 0, 50, window_width, "center")

    love.graphics.setFont(ember.fonts[24])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Select Level", 0, 110, window_width, "center")

    love.graphics.setFont(ember.fonts[18])

    local color = self.active > 0 and (self.hoveringPlay and 255 or 150) or 50
    love.graphics.setColor(color, color, color)
    love.graphics.printf("Play", 0, window_height - 100, window_width - 40, "right")

    local color = self.hoveringBack and 255 or 150
    love.graphics.setColor(color, color, color)
    love.graphics.printf("Back", 0, window_height - 50, window_width - 40, "right")


    local x = self.startx
    for i,v in ipairs(self.levels) do

        local hovering = self.hover == i
        local active = self.active == i

        love.graphics.setColor(27, 27, 27)
        love.graphics.rectangle("fill", x - self.margin * 0.3, self.starty - self.margin * 0.3, self.width + self.margin * 0.6, self.height + self.margin * 0.9)


        love.graphics.setColor(active and 40 or 29,
                               hovering and 43 or 31,
                               hovering and 46 or 33)
        love.graphics.rectangle("fill", x, self.starty, self.width, self.height)

        if active then
            love.graphics.setColor(255, 175, 0)
            love.graphics.rectangle("line", x, self.starty, self.width, self.height)
        end


        local px, py = x + self.padding,  self.starty + self.padding
        local pw, ph = self.width - self.padding * 2,  self.height * 0.6

        love.graphics.setColor(10, 10, 10)
        love.graphics.rectangle("fill", px, py, pw, ph)

        love.graphics.setScissor(px, py, pw, ph)

            love.graphics.setColor(50, 90, 180)
            love.graphics.setLineWidth(2)
            for n, path in ipairs(v.paths) do

                local line = {}

                for _,c in ipairs(path) do

                    table.insert(line, math.floor(c[1] / 25 * pw + px  +.5))
                    table.insert(line, math.floor(c[2] / 15 * ph + py  +.5))

                end

                love.graphics.line(line)

            end

        love.graphics.setScissor()

        love.graphics.setFont(ember.fonts[18])

        love.graphics.setColor(170, 210, 240)
        love.graphics.printf(v.name, x + self.padding, self.starty + self.height - 50, self.width - self.padding * 2, "center")

        if ember.save.records and ember.save.records[v.name] then

            love.graphics.setFont(ember.fonts[14])

            love.graphics.setColor(170, 210, 240)
            love.graphics.printf("Record: " .. ember.save.records[v.name], x + self.padding, self.starty + self.height - 27, self.width - self.padding * 2, "center")

        end


        x = x + self.width + self.margin

    end


    if self.active > 0 then

        love.graphics.setColor(250, 250, 250)
        love.graphics.printf(self.levels[self.active].name,        self.startx, self.starty + self.height + self.margin * 2, 200)
        love.graphics.printf(self.levels[self.active].description, self.startx, self.starty + self.height + self.margin * 2 + 30, window_width * 0.7)

    end

end

function LevelSelect:mousePressed(mousex, mousey, button)

    if self.hoveringPlay then

        ember.setScreen("game")
        ember.screens.game:loadMap(self.levels[self.active])

    else
        self.active = self.hover
    end

    if self.hoveringBack then
        ember.setScreen("mainmenu")
    end

end
