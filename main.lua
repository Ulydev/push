push = require "push" --require the library
love.window.setTitle("Press space to switch examples!")

local examples = {
	"low-res",
	--[[
	"single-shader",
	"multiple-shaders",
	--]]
	"mouse-input"
	--[[
	"canvases-shaders",
	"stencil"
	--]]
}
local example = 1

for i = 1, #examples do
	examples[i] = require("examples." .. examples[i])
end

function love.resize(w, h)
	push.resize(w, h)
end

function love.keypressed(key)
	if key == "space" then
		example = (example < #examples) and example + 1 or 1

		examples[example]()
		love.load()
	elseif key == "f" then -- Activate fullscreen mode
		love.window.setMode(0, 0, {fullscreen = true, fullscreentype = "desktop"})
		push.resize(love.graphics.getDimensions())
	elseif key == "escape" then
		love.event.quit()
	end
end

examples[example]()
