local push = require "push"

local gameWidth, gameHeight = 1080, 720

local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.5, windowHeight*.5

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})
push:setBorderColor{0, 0, 0} --default value

function love.load()
  love.graphics.setNewFont(32)
end

function love.draw()
  push:apply("start")
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill", gameWidth*.5, gameHeight*.5, 50)
  
  local mouseX, mouseY = love.mouse.getPosition()
  mouseX, mouseY = push:toGame(mouseX, mouseY)
  if not mouseX or not mouseY then mouseX, mouseY = "outside", "outside" end --if nil is returned, that means the mouse is outside the game screen

  love.graphics.print("mouse x : "..mouseX, gameWidth-300, 32)
  love.graphics.print("mouse y : "..mouseY, gameWidth-300, 64)
  
  love.graphics.setBackgroundColor(100, 100, 100)
  
  push:apply("end")
end

function love.keypressed(key, isrepeat)
  if key == "f" then --activate fullscreen mode
    push:switchFullscreen() --optional width and height parameters for window mode
  end
end