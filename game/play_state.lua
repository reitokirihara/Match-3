PlayState = {
    draw = function(self)
        push:start()
        board:draw()
        cursor:draw()
        push:finish()
    end
}

function PlayState:init()
    board = Board()
    cursor = Cursor(vector(0,0))
end

function PlayState:keypressed(key)
    if key == "w" then
        cursor:move(DIR_UP)
    elseif key == "d" then
        cursor:move(DIR_RIGHT)
    elseif key == "a" then
        cursor:move(DIR_LEFT)
    elseif key == "s" then 
        cursor:move(DIR_DOWN)
    end 

    if key == "return" then
        --select tile
        cursor.selectedTile = cursor.tilePos
        GameState.push(TileState)
    end
end

