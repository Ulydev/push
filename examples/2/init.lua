examples[2] = function() --low-rez example
  
  love.graphics.setDefaultFilter("nearest", "nearest") --disable blurry scaling
  
  local gameWidth, gameHeight = 64, 64

  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
  push:setBorderColor{0, 0, 0} --default value
  
  --
  
  time = 0

  function love.load()
    mario = love.graphics.newImage("examples/2/mario.png")
    background = love.graphics.newImage("examples/2/background.png")
    
    love.graphics.setNewFont(16)
  end
  
  function love.update(dt)
    
    time = time + dt
    if time > 1 then time = time - 1 end
    
  end

  function love.draw()
    push:apply("start")
    
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
    --if nil is returned, that means the mouse is outside the game screen
    
    local abs = math.abs(time-.5)
    local pi = math.cos(math.pi*2*time)
    local pi2 = math.cos(math.pi*8*time)
    local w = push:getWidth() 
    --for animating basic stuff
    
    love.graphics.draw(background, 0, 0)
    
    love.graphics.setScissor(0, 0, push:getWidth(), push:getHeight()-16)
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.draw(mario, 27, 33)
    love.graphics.setScissor()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(mario, 26, 32)
    
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.printf("Hi!", 34+1, 22-pi*2+1, w, "center", -.15+.5*abs, abs*.25+1, abs*.25+1, w*.5, 12)
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Hi!", 34, 22-pi*2, w, "center", -.15+.5*abs, abs*.25+1, abs*.25+1, w*.5, 12)

    love.graphics.setColor(255, 255, 255)
    if mouseX and mouseY then --cursor
      love.graphics.points(
        mouseX, mouseY-1,
        mouseX-1, mouseY,
        mouseX, mouseY,
        mouseX+1, mouseY,
        mouseX, mouseY+1
      )
    end
    
    push:apply("end")
  end
  
end