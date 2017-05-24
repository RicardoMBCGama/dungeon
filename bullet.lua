
bullet = {
  x = 0,
  y = 0,
  width = 8,
  height = 8,
  speed = 150, --200
  img = nil,
  yVelocity = 0,
  jumpHeight = -300, --400
  gravity = -0, -- -200,
  isOnGround = false,
  margin = 0.1,
  hasExploded = false,
  xDirection = nil,
  owner = nil,
  fx = require("fx")



}

function bullet:load()
  self.img = love.graphics.newImage('images/bomb1.png')
  self.fx:load("images/fxSmokeJump.png", 12, 8 ,"1-8", nil)
end

function bullet:init(x, y, bulletOwner, colidesWith, horizontalDirection)
  self.x = x + 16
  self.y = y
  self.owner = bulletOwner
  self.xDirection = horizontalDirection
  self.wasShoot = true
end

function bullet:update(dt, world, player)
  local dX = 0
  local dY = 0
  local mX, mY
  local left = 0
  local down = 0
  -- local self.xDirection = ''
  local yDirection = ''

  print(self.x)
  print(self.y)


  if self.wasShoot then
  dX = self.speed * dt

  if self.xDirection == 'right' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX + self.width, self.y)

    if mX <= world.w then
      if world.isSolid (mX, mY) then

        self.fx:init(self.x, self.y)
        self.hasExploded = true
      else
        self.x = self.x + dX
      end
    end
  elseif self.xDirection == 'left' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX , self.y)

    if mX >= 1 then

      if world.isSolid (mX, mY) then

        self.fx:init(self.x, self.y)
        self.hasExploded = true
      else
        self.x = self.x + dX
      end
    end
  end


  -- self.yVelocity = self.yVelocity - self.gravity * dt
  -- dY = self.yVelocity * dt
  --
  --
  --   mX, mY = world.absolutCoordToTileCoord(self.x, self.y + dY)
  --   mwX, mwY = world.absolutCoordToTileCoord(self.x + self.width, self.y + dY)
  --
  -- if world.isSolid(mX,mY) or world.isSolid(mwX, mwY) then
  --     self.y = mY * world.tileSize - self.height
  --     self.isOnGround = true
  -- else
  --   self.y = self.y + dY
  --   self.isOnGround = false
  -- end
  --
  --
  -- self.yVelocity = self.yVelocity - self.gravity * dt
  -- dY = self.yVelocity * dt
  --
  --
  --   mX, mY = world.absolutCoordToTileCoord(self.x, self.y + dY)
  --   mwX, mwY = world.absolutCoordToTileCoord(self.x + self.width, self.y + dY)
  --
  -- if world.isSolid(mX,mY) or world.isSolid(mwX, mwY) then
  --     self.y = mY * world.tileSize - self.height
  --     self.isOnGround = true
  -- else
  --   self.y = self.y + dY
  --   self.isOnGround = false
  -- end
  --
  --
  -- if self.isOnGround then
  --   self.yVelocity = 0
  --   self.fx:init(self.x, self.y)
  --   self.hasExploded = true
  -- end
  --
  -- -- if self:checkPlayerCollision(player) then
  -- --   player.hit()
  -- --   self.fx:init(self.x, self.y)
  -- --   self.hasExploded = true
  -- -- end
  --
  if self.fx.starAnimation then
    self.fx:update(dt)
  end
end
end

function bullet:checkPlayerCollision(player)
  if self.x < player.x + player.width and
     player.x < self.x + self.width and
     self.y < player.y + player.height and
     player.y < self.y + self.height then
    return true
  else
     return false
  end
end

function bullet:draw()
  love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
  self.fx:draw()

end

function bullet:onfxAnimationEnd()
  self.fx.startAnimation = false
end

return bullet
