math.tau = math.pi * 2 -- hehe

function love.load()

    class = require("middleclass")

    require("about")
    require("bullet")
    require("button-list")
    require("dashboard")
    require("enemy")
    require("game")
    require("gameover")
    require("json")
    require("level-select")
    require("main-menu")
    require("map")
    require("options")
    require("player")
    require("tile")
    require("tower")
    require("util")

    love.graphics.setBackgroundColor(30, 30, 30)

    ember = {}
    ember.currentScreen = "mainmenu"

    ember.fonts = {}
    ember.fonts[14] = love.graphics.newFont("fonts/DroidSans.ttf", 14)
    ember.fonts[18] = love.graphics.newFont("fonts/DroidSans.ttf", 18)
    ember.fonts[24] = love.graphics.newFont("fonts/DroidSans.ttf", 24)
    ember.fonts[48] = love.graphics.newFont("fonts/DroidSans.ttf", 48)

    ember.screens = {}
    ember.screens.mainmenu    = MainMenu:new()
    ember.screens.about       = About:new()
    ember.screens.options     = Options:new()
    ember.screens.levelselect = LevelSelect:new()
    ember.screens.game        = Game:new()
    ember.screens.gameover    = Gameover:new()

    game = ember.screens.game -- shortcut :v

    if not love.filesystem.exists("save.json") then

        ember.save = {}
        ember.currentScreen = "about"
        ember.screens.about.firstTime = true

    else

        local file = love.filesystem.read("save.json")
        ember.save = json.decode(file)

    end

    function ember.setScreen(screen)

        if screen == "exit" then
            love.event.quit()
        else
            ember.screens.about.firstTime = false
            ember.currentScreen = screen
        end

    end

end

function love.update(dt)

    if love.mouse.isDown("r") then dt = dt / 3 end

    ember.screens[ember.currentScreen]:update(dt)

end

function love.draw()

    ember.screens[ember.currentScreen]:draw()

    -- love.graphics.print(love.timer.getFPS(), 10, 10)

end

function love.keypressed(key, isRepeat)

    if key == "escape" then
        -- love.event.quit()
    end

end

function love.mousepressed(x, y, button)

    if button == "m" then game:over(x, y) end

    ember.screens[ember.currentScreen]:mousePressed(x, y, button)

end

function love.resize(width, height)

    game.dashboard:updatePanel(width, height)

end

function love.quit()

    local data = json.encode(ember.save)
    love.filesystem.write("save.json", data)

end
