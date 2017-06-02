
coin = {
  x = 0,
  y = 0,
  width = 8,
  height = 8,
  speed = 150, --200
  img = nil,
  margin = 0.1,
  wasCollected = false,
  fx = require("fx"),
  canDestroy = false,

}

function coin:load()
  self.img = love.graphics.newImage('images/coin1.png')
  self.fx:load("images/fxCoinCollect.png", 12, 8 ,"1-5",nil)
end

function coin:init(x, y)
  self.x = x
  self.y = y
end

function coin:update(dt, world, player)

  if self:checkPlayerCollision(player) then
    player.scoreIncrease()
    self.fx:init(self.x, self.y)
    self.wasCollected = true
    self.canDestroy = true
  end

  if self.fx.startAnimation then
    self.fx:update(dt)
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
  love.graphics.draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
  self.fx:draw()

end

function coin:onfxAnimationEnd()
  self.fx.startAnimation = false
end
