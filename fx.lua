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

function fx:load()
  self.img = love.graphics.newImage('images/fxSmokeJump.png')
  local g = anim8.newGrid(12, 8, self.img:getWidth(), self.img:getHeight())
  self.animation = anim8.newAnimation(g('1-7',1), 0.1, "pauseAtEnd")
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
