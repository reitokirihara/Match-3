MenuState = {
    draw = function(self)
        push:start()
        love.graphics.setColor(1,1,1)
        love.graphics.print("hi", 10, 10)
        push:finish()
    end
}

function MenuState:keypressed(key)
    if key == "return" then
        GameState.switch(PlayState)
    end
end