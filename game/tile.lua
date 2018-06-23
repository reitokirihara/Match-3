Tile = Class{
    init = function(self, pos, def)
        self.tilePos = pos
        self.boardPos = vector(self.tilePos.x * TILE_SIZE, self.tilePos.y * TILE_SIZE)
        
        self.color = def.color or {1,1,1}
    end
}