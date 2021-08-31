--[[ Low resolution ]]--

return function()

	love.graphics.setDefaultFilter("nearest", "nearest") -- Disable blurry scaling

	love.window.setMode(640, 480, {resizable = true}) -- LÖVE resolution 640x480, resizable
	push.setupScreen(64, 64, {upscale = "pixel-perfect", canvas = true}) -- push resolution 64x64, pixel perfect scaling, drawn to a canvas

	--

	time = 0

	function love.load()
		image = love.graphics.newImage("examples/low-res/image.png")

		love.graphics.setNewFont(16)
	end

	function love.update(dt)

		time = (time + dt) % 1

	end

	function love.draw()
		push.start()
			local mouseX, mouseY = love.mouse.getPosition()
			mouseX, mouseY = push.toGame(mouseX, mouseY)
			-- If false is returned, that means the mouse is outside the game screen

			local abs = math.abs(time-.5)
			local pi = math.cos(math.pi*2*time)
			local w = push:getWidth()
			--for animating basic stuff

			love.graphics.draw(image, 0, 0)

			love.graphics.setColor(0, 0, 0, 0.5)
			love.graphics.printf("Hi!", 31, 23-pi*2, w, "center", -.15+.5*abs, abs*.25+1, abs*.25+1, w*.5, 12)
			love.graphics.setColor(1, 1, 1)
			love.graphics.printf("Hi!", 30, 22-pi*2, w, "center", -.15+.5*abs, abs*.25+1, abs*.25+1, w*.5, 12)

			love.graphics.setColor(1, 1, 1)
			if mouseX and mouseY then --cursor
				love.graphics.points(
					mouseX, mouseY-1,
					mouseX-1, mouseY,
					mouseX, mouseY,
					mouseX+1, mouseY,
					mouseX, mouseY+1
				)
			end
		push.finish()
	end
end
