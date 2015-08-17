push
==============

push is a simple resolution-handling library to allows you to focus on making your game with a fixed resolution.

Setup
----------------
Fullscreen
```lua
local push = require "push"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, true)

function love.draw()
  push:apply(1)
  
  --draw here
  
  push:apply(2)
end
```

Windowed
```lua
local push = require "push"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, false)

function love.draw()
  push:apply("start")
  
  --draw here
  
  push:apply("end")
end
```

Usage
----------------

Init push
```lua
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, fullscreen)
```

Apply push's transforms
```lua
push:apply(operation)
```
operation (string) should be "start" or "end", meaning "before" or "after" drawing
