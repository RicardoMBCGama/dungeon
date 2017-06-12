local anim8 = require("./externalModules/anim8")

coin = {
  x = 0,
  y = 0,
  width = 8,
  height = 8,
  speed = 150, --200
  img = nil,
  fxCoinCollectImg = nil,
  margin = 0.1,
  wasCollected = false,
  fx = require("fx"),
  canDestroy = false,
  animations = {}

}

function coin:load()
  self.img = love.graphics.newImage('images/coin1.png')

  self.fxCoinCollectImg = love.graphics.newImage("images/fxCoinCollect.png")
  local g = anim8.newGrid(12, 8, self.fxCoinCollectImg:getWidth(), self.fxCoinCollectImg:getHeight())
  self.animations["collected"] = anim8.newAnimation(g("1-5",1), 0.1, function(animation) animation:gotoFrame(6) animation:pause() self.canDestroy = true end)

end


function coin:init(x, y)
  self.x = x
  self.y = y
end

function coin:update(dt, world, player)
  if self.wasCollected ~= true and self:checkPlayerCollision(player) then
    player.scoreIncrease()
    self.wasCollected = true
    self.animations["collected"]:resume()
  end
  if self.wasCollected then
    self.animations["collected"]:update(dt)
  end
end

function coin:checkPlayerCollision(player)
  if self.x < player.x + player.width and
     player.x < self.x + self.width and
     self.y < player.y + player.height and
     player.y < self.y + self.height then
    return true
  else
    return false
  end
end

function coin:draw()
  if self.wasCollected then
    self.animations["collected"]:draw(self.fxCoinCollectImg, self.x, self.y, 0, 1, 1, 0, 8)
  else
    love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
  end
end
