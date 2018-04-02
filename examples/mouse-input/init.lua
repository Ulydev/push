--[[ Mouse input ]]--

return function ()
  
  love.graphics.setDefaultFilter("linear", "linear") --default filter
  
  local gameWidth, gameHeight = 1080, 720

  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
    highdpi = true,
    canvas = false
  })
  push:setBorderColor(0, 0, 0) --default value

  function love.load()
    love.graphics.setNewFont(32)
  end

  function love.draw()
    push:apply("start")
    
    love.graphics.setColor(50, 0, 0)
    love.graphics.rectangle("fill", 0, 0, gameWidth, gameHeight)
    
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
    --nil is returned if mouse is outside the game screen
    
    love.graphics.setColor(255, 255, 255)
    if mouseX and mouseY then love.graphics.circle("line", mouseX, mouseY, 10) end
    
    love.graphics.printf("mouse x : " .. (mouseX or "outside"), 25, 25, gameWidth, "left")
    love.graphics.printf("mouse y : " .. (mouseY or "outside"), 25, 50, gameWidth, "left")
    
    push:apply("end")
  end
  
end