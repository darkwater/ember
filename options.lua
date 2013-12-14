Options = class("Options")

function Options:initialize()

    self.aboutText = ([[
        NYI
    ]]):gsub("\n", "")

end

function Options:update(dt)



end

function Options:draw()

    local window_width, window_height = love.window.getDimensions()

    love.graphics.setFont(ember.fonts[48])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Ember", 0, 50, window_width, "center")

    love.graphics.setFont(ember.fonts[24])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Options", 0, 110, window_width, "center")

    love.graphics.setFont(ember.fonts[18])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf(self.aboutText, 20, 200, window_width - 40)

    love.graphics.setFont(ember.fonts[18])
    love.graphics.setColor(150, 150, 150)
    love.graphics.printf("Press anywhere to go back.", 0, window_height - 50, window_width - 40, "right")

end

function Options:mousePressed(mousex, mousey, button)

    ember.setScreen("mainmenu")

end
