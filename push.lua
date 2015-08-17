local push = {}
setmetatable(push, push)

function push:setupScreen(WWIDTH, WHEIGHT, RWIDTH, RHEIGHT, fullscreen)
  
  self._WWIDTH, self._WHEIGHT = WWIDTH, WHEIGHT
  self._RWIDTH, self._RHEIGHT = RWIDTH, RHEIGHT
  self._fullscreen = fullscreen
  
  love.window.setMode( self._RWIDTH, self._RHEIGHT, {fullscreen = self._fullscreen, borderless = false} )

  self._SCALEX, self._SCALEY = self._RWIDTH/self._WWIDTH, self._RHEIGHT/self._WHEIGHT
  self._SCALE = math.min(self._SCALEX, self._SCALEY)
  self._OFFSET = {x = (self._SCALEX - self._SCALE) * (self._WWIDTH/2), y = (self._SCALEY - self._SCALE) * (self._WHEIGHT/2)}
  
  self._INV_SCALE = 1/self._SCALE
  
  self._canvas = love.graphics.newCanvas(self._WWIDTH*self._SCALE, self._WHEIGHT*self._SCALE)

end

function push:setShader(shader)
  self._shader = shader
end

function push:apply(operation, shader)
  if operation == "start" then
    love.graphics.push()
    love.graphics.scale(self._SCALE)
    love.graphics.setCanvas(self._canvas)
  elseif operation == "end" then
    local tempShader = love.graphics.getShader()
    
    love.graphics.setCanvas()
    love.graphics.pop()
    love.graphics.setShader(shader or self._shader)
    love.graphics.translate(self._OFFSET.x, self._OFFSET.y)
    love.graphics.draw(self._canvas)
    self._canvas:clear()
    love.graphics.setShader(tempShader)
  end
end

function push:calculateScale(offset)
  self._SCALEX, self._SCALEY = self._RWIDTH/self._WWIDTH, self._RHEIGHT/self._WHEIGHT
  self._SCALE = math.min(self._SCALEX, self._SCALEY)+offset
  self._OFFSET = {x = (self._SCALEX - self._SCALE) * (self._WWIDTH/2), y = (self._SCALEY - self._SCALE) * (self._WHEIGHT/2)}
end

return push
