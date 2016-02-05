-- push.lua v0.1

-- Copyright (c) 2015 Ulysse Ramage
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

local push = {}
setmetatable(push, push)

function push:setupScreen(WWIDTH, WHEIGHT, RWIDTH, RHEIGHT, f)
  
  f = f or {}
  
  self._WWIDTH, self._WHEIGHT = WWIDTH, WHEIGHT
  self._RWIDTH, self._RHEIGHT = RWIDTH, RHEIGHT
  self._fullscreen = f.fullscreen or self._fullscreen or  false
  self._resizable = f.resizable or self._resizable or false
  
  love.window.setMode( self._RWIDTH, self._RHEIGHT, {fullscreen = self._fullscreen, borderless = false, resizable = self._resizable} )
  
  self:initValues()
  
  if not self._canvas then self:createCanvas() end
  
  self._borderColor = {0, 0, 0}

end

function push:createCanvas()
  self._canvas = love.graphics.newCanvas(self._WWIDTH, self._WHEIGHT)
end

function push:initValues()
  self._SCALEX, self._SCALEY = self._RWIDTH/self._WWIDTH, self._RHEIGHT/self._WHEIGHT
  self._SCALE = math.min(self._SCALEX, self._SCALEY)
  self._OFFSET = {x = (self._SCALEX - self._SCALE) * (self._WWIDTH/2), y = (self._SCALEY - self._SCALE) * (self._WHEIGHT/2)}
  self._GWIDTH, self._GHEIGHT = self._RWIDTH-self._OFFSET.x, self._RHEIGHT-self._OFFSET.y
  
  self._INV_SCALE = 1/self._SCALE
end

function push:setShader(shader)
  self._shader = shader
end

function push:apply(operation, shader)
  if operation == "start" then
    love.graphics.push()
    --love.graphics.scale(self._SCALE)
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
      love.graphics.rectangle("fill", 0, 0, self._RWIDTH, self._OFFSET.y)
      love.graphics.rectangle("fill", 0, self._OFFSET.y+self._WHEIGHT*self._SCALE, self._RWIDTH, self._OFFSET.y)
    end
    love.graphics.setColor(tr, tg, tb, ta)
    
    love.graphics.translate(self._OFFSET.x, self._OFFSET.y)
    love.graphics.setColor(255, 255, 255)
    love.graphics.setShader(self._shader)
    love.graphics.draw(self._canvas, 0, 0, 0, self._SCALE, self._SCALE)
    love.graphics.setCanvas(self._canvas)
    love.graphics.clear()
    love.graphics.setCanvas()
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
  local normalX, normalY = x/self._GWIDTH, y/self._GHEIGHT
  x, y = (x>=0 and x<=self._WWIDTH*self._SCALE) and normalX*(self._WWIDTH-self._OFFSET.x) or nil, (y>=0 and y<=self._WHEIGHT*self._SCALE) and normalY*(self._WHEIGHT-self._OFFSET.y) or nil
  return x, y
end

function push:toReal(x, y)
  return x+self._OFFSET.x, y+self._OFFSET.y
end

function push:switchFullscreen(winw, winh)
  self._fullscreen = not self._fullscreen
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  self._RWIDTH = self._fullscreen and windowWidth or winw or windowWidth*.5
  self._RHEIGHT = self._fullscreen and windowHeight or winh or windowHeight*.5
  self:initValues()
  love.window.setFullscreen(self._fullscreen, "desktop")
end

function push:resize(w, h)
  push._RWIDTH = w
  self._RHEIGHT = h
  self:initValues()
end

return push
