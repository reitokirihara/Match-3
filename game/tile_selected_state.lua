TileState = {
    init = function()
    end
}

debugText = ""

function TileState:draw()
    PlayState:draw()
    love.graphics.print(debugText, 0, 0)
end

function TileState:keypressed(key)
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
        --check if move is valid/swap if so
        if board:isAdjacent(cursor.selectedTile, cursor.tilePos) then
            local tempColor = board.tiles[cursor.tilePos.y + 1][cursor.tilePos.x + 1].color
            board.tiles[cursor.tilePos.y + 1][cursor.tilePos.x + 1].color = board.tiles[cursor.selectedTile.y + 1][cursor.selectedTile.x + 1].color
            board.tiles[cursor.selectedTile.y + 1][cursor.selectedTile.x + 1].color = tempColor
            GameState.pop()
            board:evaluateMatch()
            --board:evaluateFalls()
        end
    end
end

