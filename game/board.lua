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
    for y = 1, TILES_PER_ROW do  
        for x = 1, TILES_PER_ROW do
            --vertical
            if y + 2 <= TILES_PER_ROW then
                if self.tiles[y][x].color == self.tiles[y + 1][x].color and self.tiles[y + 1][x].color == self.tiles[y + 2][x].color then
                    self.tiles[y][x].color = {0,0,0}
                    self.tiles[y + 1][x].color = {0,0,0}
                    self.tiles[y + 2][x].color = {0,0,0}
                    self:evaluateFalls(vector(x, y+2), 3)
                end
            end
            --horizontal
            -- if x + 2 <= TILES_PER_ROW then
            --     if self.tiles[x][y].color == self.tiles[x + 1][y].color and self.tiles[x + 1][y].color == self.tiles[x + 2][y].color then
            --         self:evaluateFalls(vector(x, y), 1)
            --         self:evaluateFalls(vector(x + 1, y), 1)
            --         self:evaluateFalls(vector(x + 2, y), 1)
            --     end
            -- end
        end
    end
end

function Board:evaluateFalls(pos, offset)
    print("Falling at "..pos.y-offset)
    local col = {}
    for y = TILES_PER_ROW, 1, -1 do 
        if self.tiles[y][pos.x].color ~= {0,0,0} then
            table.insert(col, self.tiles[y][pos.x].color)
        end    
    end

    for i, color in ipairs(col) do
        self.tiles[TILES_PER_ROW - (i - 1)][pos.x].color = color
    end 
end