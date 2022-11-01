--[[ Multiple shaders usage ]]--

return function ()

  love.graphics.setDefaultFilter("linear", "linear") --default filter
  
  local gameWidth, gameHeight = 1080, 720

  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

  love.window.setMode(windowWidth, windowHeight, {resizable = true})
	push.setupScreen(gameWidth, gameHeight, {
    upscale = "normal",
    canvas = true
  })

  time = 0

  function love.load()
    image = love.graphics.newImage( "examples/multiple-shaders/love.png" )
    
    shader1 = love.graphics.newShader("examples/multiple-shaders/shader1.fs")
    shader2 = love.graphics.newShader("examples/multiple-shaders/shader2.fs")
    push.setShader({ shader1, shader2 })
  end
  
  function love.update(dt)
    time = (time + dt) % 1
    
    shader1:send("shift", 4 + math.cos( time * math.pi * 2 ) * 2)
    shader2:send("setting1", 40 + math.cos(love.timer.getTime() * 2) * 10)
  end

  function love.draw()
    push.start()
    
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(image, (gameWidth-image:getWidth())*.5, (gameHeight-image:getHeight())*.5)
    
    push.finish()
  end

end