MainMenu = class("MainMenu")

function MainMenu:initialize()

    self.hover = 0

    self.buttons =
    {
        {"About",   "about"},
        {"Play",    "levelselect"},
        {"Options", "options"},
    }

end

function MainMenu:update(dt)

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    local mousex, mousey  = love.mouse.getPosition()

    if mousey > window_height - 120 then

        self.hover = math.ceil(mousex / window_width * 3)

    else

        self.hover = 0

    end

end

function MainMenu:draw()

    local window_width  = love.window.getWidth()
    local window_height = love.window.getHeight()

    love.graphics.setFont(ember.fonts[48])
    love.graphics.setColor(250, 250, 250)
    love.graphics.printf("Ember", 0, 50, window_width, "center")


    love.graphics.setFont(ember.fonts[24])

    for i,v in ipairs(self.buttons) do

        local hover = self.hover == i
        local lightness = hover and 255 or 150
        love.graphics.setColor(lightness, lightness, lightness)

        love.graphics.printf(v[1], window_width / 3 * (i - 1), window_height - 80, window_width / 3, "center")

    end

end

function MainMenu:mousePressed(mousex, mousey, button)

    if self.hover > 0 then

        ember.setScreen(self.buttons[self.hover][2])

    end

end
