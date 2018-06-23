Board = Class{
    init = function(self)
        self.size = TILE_SIZE * TILES_PER_ROW
        self.position = vector(BOARD_X_OFFSET, BOARD_Y_OFFSET)
        self.color = {0,1,0}
        self.tiles = {}

        for y = 1, TILES_PER_ROW do
            table.insert(self.tiles, {})
            for x = 1, TILES_PER_ROW do
                table.insert(self.tiles[y], Tile(vector(x-1,y-1), TILE_TYPES[TILE_IDS[math.random(1, #TILE_IDS)]]))
            end
        end
    end,
    draw = function(self)
        for y, row in ipairs(self.tiles) do
            for x, tile in ipairs(row) do
                love.graphics.setColor(tile.color)
                love.graphics.rectangle("fill", self.position.x + tile.boardPos.x, self.position.y + tile.boardPos.y, TILE_SIZE, TILE_SIZE)
                love.graphics.setColor(0,0,0)
                love.graphics.getLineWidth(TILE_SIZE/8)
                love.graphics.rectangle("line", self.position.x + tile.boardPos.x, self.position.y + tile.boardPos.y, TILE_SIZE, TILE_SIZE)
            end
        end
    end
}

function Board:isAdjacent(p1, p2)
    return Board:manhattan(p1,p2) == 1; 
end

function Board:manhattan(p1, p2)
    return math.abs(p1.x - p2.x) + math.abs(p1.y - p2.y)
end