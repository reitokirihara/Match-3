Board = Class{
    init = function(self)
        self.size = TILE_SIZE * TILES_PER_ROW
        self.position = vector(BOARD_X_OFFSET, BOARD_Y_OFFSET)
        self.color = {0,1,0}
        self.tiles = {}

        for y = 1, TILES_PER_ROW do
            table.insert(self.tiles, {})
            for x = 1, TILES_PER_ROW do
                table.insert(self.tiles[y], Tile(vector(x-1,y-1), TILE_TYPES[TILE_IDS[love.math.random(1, #TILE_IDS - 1)]]))
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
            --vertical for 3
            if y + 2 <= TILES_PER_ROW then
                if self.tiles[y][x].color == self.tiles[y + 1][x].color and self.tiles[y + 1][x].color == self.tiles[y + 2][x].color then
                    local color = self.tiles[y][x].color
                    local numMatched = 3
                    repeat until (y + numMatched) <= TILES_PER_ROW do
                        if self.tiles[y + numMatched][x].color ~= color then
                            break
                        end
                        numMatched = numMatched + 1
                    end

                    for i = 0, numMatched do
                        self.tiles[y + i][x].color = COLOR_BLACK
                    end
                   
                    self:evaluateFalls(x)
                end
            end
            --horizontal for 3
            if x + 2 <= TILES_PER_ROW then
                if self.tiles[y][x].color == self.tiles[y][x + 1].color and self.tiles[y][x + 1].color == self.tiles[y][x + 2].color then
                    self.tiles[y][x].color = COLOR_BLACK
                    self.tiles[y][x + 1].color = COLOR_BLACK
                    self.tiles[y][x + 2].color = COLOR_BLACK
                    self:evaluateFalls(x)
                    self:evaluateFalls(x + 1)
                    self:evaluateFalls(x + 2)
                end
            end
        end
    end
end

function Board:evaluateFalls(xPos)
    local col = {}
    for y = TILES_PER_ROW, 1, -1 do 
        if self.tiles[y][xPos].color ~= COLOR_BLACK then
            table.insert(col, self.tiles[y][xPos].color)
        end    
    end

    for y = TILES_PER_ROW, 1, -1 do 
        if (TILES_PER_ROW + 1) - y <= #col then
            self.tiles[y][xPos].color = col[(TILES_PER_ROW + 1) - y]
        else
            self.tiles[y][xPos].color = COLOR_BLACK
        end
    end

    -- for i, color in ipairs(col) do
    --     self.tiles[TILES_PER_ROW - (i - 1)][xPos].color = color
    -- end 
end