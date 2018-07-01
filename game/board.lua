Board = Class{
    init = function(self)
        self.size = TILE_SIZE * TILES_PER_ROW
        self.position = vector(BOARD_X_OFFSET, BOARD_Y_OFFSET)
        self.color = {0,1,0}
        self.tiles = {}

        for y = 1, TILES_PER_ROW do
            table.insert(self.tiles, {})
            for x = 1, TILES_PER_ROW do
                table.insert(self.tiles[y], Tile(vector(x-1,y-1), TILE_TYPES[TILE_IDS[math.random(1, #TILE_IDS - 1)]]))
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

function Board:evaluateMatch()
    for x = 1, TILES_PER_ROW do  
        for y = 1, TILES_PER_ROW do
            if y + 2 <= TILES_PER_ROW then
                if self.tiles[x][y].color == self.tiles[x][y + 1].color and self.tiles[x][y + 1].color == self.tiles[x][y + 2].color then
                    self.tiles[x][y].color = {0,0,0}
                    self.tiles[x][y].TILE_TYPES = "black"
                    self.tiles[x][y + 1].color = {0,0,0}
                    self.tiles[x][y + 1].TILE_TYPES = "black"
                    self.tiles[x][y + 2].color = {0,0,0}
                    self.tiles[x][y + 2].TILE_TYPES = "black"
                end
            end
            if x + 2 <= TILES_PER_ROW then
                if self.tiles[x][y].color == self.tiles[x + 1][y].color and self.tiles[x + 1][y].color == self.tiles[x + 2][y].color then
                    self.tiles[x][y].color = {0,0,0}
                    self.tiles[x][y].TILE_TYPES = "black"
                    self.tiles[x + 1][y].color = {0,0,0}
                    self.tiles[x + 1][y].TILE_TYPES = "black"
                    self.tiles[x + 2][y].color = {0,0,0}
                    self.tiles[x + 2][y].TILE_TYPES = "black"
                end
            end
        end
    end
end

function Board:evaluateFalls()
    for x = 1, TILES_PER_ROW do
        for y = 1, TILES_PER_ROW do
            if x + 1 <= TILES_PER_ROW then
                if self.tiles[x + 1][y].TILE_TYPES == "black" then
                     self.tiles[x + 1][y].color = self.tiles[x][y].color
                     self.tiles[x][y].color = {0,0,0}
                     self.tiles[x][y].TILE_TYPES = "black"
                end  
            end   
        end
    end 
end