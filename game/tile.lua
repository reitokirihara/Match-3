Tile = Class{
    init = function(self, pos, def)
        self.tilePos = pos
        self.boardPos = vector(self.tilePos.x * TILE_SIZE, -100)
        
        self.color = def.color or {1,1,1}
        -- Timer.after(1, Timer.tween(love.math.random() * 0.3 + 0.2, self.boardPos, {y = self.tilePos.y * TILE_SIZE}, "in-bounce"))
        flux.to(self.boardPos, 0.75, 
        		{
        			x = self.boardPos.x, 
        			y = self.tilePos.y * TILE_SIZE
        		})
        		:ease("backout")
        		:delay(math.random()/(self.tilePos.y+1))
    end,
    setBoardPos = function(self)
        self.boardPos = vector(self.tilePos.x * TILE_SIZE, self.tilePos.y * TILE_SIZE)
    end
}