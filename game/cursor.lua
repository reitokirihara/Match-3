Cursor = Class{
    init = function(self, pos)
        self.tilePos = pos
        self.position = vector(BOARD_X_OFFSET + self.tilePos.x * TILE_SIZE, BOARD_Y_OFFSET + self.tilePos.y * TILE_SIZE)
        self.color = {1,1,1}
        self.selectedTile = nil
    end,
    draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.getLineWidth(TILE_SIZE/2)
        love.graphics.rectangle("line", self.position.x, self.position.y, TILE_SIZE, TILE_SIZE)
    end
}

function Cursor:move(dir)
    local newPos = self.tilePos + dir
    if newPos.x >= 0 and newPos.x < TILES_PER_ROW and newPos.y >= 0 and newPos.y < TILES_PER_ROW then
        self.tilePos = newPos
        self.position = vector(BOARD_X_OFFSET + self.tilePos.x * TILE_SIZE, BOARD_Y_OFFSET + self.tilePos.y * TILE_SIZE)
    end
end