mainmenu    = {}

function mainmenu:enter()
	-- Set random colors
	push:setBorderColor{love.graphics.getBackgroundColor()}
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10))

	-- load the logo
	logo = {}
	logo.image   = love.graphics.newImage("sprites/logo.png")
	logo.w       = logo.image:getWidth()
	logo.h       = logo.image:getHeight()
	logo.x       = Width / 2
	logo.y       = 0.01 * Height
	logo.ox      = logo.w / 2
	logo.oy      = 0
	logo.angle   = 0
	logo.scale = 0.1

	-- load the options
	options = {}
	options.image   = love.graphics.newImage("sprites/mainmenuoptions.png")
	options.w       = options.image:getWidth()
	options.h       = options.image:getHeight()
	options.x       = logo.x
	options.ox      = options.w / 2
	options.y       = logo.h
	options.oy      = 0
	options.angle   = 0
	options.scale   = 1
end

function mainmenu:update(dt)
	love.graphics.setColor(r, g, b)
	if logo.scale < 0.6 then
		logo.scale = logo.scale + dt / 8
	elseif logo.scale > 0.6 then
		logo.scale = 0.6
	end
end

function mainmenu:draw()
	-- Starts the scalling
	push:apply("start")
	--Draw logo and menu
	love.graphics.draw(logo.image, logo.x, logo.y, logo.angle, logo.scale, logo.scale, logo.ox, logo.oy)
	if logo.scale == 0.6 then
		love.graphics.draw(options.image, options.x, options.y, options.angle, options.scale, options.scale, options.ox, options.oy)
	end
	-- Ends the scalling
	push:apply("end")
end

function mainmenu:touchpressed(id, x, y, pressure)
	logo.scale = 0.6
end

function mainmenu:touchreleased( id, x, y, dx, dy, pressure )
	-- If the touch don't move much before released
	if dx < 20 and dy < 20 then
		-- If release after touching the Play game Button
		if y >= options.y + 46 and y <= options.y + 116 and x > options.x - options.w / 2 and x < options.x + options.w / 2 then
			Gamestate.switch(game)
		-- If release after touching the menu button
		elseif y >= options.y + 141 and y <= options.y + 211 and x > options.x - options.w / 2 and x < options.x + options.w / 2 then
			Gamestate.switch(optionsmenu)
		-- If release after touching the quint button
		elseif y >= options.y + 236 and y <= options.y + 306 and x > options.x - options.w / 2 and x < options.x + options.w / 2 then
			love.event.quit()
		end
	end
end

function mainmenu:keyreleased(key, isrepeat)
	if logo.scale == 0.6 then
		Gamestate.switch(game)
	elseif key == "return" then
		logo.scale = 0.6
	elseif key == "escape" then
		love.event.quit()
	end
end
