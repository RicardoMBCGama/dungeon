require("player")
require("world")
require("bomb")
require("utils")
require("particle")

-- local player = {}

local scaleAmount = 0
local xPadding = 0
local GAME_RENDER_WIDTH = 160   -- NOTE: Should be world.w * world.tileSize (16 multiples only)
local GAME_RENDER_HEIGHT =160  -- NOTE: Should be world.h * world.tileSize (16 multiples only)
local bombArray = {}


function love.load()

  -- NOTE: Uncomment next line to set window size
  love.window.setMode(600, 600, {resizable=true, vsync=true, minwidth=160, minheight=160})

  -- NOTE: new scaling system
  scaleAmount = love.graphics.getHeight()/GAME_RENDER_HEIGHT
  xPadding = (love.graphics.getWidth() - GAME_RENDER_WIDTH)/2



  love.graphics.setDefaultFilter('nearest', 'nearest')


  love.graphics.setBackgroundColor(29,39,34,255)

  world.load()

  world.init()


  player.load()
  player.x = GAME_RENDER_WIDTH/2
  player.y = GAME_RENDER_HEIGHT/2



  -- for i = 1, 5  do
  --   bombArray[i] = utils.copy(bomb)
  --   bombArray[i]:load()
  --   bombArray[i].x = 31 * i
  --   bombArray[i].y = 32
  -- end

  -- smallParticle = utils.copy(particle)
  -- smallParticle:load()


end

function love.update(dt)

  -- NOTE: new scaling system
  scaleAmount = love.graphics.getHeight()/GAME_RENDER_HEIGHT
  xPadding = (love.graphics.getWidth() - GAME_RENDER_WIDTH)/2

  player.update(dt, world)
  --
  -- for i = 1, #bombArray do
  --   bombArray[i]:update(dt,world,player)
  -- end
  --
  -- smallParticle:update(dt, world)



end

function love.draw()
  



  -- NOTE: new scaling system
  love.graphics.push()

  -- Adjust tilemap to screen on the left side
  -- NOTE: Not working properly, needs to be fixed
  love.graphics.translate(-world.worldOffsetX * world.tileSize * scaleAmount , 0 )
  -- love.graphics.translate(xPadding/scaleAmount, 0)

  local trans = math.floor(player.x / GAME_RENDER_WIDTH)

  if trans > 0 then
    love.graphics.translate(- trans * GAME_RENDER_WIDTH* scaleAmount, 0)
  end

  -- love.graphics.translate((-player.x + GAME_RENDER_WIDTH/2) * scaleAmount, (-player.y + GAME_RENDER_HEIGHT/2) * scaleAmount)


  love.graphics.scale(scaleAmount,scaleAmount)

  world.draw()

  -- TODO: should try this:
  -- love.graphics.setColor(0, 0, 0)


	-- love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 16)
  player.draw()
  --
  --
  --
  -- for i = 1, #bombArray do
  --   love.graphics.draw(bombArray[i].img, bombArray[i].x, bombArray[i].y, 0, 1, 1, 0, 16)
  -- end
  --
  -- smallParticle:draw()
  --
  -- -- love.graphics.print("Width: " .. love.graphics.getWidth() .. "Height: " .. love.graphics.getHeight() , 0, 0)

  -- NOTE: new scaling system
  love.graphics.pop()




end
