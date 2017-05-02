bomb = {
  x = 0,
  y = 0,
  width = 16,
  height = 16,
  speed = 150, --200
  img = nil,
  yVelocity = 0,
  jumpHeight = -300, --400
  gravity = -1000,
  isOnGround = false,
  margin = 0.1

}

function bomb.load()
  bomb.img = love.graphics.newImage('images/bomb1.png')
end

function bomb.update(dt, world)
  local dX = 0
  local dY = 0
  local mX, mY
  local left = 0
  local down = 0
  local xDirection = ''
  local yDirection = ''



  bomb.yVelocity = bomb.yVelocity - bomb.gravity * dt
  dY = bomb.yVelocity * dt


    mX, mY = world.absolutCoordToTileCoord(bomb.x, bomb.y + dY)
    mwX, mwY = world.absolutCoordToTileCoord(bomb.x + bomb.width, bomb.y + dY)


  if world.isSolid(mX,mY) or world.isSolid(mwX, mwY) then
      bomb.y = mY * world.tileSize - bomb.height
      bomb.isOnGround = true
  else
    bomb.y = bomb.y + dY
    bomb.isOnGround = false
  end


  if bomb.isOnGround then
    bomb.yVelocity = 0
  end

end
