--[[ Mouse input ]]--

return function ()

	love.graphics.setDefaultFilter("linear", "linear") -- Bilinear scaling

	love.window.setMode(1280, 720, {resizable = true}) -- LÖVE resolution 1280x720, resizable
	push.setupScreen(800, 600, {canvas = true}) -- push resolution 64x64, pixel perfect scaling, drawn to a canvas

	function love.load()
		love.graphics.setNewFont(32)
	end

	function love.draw()
		local pushWidth, pushHeight = push.getDimensions()

		push.start()
			love.graphics.setColor(50, 0, 0)
			love.graphics.rectangle("fill", 0, 0, pushWidth, pushHeight)

			local mouseX, mouseY = love.mouse.getPosition()
			mouseX, mouseY = push.toGame(mouseX, mouseY) -- false is returned if mouse is outside the game screen
			-- Good practice to floor returned values when simulating screen pixels
			if mouseX then mouseX = math.floor(mouseX) end
			if mouseY then mouseY = math.floor(mouseY) end

			love.graphics.setColor(255, 255, 255)
			if mouseX and mouseY then love.graphics.circle("line", mouseX, mouseY, 10) end

			love.graphics.printf("mouse x : " .. (mouseX or "outside"), 25, 25, pushWidth, "left")
			love.graphics.printf("mouse y : " .. (mouseY or "outside"), 25, 50, pushWidth, "left")
		push.finish()
	end
end
