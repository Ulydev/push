local push = require "push"

local gameWidth, gameHeight = 1080, 720

local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, false)
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
  if not mouseX then mouseX, mouseY = "outside", "outside" end --if nil is returned, that means the mouse is outside the game screen

  love.graphics.print("mouse x : "..mouseX, gameWidth-300, 32)
  love.graphics.print("mouse y : "..mouseY, gameWidth-300, 64)
  
  love.graphics.setBackgroundColor(100, 100, 100)
  
  push:apply("end")
end

function love.keypressed(key, isrepeat)
  if key == "f" then --activate fullscreen mode
    if not push._fullscreen then
      windowWidth, windowHeight = love.window.getDesktopDimensions()
    else
      windowWidth, windowHeight = windowWidth*.7, windowHeight*.7
    end
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, not push._fullscreen)
  end
end