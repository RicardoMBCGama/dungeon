local anim8 = require("./externalModules/anim8")

local fx = {
  x = 0,
  y = 0,
  width = 8,
  height = 8,
  animation = nil,
  img = nil,
  startAnimation = false,
  finishedAnimation = false,
  drawAnim = true
}

function fx:load(spriteSheet, spritesWidth, spritesHeight, frames, endFunction)
  self.img = love.graphics.newImage(spriteSheet)
  local g = anim8.newGrid(spritesWidth, spritesHeight, self.img:getWidth(), self.img:getHeight())
  self.animation = anim8.newAnimation(g(frames,1), 0.1, "pauseAtEnd" or endFunction)
end

function fx:init(x, y)
  self.x = x
  self.y = y
  self.animation:gotoFrame(1)
  self.animation:resume()
  self.starAnimation = true

end


function fx:update(dt)
    self.animation:update(dt)
end

function fx:draw()
  self.animation:draw(self.img, self.x, self.y, 0, 1, 1, 0, 8)
end

return fx
