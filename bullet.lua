local anim8 = require("./externalModules/anim8")

bullet = {
  x = 0,
  y = 0,
  width = 3,
  height = 3,
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
  targets = {},
  canDestroy = false,
  animations = {}



}

function bullet:load()
  self.img = love.graphics.newImage('images/bullet.png')
  self.fxBulletExplosion = love.graphics.newImage("images/fxCoinCollect.png")
  local g = anim8.newGrid(12, 8, self.fxBulletExplosion:getWidth(), self.fxBulletExplosion:getHeight())
  self.animations["exploded"] = anim8.newAnimation(g("1-5",1), 0.1, function(animation) animation:gotoFrame(6) animation:pause() self.canDestroy = true end)
end

function bullet:init(x, y, bulletOwner, colidesWith, horizontalDirection)

  if horizontalDirection == "right" then
    self.x = x + self.margin
  else
    self.x = x - self.margin
  end


  self.y = y
  self.owner = bulletOwner
  self.targets = colidesWith
  self.xDirection = horizontalDirection
  self.wasShoot = true
end

function bullet:update(dt, world, player)
  local dX = 0
  local dY = 0
  local mX, mY
  local left = 0
  local down = 0
  local yDirection = ''

  dX = self.speed * dt
  if self.hasExploded then
    self.animations["exploded"]:update(dt)
  else

  if self.xDirection == 'right' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX + self.width, self.y)

    if mX <= world.w then
      if world.isSolid (mX, mY) then
        self.hasExploded = true
        self.animations["exploded"]:resume()
      elseif self:checkTargetCollision() then
        self.hasExploded = true
        self.animations["exploded"]:resume()

      else
        self.x = self.x + dX
      end
    end
  elseif self.xDirection == 'left' then
    mX, mY = world.absolutCoordToTileCoord(self.x - dX , self.y)

    if mX >= 1 then

      if world.isSolid (mX, mY) then
        self.hasExploded = true
        self.animations["exploded"]:resume()
      elseif self:checkTargetCollision() then
        self.hasExploded = true
        self.animations["exploded"]:resume()
      else
        self.x = self.x - dX
      end
    end
  end

end
end

function bullet:checkTargetCollision()

  local collidedWithTarget = false

  local i=1


  while self.targets[i] do

    if self.x < self.targets[i].x + self.targets[i].width and
       self.targets[i].x < self.x + self.width and
       self.y < self.targets[i].y + self.targets[i].height and
       self.targets[i].y < self.y + self.height and not self.targets[i].isDead then
         --TODO: Add :hit() on targets

      if self.targets[i].hit ~= nil then
        self.targets[i]:hit()
      end


      collidedWithTarget = true break end
    i = i+1
  end
    return collidedWithTarget
  end


function bullet:draw()
  if self.hasExploded then
    self.animations["exploded"]:draw(self.fxBulletExplosion, self.x, self.y, 0, 1, 1, 0, 8)
  else
    love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
  end
end
