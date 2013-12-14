About = class("About")

function About:initialize()

    self.aboutText = ([[
        Ember is a game made by Darkwater for the 28th Ludum Dare, with the theme "You
        Only Get One".
    ]]):gsub("\n", "")

end

function About:update(dt)



end

function About:draw()

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    love.graphics.setFont(ember.fonts[48])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Ember", 0, 50, window_width, "center")

    love.graphics.setFont(ember.fonts[24])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("About", 0, 110, window_width, "center")

    love.graphics.setFont(ember.fonts[18])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf(self.aboutText, 20, 200, window_width - 40)

    love.graphics.setFont(ember.fonts[18])
    love.graphics.setColor(150, 150, 150)
    love.graphics.printf("Press anywhere to go back.", 0, window_height - 50, window_width - 40, "right")

end

function About:mousePressed(mousex, mousey, button)

    ember.setScreen("mainmenu")

end
