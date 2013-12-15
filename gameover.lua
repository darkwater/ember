Gameover = class("Gameover")

function Gameover:initialize()

    self.GameoverText = ([[
        The opposing force has destroyed the bomb and operation Ember has failed!
    ]]):gsub("\n", "")

    self.time = 0
    self.newRecord = false
    self.prevDifficulty = 0

end

function Gameover:start(result)

    self.result = result
    self.time = 0

    if not ember.save.records then ember.save.records = {} end
    if not ember.save.records[result.map] then ember.save.records[result.map] = 0 end

    self.prevDifficulty = ember.save.records[result.map]

    if result.difficulty > ember.save.records[result.map] then
        ember.save.records[result.map] = result.difficulty
        self.newRecord = true
    end

end

function Gameover:update(dt)

    self.time = self.time + dt

end

function Gameover:draw()

    local window_width, window_height = love.window.getDimensions()

    love.graphics.setFont(ember.fonts[48])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Gameover", 0, 50, window_width, "center")

    love.graphics.setFont(ember.fonts[24])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("on " .. self.result.map, 0, 110, window_width, "center")

    love.graphics.setFont(ember.fonts[18])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf(self.GameoverText, 20, 170, window_width - 40, "center")

    love.graphics.setFont(ember.fonts[24])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("You collected $" .. self.result.points, 0, 240, window_width, "center")
    love.graphics.printf("You survived until difficulty " .. self.result.difficulty, 0, 275, window_width, "center")

    if self.prevDifficulty > 0 then
        love.graphics.printf("Previous record: " .. self.prevDifficulty, 0, 330, window_width, "center")
        if self.newRecord then love.graphics.printf("NEW RECORD!", 0, 360, window_width, "center") end
    end

    love.graphics.setFont(ember.fonts[18])
    love.graphics.setColor(120, 120, 120)
    love.graphics.printf("Press anywhere to select a level.", 0, window_height - 50, window_width - 40, "right")

    if self.time < 1 then

        love.graphics.setColor(255, 255, 255, 255 - self.time * 255)
        love.graphics.rectangle("fill", 0, 0, love.window.getWidth(), love.window.getHeight())

    end

end

function Gameover:mousePressed(mousex, mousey, button)

    ember.setScreen("levelselect")

end
