bomb = {
  x = 0,
  y = 0,
  width = 16,
  height = 16,
  speed = 150, --200
  img = nil,
  yVelocity = 0,
  jumpHeight = -300, --400
  gravity = -200,
  isOnGround = false,
  margin = 0.1

}

function bomb:load()
  self.img = love.graphics.newImage('images/bomb1.png')
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
    self.yVelocity = 0

  end

  if self:checkPlayerCollision(player) then
    player.hit()
  end

end

function bomb:checkPlayerCollision(player)
  if self.x < player.x + player.width and
     player.x < self.x + self.width and
     self.y < player.y + player.height and
     player.y < self.y + self.height then
       print('player damage')
       return true
  else
       return false
  end
end
