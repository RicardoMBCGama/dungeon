
-- Reads the world from a .lua Tiled tilemap
-- TODO:
--  - read several layers
--  - for each layer, validate if it is solid or not via layer property 'isSolid' (use renderMap and tileMap)
--  - enable different sprite sheets

tileContent = {
  tEmpty = 0,
  tSolid = 1
}


world = {
  w = nil,
  h = nil,
  tileSize = nil,
  worldOffsetX = 1,
  worldOffsetY = 1,
  tileMap = {},
  renderMap = {},
  spriteImages = {},
  tiledTileMap = require('images/tilemap4'),
  tileSetWidth = 0,
  tileSetHeight = 0


}

function world.load()
  world.w = world.tiledTileMap.width
  world.h = world.tiledTileMap.height
  world.tileSize = world.tiledTileMap.tilewidth -- TODO: use tilewidth and tileheight
  world.tileSetWidth = world.tiledTileMap.tilesets[1].imagewidth
  world.tileSetHeight = world.tiledTileMap.tilesets[1].imageheight --NOTE: Not used, need to implement this

  world.spriteImages = {
    emptySprite = "",
    panelGrey = love.graphics.newImage('images/block2.png'),
    tileSet  = love.graphics.newImage('images/' .. world.tiledTileMap.tilesets[1].image),
  }

end

function world.init()
  for i = 1, world.w do
    world.tileMap[i] = {}
    world.renderMap[i] = {}
    for j = 1, world.h do
      world.tileMap[i][j] = world.tiledTileMap.layers[1].data[i + (j - 1) * world.w]
    end
  end

end

function world.draw()

  for i = 1, world.w do
    for j = 1, world.h do
      if world.tileMap[i][j] ~= 0 then
        love.graphics.draw(world.spriteImages.tileSet, love.graphics.newQuad((world.tileMap[i][j]-1) * world.tileSize,0,world.tileSize, world.tileSize,17*world.tileSize, world.tileSize),i * world.tileSize, j * world.tileSize, 0, 1, 1, 0, world.tileSize)
      end
    end
  end
end


function world.build()
  for i = 1, world.w do
    world.putTile(i, 1, world.spriteImages.panelGrey)
  end
  for i = 1, world.w do
    world.putTile(i, world.h, world.spriteImages.panelGrey)
  end

  for i = 1, world.h do
    world.putTile(1, i, world.spriteImages.panelGrey)
  end
  for i = 1, world.h do
    world.putTile(world.w, i, world.spriteImages.panelGrey)
  end

end

-- put tile at specific coordinates
function world.putTile(mX, mY, mSprite)
  world.tileMap[mX][mY] = mySprite
end

-- get tile at specific coordinates
function world.getTile(mX, mY)
  return world.tileMap[mX][mY]
end

function world.absolutCoordToTileCoord(iX, iY)
  local x, y
  if iX % world.tileSize == 0 then
    x = math.floor(iX/world.tileSize) - 1
  else
    x = math.floor(iX/world.tileSize)
  end

  if iY % world.tileSize == 0 then
    y = math.floor(iY/world.tileSize)
  else
    y = math.floor(iY/world.tileSize) + 1
  end
  return x, y
end


function world.isSolid(mX, mY)
  local isSolid

  if world.tileMap[mX][mY] == 0 then
    isSolid = false
  else
    isSolid = true
  end


  return isSolid
end
