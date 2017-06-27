
bomb = {
  x = 0,
  y = 0,
  initialX = 0,
  initialY = 0,
  width = 3,
  height = 3,
  speed = 150, --200
  img = nil,
  yVelocity = 50,
  jumpHeight = -300, --400
  gravity = 0,---20, -- -200,
  isOnGround = false,
  margin = 0.1,
  hasExploded = false,
  fx = require("fx"),
  canDestroy = false



}

function bomb:load()
  self.img = love.graphics.newImage('images/bullet.png')
  self.fx:load("images/fxSmokeJump.png", 12, 8 ,"1-8", nil)
end

function bomb:init(x, y)
  self.x = x
  self.y = y
  self.initialX = x
  self.initialY = y
end

function bomb:update(dt, world, player)
  local dX = 0
  local dY = 0
  local mX, mY
  local left = 0
  local down = 0
  local xDirection = ''
  local yDirection = ''


  self.yVelocity = self.yVelocity - self.gravity * dt
  dY = self.yVelocity * dt


    mX, mY = world.absolutCoordToTileCoord(self.x, self.y + dY)
    mwX, mwY = world.absolutCoordToTileCoord(self.x + self.width, self.y + dY)

  if world.isSolid(mX,mY) or world.isSolid(mwX, mwY) then
      self.y = mY * world.tileSize - self.height
      self.isOnGround = true
  else
    self.y = self.y + dY
    self.isOnGround = false
  end


  if self.isOnGround then
    -- self.yVelocity = 0
    -- self.fx:init(self.x, self.y)
    -- self.hasExploded = true
    -- self.canDestroy = true
    self.x = self.initialX
    self.y = self.initialY
  end

  if self:checkPlayerCollision(player) then
    player.hit()
    -- self.fx:init(self.x, self.y)
    -- self.hasExploded = true
    -- self.canDestroy = true
    self.x = self.initialX
    self.y = self.initialY
  end

  if self.fx.startAnimation then
    self.fx:update(dt)
  end

end

function bomb:checkPlayerCollision(player)
  if self.x < player.x + player.width and
     player.x < self.x + self.width and
     self.y < player.y + player.height and
     player.y < self.y + self.height then
    return true
  else
     return false
  end
end

function bomb:draw()
  love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
  self.fx:draw()

end

function bomb:onfxAnimationEnd()
  self.fx.startAnimation = false

end
