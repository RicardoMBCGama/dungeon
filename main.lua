require("player")
require("world")
require("bomb")
require("utils")

-- local player = {}

local scale = {}
local GAME_RENDER_WIDTH = 240   -- NOTE: Should be world.w * world.tileSize (16 multiples only)
local GAME_RENDER_HEIGHT = 240  -- NOTE: Should be world.h * world.tileSize (16 multiples only)
local bombArray = {}


function love.load()

  -- NOTE: Uncomment next line to set window size
  love.window.setMode(640, 640, {resizable=true, vsync=true, minwidth=160, minheight=160})

  -- NOTE: new scaling system
  scaleAmount = love.graphics.getHeight()/GAME_RENDER_HEIGHT
  xPadding = (love.graphics.getWidth() - GAME_RENDER_WIDTH * scaleAmount)/2



  love.graphics.setDefaultFilter('nearest', 'nearest')


  love.graphics.setBackgroundColor(0,0,0,255)

  world.load()

  world.init()
  -- world.build()

  player.load()
  player.x = GAME_RENDER_WIDTH/2
  player.y = GAME_RENDER_HEIGHT/2

  -- bomb.load()


  for i = 1, 5  do
    bombArray[i] = utils.copy(bomb)
    bombArray[i]:load()
    bombArray[i].x = 31 * i
    bombArray[i].y = 32
  end

  -- bomb.x = GAME_RENDER_WIDTH/2 + 32
  -- bomb.y = 32





end

function love.update(dt)

  -- NOTE: new scaling system
  scaleAmount = love.graphics.getHeight()/GAME_RENDER_HEIGHT
  xPadding = (love.graphics.getWidth() - GAME_RENDER_WIDTH * scaleAmount)/2

  player.update(dt, world)
  -- bomb.update(dt, world, player)
  for i = 1, #bombArray do
    bombArray[i]:update(dt,world,player)
  end

  -- for i = 1, #bombArray do
  --   if bombArray[i].isOnGround then
  --     bombArray[i].y = 32
  --   end
  -- end

end

function love.draw()



  -- NOTE: new scaling system
  love.graphics.push()

  -- Adjust tilemap to screen on the left side
  love.graphics.translate(-world.worldOffsetX * world.tileSize * scaleAmount , 0 )
  love.graphics.translate(xPadding, 0)
  -- love.graphics.translate((-player.x + 100) * scaleAmount, (-player.y + 100) * scaleAmount)
  love.graphics.scale(scaleAmount,scaleAmount)

  world.draw()

  -- TODO: should try this:
  -- love.graphics.setColor(0, 0, 0)


	-- love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 16)
  player.draw()



  for i = 1, #bombArray do
    love.graphics.draw(bombArray[i].img, bombArray[i].x, bombArray[i].y, 0, 1, 1, 0, 16)
  end

  -- love.graphics.print("Width: " .. love.graphics.getWidth() .. "Height: " .. love.graphics.getHeight() , 0, 0)

  -- NOTE: new scaling system
  love.graphics.pop()




end
