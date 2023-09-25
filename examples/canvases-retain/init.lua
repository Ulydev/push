--[[ Multiple canvases and shaders ]]--

return function ()
  
  love.graphics.setDefaultFilter("linear", "linear") --default filter
  
  local gameWidth, gameHeight = 800, 600

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
    push:setupCanvas({
      { name = "main" },
      { name = "retained", retain = true }  --canvas will not be cleared by push.finish()
    })
  end
  
  local canvasRendered = false
  
  function love.update(dt)
    if not canvasRendered then
      push:setCanvas("retained")
      love.graphics.rectangle("fill", 25, 25, 105, 100)
      push:setCanvas("main")
      canvasRendered = true
    end
  end

  function love.draw()
    push:start()
    push:setCanvas("main")
    love.graphics.rectangle('fill', 25, 130, 50, 50)
    love.graphics.rectangle('fill', 80, 130, 50, 50)
    push:finish()
  end
  
end