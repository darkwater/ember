About = class("About")

function About:initialize()

    self.aboutText = ([[
        A secret society is planning a top-secret operation called "Ember". For this operation,
        they need a nuclear bomb. The goal of operation Ember is unknown to you. All you know is
        that their operation isn't ready to enter it's final phase yet.

        Some other group has found out about operation Ember and is trying to stop it. You have
        been hired to protect the bomb. You don't know if you're helping the good or the evil, all
        you know is that that bomb must stay safe.



        Ember is a game made by Darkwater for the 28th Ludum Dare, following the theme "You Only Get One".
    ]]):gsub("\n\n", "TMP"):gsub("\n", ""):gsub("TMP", "\n\n")

end

function About:update(dt)



end

function About:draw()

    local window_width, window_height = love.window.getDimensions()

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
    love.graphics.printf(self.firstTime and "Press anywhere to continue." or "Press anywhere to go back.", 0, window_height - 50, window_width - 40, "right")

end

function About:mousePressed(mousex, mousey, button)

    ember.setScreen("mainmenu")

end
