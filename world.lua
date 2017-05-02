
tileContent = {
  tEmpty = 0,
  tSolid = 1
}


world = {
  -- w = 25,
  -- h = 20,
  w = 10,
  h = 10,
  tileSize = 16,
  worldOffsetX = 1,
  worldOffsetY = 1,
  tileMap = {},
  renderMap = {},
  spriteImages = {}


}

function world.load()

  world.spriteImages = {
    emptySprite = "",
    panelGrey = love.graphics.newImage('images/block2.png'),
  }

end




-- world initialisation
function world.init(worldWidth, worldHeight)
  world.w = worldWidth/world.tileSize
  world.h = worldHeight/world.tileSize

  for i = 1, world.w do
    world.tileMap[i] = {}
    world.renderMap[i] = {}
    for j = 1, world.h do
      world.tileMap[i][j] = world.spriteImages.emptySprite
      -- print(world.tileMap[i][j])
      -- print(world.spriteImages.panelGrey)
      --world.renderMap[i][j] = spriteContent.emptySprite
    end
  end
end

function world.draw()

  for i = 1, world.w do
    for j = 1, world.h do
      if world.tileMap[i][j] ~= world.spriteImages.emptySprite then

        love.graphics.draw(world.spriteImages.panelGrey, i * world.tileSize, j * world.tileSize, 0, 1, 1, 0, 16)
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





  -- world.putTile(13, 19, world.spriteImages.panelGrey)
  -- world.putTile(13, 28, world.spriteImages.panelGrey)
  --
  -- world.putTile(14, 28, world.spriteImages.panelGrey)
  -- -- world.putTile(25, 27, world.spriteImages.panelGrey)
  -- world.putTile(25, 26, world.spriteImages.panelGrey)
  -- world.putTile(25, 25, world.spriteImages.panelGrey)
  -- world.putTile(25, 24, world.spriteImages.panelGrey)
  -- world.putTile(25, 23, world.spriteImages.panelGrey)
  -- world.putTile(25, 22, world.spriteImages.panelGrey)
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
  -- print(x)
  -- print(y)
  return x, y
end


function world.isSolid(mX, mY)
  local isSolid
  -- print(mX)
  -- print(mY)

  if world.tileMap[mX][mY] == world.spriteImages.emptySprite then
    isSolid = false
  else
    isSolid = true
  end


  return isSolid
end


-- function world.getMaxMove(iX, iY, direction)
--
--   local maxMove = 0
--
--   if direction == 'right' then
--     maxMove = (math.floor(iX/16) + 1) * 16 - iX
--   elseif direction == 'left' then
--     maxMove = iX - math.floor(iX/16)
--   end
--
--   return maxMove
-- end
