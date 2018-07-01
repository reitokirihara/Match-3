require "dependencies"

function love.load()
    love.window.setTitle("MATCH STUFF")

    io.stdout:setvbuf("no")
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true,
        highdpi = true,
        canvas = false
    })

    GameState.registerEvents()
    GameState.switch(MenuState)
end

function love.update(dt)
end

function love.draw()
   
end

