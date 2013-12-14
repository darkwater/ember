function love.load()

    class = require("middleclass")

    require("main-menu")
    require("about")
    require("options")
    require("levelselect")
    require("button-list")
    require("map")
    require("tile")
    require("enemy")
    require("player")
    require("dashboard")
    require("game")
    require("json")

    love.graphics.setBackgroundColor(30, 30, 30)

    ember = {}
    ember.currentScreen = "mainmenu"

    ember.fonts = {}
    ember.fonts[18] = love.graphics.newFont("fonts/DroidSans.ttf", 18)
    ember.fonts[24] = love.graphics.newFont("fonts/DroidSans.ttf", 24)
    ember.fonts[48] = love.graphics.newFont("fonts/DroidSans.ttf", 48)

    ember.screens = {}
    ember.screens.mainmenu    = MainMenu:new()
    ember.screens.about       = About:new()
    ember.screens.options     = Options:new()
    ember.screens.levelselect = LevelSelect:new()
    ember.screens.game        = Game:new()

    function ember.setScreen(screen)
        ember.currentScreen = screen
    end

end

function love.update()

    ember.screens[ember.currentScreen]:update()

end

function love.draw()

    ember.screens[ember.currentScreen]:draw()

    -- love.graphics.print(love.timer.getFPS(), 10, 10)

end

function love.keypressed(key, isRepeat)

    if key == "escape" then
        love.event.quit()
    end

end

function love.mousepressed(x, y, button)

    ember.screens[ember.currentScreen]:mousePressed(x, y, button)

end
