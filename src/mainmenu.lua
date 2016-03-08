mainmenu    = {}

function mainmenu:enter()
	-- Stop all audios
	love.audio.stop()

	-- Set random colors
	push:setBorderColor{love.graphics.getBackgroundColor()}
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10))

	-- load the logo
	logo = {}
	logo.palco     = love.graphics.newImage("sprites/palcodev.png")
	logo.palcosize = 1
	logo.image     = love.graphics.newImage("sprites/logo.png")
	logo.w         = logo.image:getWidth()
	logo.h         = logo.image:getHeight()
	logo.x         = Width / 2
	logo.y         = 0.01 * Height
	logo.ox        = logo.w / 2
	logo.oy        = 0
	logo.angle     = 0
	logo.scale     = 0.1

	-- load the options
	options        = {}
	options.text   = {}
	options.button = love.graphics.newImage("sprites/button.png")
	options.w      = options.button:getWidth()
	options.h      = options.button:getHeight()
	options.x      = logo.x
	options.y      = logo.y + logo.h
	options.y2     = options.y + options.h
	options.y3     = options.y2 + options.h
	options.ox     = options.w / 2
	options.oy     = 0
	options.angle  = 0
	options.scale  = 1

	-- Load language
	if settings.language == "Portuguese" then
		options.text = settings.Portuguese.mainmenu
	elseif settings.language == "English" then
		options.text = settings.English.mainmenu
	else
		options.text = settings.Portuguese.mainmenu
	end

	-- Text objects creation
	Play    = love.graphics.newText(ecranbig, options.text[1])
	Options = love.graphics.newText(ecranbig, options.text[2])
	Quit    = love.graphics.newText(ecranbig, options.text[3])
end

function mainmenu:update(dt)
	if logo.scale < 1 then
		logo.scale = logo.scale + dt / 8
	elseif logo.scale > 1 then
		logo.scale = 1
	end
end

function mainmenu:draw()
	-- Starts the scalling
	push:apply("start")

	-- Palco logo
	love.graphics.draw(logo.palco, Width - logo.palco:getWidth(), Height - logo.palco:getHeight(), 0, logo.palcosize, logo.palcosize)

	-- Sets the random color
	love.graphics.setColor(r, g, b)

	--Draw logo and menu
	love.graphics.draw(logo.image, logo.x, logo.y, logo.angle, logo.scale, logo.scale, logo.ox, logo.oy)
	if logo.scale == 1 then

		-- Draw buttons
		love.graphics.draw(options.button, options.x, options.y, options.angle, options.scale, options.scale, options.ox, options.oy)
		love.graphics.draw(options.button, options.x, options.y2, options.angle, options.scale, options.scale, options.ox, options.oy)
		love.graphics.draw(options.button, options.x, options.y3, options.angle, options.scale, options.scale, options.ox, options.oy)

		-- Draw text
		-- love.graphics.setColor(255, 255, 255)
		love.graphics.draw(Play, options.x, options.y + options.h / 2, options.angle, options.scale, options.scale, Play:getWidth() / 2, Play:getHeight() / 2)
		love.graphics.draw(Options, options.x, options.y2 + options.h / 2, options.angle, options.scale, options.scale, Options:getWidth() / 2, Options:getHeight() / 2)
		love.graphics.draw(Quit, options.x, options.y3 + options.h / 2, options.angle, options.scale, options.scale, Quit:getWidth() / 2, Quit:getHeight() / 2)
	end

	-- Ends the scalling
	push:apply("end")
end

function mainmenu:touchpressed(id, x, y, pressure)

end

function mainmenu:touchreleased(id, x, y, dx, dy, pressure)
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	-- If the touch don't move much before released
	if dx < 20 and dy < 20 and logo.scale == 1 then
		-- If release after touching the Play game Button
		if PressedButton(x, y, options.x, options.y, options.w, options.h) then
			Gamestate.switch(game)
		-- If release after touching the menu button
	elseif PressedButton(x, y, options.x, options.y2, options.w, options.h) then
			Gamestate.switch(optionsmenu)
		-- If release after touching the quint button
	elseif PressedButton(x, y, options.x, options.y3, options.w, options.h) then
			love.event.quit()
		end
	end
	logo.scale = 1
end

function mainmenu:keyreleased(key, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif key == "return" then
		Gamestate.switch(optionsmenu)
	end
end

-- function love.mousereleased( x, y, button, istouch )
-- 	if button == 1 and logo.scale == 1 then
-- 		-- If release after touching the Play game Button
-- 		if PressedButton(x, y, options.x, options.y, options.w, options.h) then
-- 			Gamestate.switch(game)
-- 		-- If release after touching the menu button
-- 		elseif PressedButton(x, y, options.x, options.y2, options.w, options.h) then
-- 			Gamestate.switch(optionsmenu)
-- 		-- If release after touching the quint button
-- 		elseif PressedButton(x, y, options.x, options.y3, options.w, options.h) then
-- 			love.event.quit()
-- 		end
-- 	end
-- end
