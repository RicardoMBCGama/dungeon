local anim8 = require("./externalModules/anim8")
-- local fx = require("fx")

require("bullet")

player = {
  x = 0,
  y = 0,
  width = 8,
  height = 8,
  speed = 100, --200
  img = nil,
  animation = nil,
  yVelocity = 0,
  jumpHeight = -250, --400
  gravity = -800,
  isOnGround = false,
  margin = 0.1,
  isDeath = false,
  score = 0,
  life = 3,
  xDirection = "right",
  fx = require("fx"),
  canShoot = true,
  bulletItems = {}





}

function player.load()
  -- player.img = love.graphics.newImage('images/player2.png')
  player.img = love.graphics.newImage('images/Sprite-0004.png')
  local g = anim8.newGrid(8, 8, player.img:getWidth(), player.img:getHeight())

  player.basicAnimation = anim8.newAnimation(g('1-4',1), 0.15)
  -- player.jumpAnimation = anim8.newAnimation(g('1-4',2), 0.15, 'pauseAtEnd')

  player.animation = player.basicAnimation
  player.fx:load("images/fxPlayerJump.png", 12, 8 ,"1-6")
  -- player.bullet:load()



end

function player.update(dt, world)


  local dX = 0
  local dY = 0
  local mX, mY
  local left = 0
  local down = 0
  local xDirection = ''
  local yDirection = ''

  player.animation:update(dt)

  -- if love.keyboard.isDown('x') then
  --
  --   local bulletItem = utils.copy(bullet)
  --   bulletItem:load()
  --   bulletItem:init(player.x, player.y, player, nil, "right")
  --   table.insert(player., bulletItem)
  -- end



  -- Update bulletItems

  local i=1
  while player.bulletItems[i] do
    if player.bulletItems[i].canDestroy then

      table.remove(player.bulletItems, i)

    else
      player.bulletItems[i]:update(dt, world, player)
    end
    i = i + 1
  end






  if love.keyboard.isDown('right') then
    if player.x < (world.w * world.tileSize - player.width) then
      dX = player.speed * dt
      player.xDirection = 'right'
    end
  elseif love.keyboard.isDown('left') then
    if player.x > 0 then
      dX = -player.speed * dt
      player.xDirection = 'left'
    end
  end

  if player.xDirection == 'right' then
    mX, mY = world.absolutCoordToTileCoord(player.x + dX + player.width, player.y)

    if mX <= world.w then
      if world.isSolid (mX, mY) then
        player.x = math.floor((player.x + dX + player.width)/world.tileSize) * world.tileSize - player.width
      else
        player.x = player.x + dX
      end
    end
  elseif player.xDirection == 'left' then
    mX, mY = world.absolutCoordToTileCoord(player.x + dX , player.y)

    if mX >= 1 then

      if world.isSolid (mX, mY) then
        player.x = (math.floor((player.x + dX)/world.tileSize) + 1) * world.tileSize + player.margin -- is the margin we want from obstacle to player
      else
        player.x = player.x + dX
      end
    end
  end

  player.yVelocity = player.yVelocity - player.gravity * dt
  dY = player.yVelocity * dt

  if player.yVelocity > 0 then
    mX, mY = world.absolutCoordToTileCoord(player.x, player.y + dY)
    mwX, mwY = world.absolutCoordToTileCoord(player.x + player.width, player.y + dY)
  else
    mX, mY = world.absolutCoordToTileCoord(player.x, player.y - player.height+ dY)
    mwX, mwY = world.absolutCoordToTileCoord(player.x + player.width, player.y - player.height+ dY)
  end

  if world.isSolid(mX,mY) or world.isSolid(mwX, mwY) then
    if player.yVelocity > 0 then

      player.y = mY * world.tileSize - player.height
      player.isOnGround = true
      player.animation = player.basicAnimation
    else
      player.y = mY * world.tileSize + player.height
      player.yVelocity = - player.gravity * dt
    end
  else
    player.y = player.y + dY
    player.isOnGround = false
  end
  -- print(player.isOnGround)

  if player.isOnGround then
    player.yVelocity = 0
    if love.keyboard.isDown('c') then
      player.isOnGround = false
      -- player.animation = player.jumpAnimation
      player.fx:init(player.x, player.y)

      player.yVelocity = player.jumpHeight
      dY = player.yVelocity * dt
      player.y = player.y + dY
    end
  end

  if player.fx.startAnimation then
    player.fx:update(dt)
  end

end

function player.draw()
  player.animation:draw(player.img, player.x, player.y, 0, 1, 1, 0, 8)
  player.fx:draw()
  for i = 1, #player.bulletItems do
    player.bulletItems[i]:draw()
  end
end

function player.hit()
  player.isOnGround = false
  player.yVelocity = player.jumpHeight
  if player.life > 0 then
    player.life = player.life - 1
  else
    player.isDeath = true
  end


end

function player.scoreIncrease()
  player.score = player.score + 1
end



-- Check keyboard press and release to control shooting intervals
function love.keypressed( key )
   if key == "x" and player.canShoot then
     player.canShoot = false
     local bulletItem = utils.copy(bullet)
     bulletItem:load()
     bulletItem:init(player.x, player.y, player, world.objectItems, "right")
     table.insert(player.bulletItems, bulletItem)

   end
end

function love.keyreleased( key )
   if key == "x" then
      player.canShoot = true
   end
end
