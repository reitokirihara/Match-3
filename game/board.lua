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
                love.graphics.setColor(1,1,1)
                love.graphics.print("score: " .. score, 125, 125)
           end
        end
    end
}

score = 0

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
                    if (y + numMatched) < TILES_PER_ROW then
                        repeat 
                            if self.tiles[y + numMatched][x].color ~= color then
                                break
                            else
                                numMatched = numMatched + 1
                            end   
                        until (y + numMatched) > TILES_PER_ROW
                            
                    end  
                    

                    --TODO: going off top edge
                    for i = 0, numMatched - 1 do
                        if y + i <= TILES_PER_ROW then
                            self.tiles[y + i][x].color = COLOR_BLACK
                        end     
                    end
                    
                    score = score + numMatched - 2 
                    self:evaluateFalls(x)
                end
            end 
            --horizontal for 3
            if x + 2 <= TILES_PER_ROW then
                if self.tiles[y][x].color == self.tiles[y][x + 1].color and self.tiles[y][x + 1].color == self.tiles[y][x + 2].color then
                    local color = self.tiles[y][x].color
                    local numMatched = 3
                    if (x + numMatched) < TILES_PER_ROW then 
                        repeat 
                            if self.tiles[y][x + numMatched].color ~= color then 
                                break
                            else
                                numMatched = numMatched + 1
                            end
                        until (x + numMatched) > TILES_PER_ROW
                    end
                   
                    score = score +  numMatched - 2

                    for i = 0, numMatched - 1 do
                        self.tiles[y][x + i].color = COLOR_BLACK
                        self:evaluateFalls(x + i)
                    end
                    -- end
                    -- self.tiles[y][x].color = COLOR_BLACK
                    -- self.tiles[y][x + 1].color = COLOR_BLACK
                    -- self.tiles[y][x + 2].color = COLOR_BLACK
                    -- self:evaluateFalls(x)
                    -- self:evaluateFalls(x + 1)
                    -- self:evaluateFalls(x + 2)
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
        if (TILES_PER_ROW + 1) - y <= #col then --only add as many colored tiles as we added to col
            self.tiles[y][xPos].color = col[(TILES_PER_ROW + 1) - y]
        else
            self.tiles[y][xPos].boardPos.y = -100
            self.tiles[y][xPos].color = TILE_TYPES[TILE_IDS[love.math.random(1, #TILE_IDS - 1)]].color --the other tiles on top have to be black
            flux.to(self.tiles[y][xPos].boardPos, 0.75, 
                {
                    x = self.tiles[y][xPos].boardPos.x, 
                    y = self.tiles[y][xPos].tilePos.y * TILE_SIZE
                })
                :ease("backout")
                :delay(math.random() * 0.6)
                :oncomplete(function() self:evaluateMatch() end)
        end
    end

    -- local numBlack = TILES_PER_ROW - #col

    -- for i = 0, numBlack do

    -- end


    
    -- for i, color in ipairs(col) do
    --     self.tiles[TILES_PER_ROW - (i - 1)][xPos].color = color
    -- end 
end