examples[1] = function () --default example
  
  love.graphics.setDefaultFilter("linear", "linear") --default filter
  
  local gameWidth, gameHeight = 1080, 720

  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
  push:setBorderColor{0, 0, 0} --default value

  function love.load()
    love.graphics.setNewFont(32)
  end
  
  function love.update(dt)
    
  end

  function love.draw()
    push:apply("start")
    
    love.graphics.setColor(100, 100, 100)
    love.graphics.rectangle("fill", 0, 0, gameWidth, gameHeight)
    
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
    --if nil is returned, that means the mouse is outside the game screen
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", gameWidth*.5, gameHeight*.5, 50)
    
    love.graphics.setColor(200, 0, 0)
    if mouseX and mouseY then love.graphics.circle("line", mouseX, mouseY, 10) end
    
    love.graphics.print("mouse x : " .. (mouseX or "outside"), gameWidth-300, 32)
    love.graphics.print("mouse y : " .. (mouseY or "outside"), gameWidth-300, 64)
    
    push:apply("end")
  end
  
end