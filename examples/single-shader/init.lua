--[[ Shader usage ]]--

return function ()
  
  love.graphics.setDefaultFilter("linear", "linear") --default filter
  
  local gameWidth, gameHeight = 1080, 720

  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = false,
    resizable = true,
    highdpi = true,
    canvas = true
  })

  time = 0

  function love.load()
    image = love.graphics.newImage( "examples/single-shader/love.png" )
    
    shader = love.graphics.newShader("examples/single-shader/shader.fs")
    push:setShader( shader )
  end
  
  function love.update(dt)
    time = (time + dt) % 1
    shader:send("strength", 2 + math.cos(time * math.pi * 2) * .4)
  end

  function love.draw()
    push:apply("start")
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(image, (gameWidth-image:getWidth())*.5, (gameHeight-image:getHeight())*.5)
    
    push:apply("end")
  end
  
end