local anim8 = require("./externalModules/anim8")



particle = {
  x = 160,
  y = 160,
  width = 1,
  height = 1,
  speed = 10, --200
  img = nil,
  animation = nil,
  yVelocity = 20,
  jumpHeight = -350, --400
  gravity = -1000,
  isOnGround = false,
  margin = 0.1


}

function particle:load()

  self.img = love.graphics.newImage('images/particle1.png')

end

function particle:update(dt, world)


  local dX = 0
  local dY = 0
  local mX, mY
  local left = 0
  local down = 0
  local xDirection = ''
  local yDirection = ''



  dX = self.speed * dt

  if self.speed > 0 then
    xDirection = 'right'
  elseif self.speed < 0 then
    xDirection = 'left'
  end

  if xDirection == 'right' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX + self.width, self.y)

    if mX <= world.w then
      if world.isSolid (mX, mY) then
        self.x = math.floor((self.x + dX + self.width)/world.tileSize) * world.tileSize - self.width
      else
        self.x = self.x + dX
      end
    end
  elseif xDirection == 'left' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX , self.y)

    if mX >= 1 then

      if world.isSolid (mX, mY) then
        self.x = (math.floor((self.x + dX)/world.tileSize) + 1) * world.tileSize + self.margin -- is the margin we want from obstacle to player
      else
        self.x = self.x + dX
      end
    end
  end

  self.yVelocity = self.yVelocity - self.gravity * dt
  dY = self.yVelocity * dt

  if self.yVelocity > 0 then
    mX, mY = world.absolutCoordToTileCoord(self.x, self.y + dY)
    mwX, mwY = world.absolutCoordToTileCoord(self.x + self.width, self.y + dY)
  else
    mX, mY = world.absolutCoordToTileCoord(self.x, self.y - self.height+ dY)
    mwX, mwY = world.absolutCoordToTileCoord(self.x + self.width, self.y - self.height+ dY)
  end

  if world.isSolid(mX,mY) or world.isSolid(mwX, mwY) then
    if self.yVelocity > 0 then

      self.y = mY * world.tileSize - self.height
      self.isOnGround = true
      self.animation = self.basicAnimation
    else
      self.y = mY * world.tileSize + self.height
      self.yVelocity = - self.gravity * dt
    end
  else
    self.y = self.y + dY
    self.isOnGround = false
  end
  -- print(player.isOnGround)

  if self.isOnGround then
    self.yVelocity = 0
  end

end

function particle:draw()
  love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 16)
end
