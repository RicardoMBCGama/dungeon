require("player")
require("world")
-- require("bomb")

-- local player = {}

local scale = {}
local GAME_RENDER_WIDTH = 160   -- NOTE: 16 multiples only
local GAME_RENDER_HEIGHT = 160  -- NOTE: 16 multiples only



function love.load()

  love.window.setMode(640, 640, {resizable=true, vsync=true, minwidth=160, minheight=160})

  -- NOTE: new scaling system
  scaleAmount = love.graphics.getHeight()/GAME_RENDER_HEIGHT
  xPadding = (love.graphics.getWidth() - GAME_RENDER_WIDTH * scaleAmount)/2



  love.graphics.setDefaultFilter('nearest', 'nearest')


  love.graphics.setBackgroundColor(0,0,0,255)

  world.load()
  world.init(GAME_RENDER_WIDTH, GAME_RENDER_HEIGHT)
  world.build()

  player.load()
  player.x = GAME_RENDER_WIDTH/2
  player.y = GAME_RENDER_HEIGHT/2

  -- bomb.load()
  -- bomb.x = GAME_RENDER_WIDTH/2 + 32
  -- bomb.y = 32



end

function love.update(dt)
  -- NOTE: new scaling system
  scaleAmount = love.graphics.getHeight()/GAME_RENDER_HEIGHT
  xPadding = (love.graphics.getWidth() - GAME_RENDER_WIDTH * scaleAmount)/2

  player.update(dt, world)
  -- bomb.update(dt, world)

end

function love.draw()



  -- NOTE: new scaling system
  love.graphics.push()

  -- Adjust tilemap to screen on the left side
  love.graphics.translate(-world.worldOffsetX * world.tileSize * scaleAmount , 0 )
  love.graphics.translate(xPadding, 0)
  love.graphics.scale(scaleAmount,scaleAmount)



  love.graphics.print("Widht: " .. love.graphics.getWidth() .. "Height: " .. love.graphics.getHeight() , 0, 0)

  world.draw()

  -- TODO: should try this:
  -- love.graphics.setColor(0, 0, 0)


	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 16)
  -- love.graphics.draw(bomb.img, bomb.x, bomb.y, 0, 1, 1, 0, 16)

  -- NOTE: new scaling system
  love.graphics.pop()




end
