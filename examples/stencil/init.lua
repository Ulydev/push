--[[ Stencil ]]--

return function()
  
  love.graphics.setDefaultFilter("nearest", "nearest") --disable blurry scaling
  
  local gameWidth, gameHeight = 64, 64

  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
    pixelperfect = true
  })
  push:setBorderColor{0, 0, 0} --default value

  push:setupCanvas({
    { name = 'main_canvas' },
    { name = 'stencil_canvas', stencil = true}
  })
  
  --
  
  time = 0

  function love.load()
    mario = love.graphics.newImage("examples/low-res/mario.png")
    background = love.graphics.newImage("examples/low-res/background.png")
    
    love.graphics.setNewFont(32)
  end
  
  function love.update(dt)
    
    time = (time + dt) % 1
    
  end

  function love.draw()
    push:apply("start")
    
    -- apply stencil
    push:setCanvas("stencil_canvas")
    love.graphics.stencil(function()
      love.graphics.setColor(1, 1, 1)
      local time = love.timer.getTime() * 3
      love.graphics.circle("fill", push:getWidth()*.5 + math.cos(time) * 20, push:getHeight()*.5 + math.sin(time) * 20, 10 + math.sin(time) * 2)
    end, 'replace', 1)

    -- draw background with stencil
    love.graphics.setStencilTest('greater', 0)
    love.graphics.draw(background, 0, 0)
    love.graphics.setStencilTest()

    -- switch to main canvas unaffected by stencil, but drawn behind stencil_canvas
    -- (this is why the circle draws on top of the mouse)
    push:setCanvas("main_canvas")

    love.graphics.setColor(1, 1, 1)
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
    --if nil is returned, that means the mouse is outside the game screen
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