io.stdout:setvbuf'no' 

push = require "push" --require the library
love.window.setTitle("Press Space to switch examples")

examples = {}
example = 1

require "examples/1"
require "examples/2"
require "examples/3"
require "examples/4"

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
    push:switchFullscreen(640, 480) --optional width and height parameters for window mode
  end
  
end

examples[example]()
