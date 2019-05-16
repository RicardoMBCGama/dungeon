local anim8 = require("./externalModules/anim8")
-- local fx = require("fx")



movingPlatform = {
  x = 0,
  y = 0,
  initialX = 0,
  moveSpan = 64,
  width = 8, -- to be checked
  height = 8,
  speed = 20, --200
  img = nil,
  animation = nil,
  deadAnimationImg = nil,
  yVelocity = 0,

  gravity = -800,
  isOnGround = true,
  margin = 0.1,


  xDirection = "right",


  animations = {}





}

function movingPlatform:load()
  -- player.img = love.graphics.newImage('images/player2.png')
  self.img = love.graphics.newImage('images/movingPlatform.png')
end

function movingPlatform:init(x, y)
  self.x = x
  self.y = y
  self.initialX = x
end


function movingPlatform:update(dt, world, player)


  local dX = 0


  if self.xDirection == "right" then
    dX = self.speed * dt
    self.xDirection = "right"
  elseif self.xDirection == "left" then
    dX = -self.speed * dt
    self.xDirection = "left"
  end

  if self.xDirection == 'right' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX + self.width, self.y)

    if mX <= world.w then
      if self.x > self.initialX + self.moveSpan then
        self.xDirection = "left"
      else
        self.x = self.x + dX


      end
    end
  elseif self.xDirection == 'left' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX , self.y)

    if mX >= 1 then
      if self.x < self.initialX then
        self.xDirection = "right"
      else
        self.x = self.x + dX

      end
    end
  end

  if self:checkPlayerCollision(player) then
    player.yVelocity = 0
    player.x = self.x
    player.isOnGround = true
    -- player.speed = self.speed
  end

end

function movingPlatform:checkPlayerCollision(player)
  if self.x < player.x + player.width and
     player.x < self.x + self.width and
     self.y < player.y + player.height and
     player.y < self.y + self.height then
    return true
  else
    return false
  end
end





function movingPlatform:draw()
  love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
end
