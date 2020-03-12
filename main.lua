io.stdout:setvbuf('no')

push = require "push" --require the library
love.window.setTitle("Press space to switch examples")

local examples = {
  "low-res",
  "single-shader",
  "multiple-shaders",
  "mouse-input",
  "canvases-shaders",
  "stencil"
}
local example = 1

for i = 1, #examples do
  examples[i] = require("examples." .. examples[i])
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.keypressed(key, scancode, isrepeat)
  
  if key == "space" then
    example = (example < #examples) and example + 1 or 1
    
    --be sure to reset push settings
    push:resetSettings()
    
    examples[example]()
    love.load()
  elseif key == "f" then --activate fullscreen mode
    push:switchFullscreen() --optional width and height parameters for window mode
  end
  
end

examples[example]()