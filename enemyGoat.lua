local anim8 = require("./externalModules/anim8")
-- local fx = require("fx")

require("bullet")

enemyGoat = {
  x = 0,
  y = 0,
  width = 8, -- to be checked
  height = 8,
  speed = 20, --200
  img = nil,
  animation = nil,
  deadAnimationImg = nil,
  yVelocity = 0,
  jumpHeight = -250, --400
  gravity = -800,
  isOnGround = true,
  margin = 0.1,
  isDead = false,
  score = 0,
  life = 3,
  xDirection = "right",
  fx = require("fx"),
  canShoot = true,
  bulletItems = {},
  enemies = {},
  animations = {}





}

function enemyGoat:load()
  -- player.img = love.graphics.newImage('images/player2.png')
  self.img = love.graphics.newImage('images/enemyGoat.png')
  local g = anim8.newGrid(8, 8, self.img:getWidth(), self.img:getHeight())
  self.animations["standing"]= anim8.newAnimation(g('1-4',1), 0.15)

  self.deadAnimationImg = love.graphics.newImage("images/enemyDeath.png")
  local g = anim8.newGrid(12, 8, self.deadAnimationImg:getWidth(), self.deadAnimationImg:getHeight())
  self.animations["death"] = anim8.newAnimation(g("1-8",1), 0.1, function(animation) animation:gotoFrame(9) animation:pause() self.canDestroy = true end)
  self.animations["death"]:pause()



end

function enemyGoat:init(x, y)
  self.x = x
  self.y = y
end


function enemyGoat:update(dt, world, player)


  local dX = 0

  if self.isDead then
    self.animations["death"]:update(dt)
  else

  self.animations["standing"]:update(dt)

  if self:checkPlayerCollision(player) then
    player.hit()
  end

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
      if world.isSolid (mX, mY) or not world.isSolid (mX, mY+1) then
        self.xDirection = "left"
      else
        self.x = self.x + dX
      end
    end
  elseif self.xDirection == 'left' then
    mX, mY = world.absolutCoordToTileCoord(self.x + dX , self.y)

    if mX >= 1 then
      if world.isSolid (mX, mY) or not world.isSolid (mX, mY+1) then
        self.xDirection = "right"
      else
        self.x = self.x + dX
      end
    end
  end

end

end


function enemyGoat:checkPlayerCollision(player)
  if self.x < player.x + player.width and
     player.x < self.x + self.width and
     self.y < player.y + player.height and
     player.y < self.y + self.height then
    return true
  else
    return false
  end
end

function enemyGoat:draw()
  if self.isDead then
    self.animations["death"]:draw(self.deadAnimationImg, self.x, self.y, 0, 1, 1, 0, 8)
  else
    self.animations["standing"]:draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
  end
end

function enemyGoat:hit()
  if self.life > 1 then
    self.life = self.life - 1
  else
    self.isDead = true
    self.animations["death"]:resume()
  end
end

function enemyGoat:scoreIncrease()
  self.score = self.score + 1
end
