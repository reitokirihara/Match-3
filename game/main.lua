require "dependencies"


---------------------------------------
--no matches at start
--refill board
--animation?
--score
--combos
--x matches greater than 3
---------------------------------------
--
--  GOOD SEEDS
--===============
-- 11562

function love.load()
    love.window.setTitle("MATCH STUFF")

    io.stdout:setvbuf("no")
 
    print("hi")
    love.math.setRandomSeed(11562)

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
    flux.update(dt)
end

function love.draw()
   love.graphics.print(love.math.getRandomSeed(), 100, 100)
end