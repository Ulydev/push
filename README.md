push
==============

push is a simple resolution-handling library to allows you to focus on making your game with a fixed resolution.

![image](http://s15.postimg.org/4e8bvom0b/Untitled.png)

Setup
----------------
Fullscreen
```lua
local push = require "push"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true})

function love.draw()
  push:apply("start")
  
  --draw here
  
  push:apply("end")
end
```

Windowed
```lua
local push = require "push"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})

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
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen, resizable})
```
**gameWidth**, **gameHeight** represent the game's fixed resolution. **windowWidth** and **windowHeight** are the dimensions of the window you need to adapt the game to.

The last argument is a table containing:
- **fullscreen** is a bool that turns fullscreen mode on or off.
- **resizable** is a bool that allows resizing the window.

Apply push's transforms
```lua
push:apply(operation)
```
**operation** should be equal to "start" or "end", meaning "before" or "after" your main drawing logic

Miscellaneous functions
----------------

Switch fullscreen
```lua
push:switchFullscreen(w, h)
```
**w** and **h** are optional parameters that are used in case the game switches to windowed mode


Set a post-processing shader (will apply to the whole screen)
```lua
push:setShader(shader)
```
You don't need to call this every frame. Simply call it once, and it will be stored into push until you change it back to something else.


Convert coordinates
```lua
push:toGame(x, y) --convert coordinates from screen to game (useful for mouse position)
--push:toGame will return nil for the values that are outside the game - be sure to check that before using them

push:toReal(x, y) --convert coordinates from game to screen
```

Get game dimensions
```lua
push:getDimensions() --returns push:getWidth(), push:getHeight()

push:getWidth() --returns game width

push:getHeight() --returns game height
```

Resizing the window
----------------

In order for push to take in account window resizing (if you have set {resizable = true} in push:setupScreen()), you need to call push:resize() like so:

```lua
function love.resize(w, h)
  push:resize(w, h)
end
```
