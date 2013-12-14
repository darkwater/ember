ButtonList = class("ButtonList")

function ButtonList:initialize(x, y, width, buttonHeight, spacing, font, align)

    self.buttons = {}

    self.x            = x
    self.y            = y
    self.width        = width
    self.buttonHeight = buttonHeight
    self.spacing      = spacing
    self.font         = font
    self.align        = align

    self.hover = 0

end

function ButtonList:addButton(label, callback)

    table.insert(self.buttons, { label = label, callback = callback })

end

function ButtonList:update(dt)

    local mousex, mousey = love.mouse.getPosition()

    self.hover = 0
    if mousex > self.x and mousey > self.y
        and mousex < self.x + self.width
        and mousey < self.y + self.buttonHeight * #self.buttons + self.spacing * (#self.buttons - 1)
        and (mousey - self.y) % (self.buttonHeight + self.spacing) < self.buttonHeight then

        self.hover = math.floor((mousey - self.y) / (self.buttonHeight + self.spacing)) + 1
        
    end

end

function ButtonList:draw()

    local mousex, mousey = love.mouse.getPosition()

    love.graphics.setFont(self.font)

    local y = self.y
    for i,v in ipairs(self.buttons) do

        local color = self.hover == i and 255 or 150
        love.graphics.setColor(color, color, color)
        love.graphics.printf(v.label, self.x, y, self.width, self.align)

        y = y + self.buttonHeight + self.spacing

    end

end

function ButtonList:mousePressed(x, y, button)

    if self.hover > 0 then

        self.buttons[self.hover].callback()

    end

end
