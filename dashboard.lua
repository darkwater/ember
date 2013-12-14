Dashboard = class("Dashboard")

function Dashboard:initialize()

    local window_width, window_height = love.window.getDimensions()

    self.optionList = ButtonList:new(window_width - 120, window_height - 40, 100, 25, 5, ember.fonts[18], "right")
    self.optionList:addButton("Menu", function ()
        ember.setScreen("mainmenu")
    end)

end

function Dashboard:update(dt)

    self.optionList:update(dt)

end

function Dashboard:draw()

    local window_width, window_height = love.window.getDimensions()

    love.graphics.setColor(0, 0, 0, 50)
    for i = 1, 5 do
        love.graphics.rectangle("fill", 0, window_height - 120 - i, window_width, i)
    end

    love.graphics.setColor(29, 31, 33)
    love.graphics.rectangle("fill", 0, window_height - 120, window_width, 120)

    self.optionList:draw()

end

function Dashboard:mousePressed(x, y, button)

    self.optionList:mousePressed(x, y, button)

end
