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
  
  self._borderColor = {0, 0, 0}

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
    
    local tr, tg, tb, ta = love.graphics.getColor()
    love.graphics.setColor(self._borderColor)
    if self._OFFSET.x ~= 0 then
      love.graphics.rectangle("fill", 0, 0, self._OFFSET.x, self._RHEIGHT)
      love.graphics.rectangle("fill", self._OFFSET.x+self._WWIDTH*self._SCALE, 0, self._OFFSET.x, self._RHEIGHT)
    elseif self._OFFSET.y ~= 0 then
      love.graphics.rectangle("fill", 0, 0, self._WWIDTH, self._OFFSET.y)
      love.graphics.rectangle("fill", 0, self._OFFSET.y+self._WHEIGHT*self._SCALE, self._WWIDTH, self._OFFSET.y)
    end
    love.graphics.setColor(tr, tg, tb, ta)
    
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

function push:setBorderColor(color)
  self._borderColor = color
end

function push:toGame(x, y)
  x, y = x-self._OFFSET.x, y-self._OFFSET.y
  x, y = (x>=0 and x<=self._WWIDTH*self._SCALE) and math.floor(x/self._SCALE) or nil, (y>=0 and y<=self._WHEIGHT*self._SCALE) and math.floor(y/self._SCALE) or nil
  return x, y
end

function push:toReal(x, y)
  return x*self._SCALE+self._OFFSET.x, y*self._SCALE+self._OFFSET.y
end

return push