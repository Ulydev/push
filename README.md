**⚠️ Looking for maintainer:** as I am not working with LÖVE anymore, this repository is not actively maintained, except for critical fixes. Please do reach out if you're interested in maintaining this repository.

push
==============

push is a simple resolution-handling library that allows you to focus on making your game with a fixed resolution.

![image](https://media.giphy.com/media/xTb1RycLHeAOPDownu/giphy.gif)

Setup
----------------
Fullscreen
```lua
local push = require "push"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true})

function love.draw()
  push:start()
  
  --draw here
  
  push:finish()
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
  push:start()
  
  --draw here
  
  push:finish()
end
```

Usage
----------------

Init push
```lua
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen, resizable, canvas, pixelperfect})
```
**gameWidth**, **gameHeight** represent the game's fixed resolution. **windowWidth** and **windowHeight** are the dimensions of the window you need to adapt the game to.

The last argument is a table containing:
- **fullscreen** (bool): turns fullscreen mode on or off
- **resizable** (bool): allows resizing the window
- **canvas** (bool): uses canvas
- **pixelperfect** (bool): enables pixel-perfect mode (integer scaling 1x, 2x, 3x, ...)
- **highdpi** (bool): enables high-dpi mode on supported screens (e.g. Retina)
- **stretched** (bool): stretches the game to window dimensions

Apply **push** transforms
```lua
push:start()
--draw here
push:finish()

--alias
push:apply(operation)
```
**operation** should be equal to "start" or "end", meaning "before" or "after" your main drawing logic

Mobile support
----------------

**push** does *not* have built-in support for mobile platforms, but it is trivial to handle mobile screens correctly.

A possible solution is to initialize **push** in fullscreen mode:
```lua
local screenWidth, screenHeight = love.window.getDesktopDimensions()
push:setupScreen(gameWidth, gameHeight, screenWidth, screenHeight, { fullscreen = true, resizable = false, ... })
```

And listen to screen orientation changes:
```lua
function love.resize(w, h)
  return push:resize(w, h)
end
```

Multiple shaders
----------------

Any method that takes a shader as an argument can also take a *table* of shaders instead. The shaders will be applied in the order they're provided.

Set multiple global shaders
```lua
push:setShader({ shader1, shader2 })
```

Set multiple canvas-specific shaders
```lua
push:setupCanvas({ { name = "multiple_shaders", shader = { shader1, shader2 } } })
```

Advanced canvases/shaders
----------------

**push** provides basic canvas and shader functionality through the *canvas* flag in push:setupScreen() and push:setShader(), but you can also create additional canvases, name them for later use and apply multiple shaders to them.

Set up custom canvases
```lua
push:setupCanvas(canvasList)

--e.g. push:setupCanvas({   { name = "foreground", shader = foregroundShader }, { name = "background" }   })
```

Shaders can be passed to canvases directly through push:setupCanvas(), or you can choose to set them later.
```lua
push:setShader(canvasName, shader)
```

Then, you just need to draw your game on different canvases like you'd do with love.graphics.setCanvas():
```lua
push:setCanvas(canvasName)
```

Resizing the window
----------------

In order for push to take in account window resizing (if you have set {resizable = true} in push:setupScreen()), you need to call push:resize() like so:

```lua
function love.resize(w, h)
  push:resize(w, h)
end
```

Misc
----------------

Switch fullscreen
```lua
push:switchFullscreen(w, h)
```
**w** and **h** are optional parameters that are used in case the game switches to windowed mode

Set a post-processing shader (will apply to the whole screen)
```lua
push:setShader([canvasName], shader)
```
You don't need to call this every frame. Simply call it once, and it will be stored into **push** until you change it back to something else.
If no canvasName is passed, shader will apply to the final render. Use it at your advantage to combine shader effects.

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

Set border color
```lua
push:setBorderColor(r, g, b, a) --also accepts a table
```

