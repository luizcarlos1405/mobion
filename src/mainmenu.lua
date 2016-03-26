Mainmenu = {}

local options  = {}
local logo     = {}

function Mainmenu:enter()
	-- Stop all audios
	love.audio.stop()


	-- Set random colors
	push:setBorderColor{love.graphics.getBackgroundColor()}
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10))

	-- load the logo
	logo.palco     = love.graphics.newImage("assets/sprites/palcodev.png")
	logo.palcosize = 1
	logo.image     = love.graphics.newImage("assets/sprites/logo.png")
	logo.w         = logo.image:getWidth()
	logo.h         = logo.image:getHeight()
	logo.x         = Width / 2
	logo.y         = 0.01 * Height
	logo.ox        = logo.w / 2
	logo.oy        = 0
	logo.angle     = 0
	logo.scale     = 0.1

	-- load the options
	options.text   = {}
	options.button = love.graphics.newImage("assets/sprites/button.png")
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
	options.text = Settings.text.Mainmenu

	-- Text objects creation
	if options.text.Play == nil or options.text.Options == nil or options.text.Exit == nil then
		LoadSettings()
	else
		Play    = love.graphics.newText(ecranbig, options.text.Play)
		Options = love.graphics.newText(ecranbig, options.text.Options)
		Exit    = love.graphics.newText(ecranbig, options.text.Exit)
	end
end

function Mainmenu:resume()
	if options.text ~= Settings.text.Mainmenu then
		options.text = Settings.text.Mainmenu
		-- Re-create text objects
		Play    = love.graphics.newText(ecranbig, options.text.Play)
		Options = love.graphics.newText(ecranbig, options.text.Options)
		Exit    = love.graphics.newText(ecranbig, options.text.Exit)
	end
end

function Mainmenu:update(dt)

	if logo.scale < 1 then
		logo.scale = logo.scale + dt / 3
	elseif logo.scale > 1 then
		logo.scale = 1
	end
end

function Mainmenu:draw()
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
		love.graphics.draw(Play, options.x, options.y + options.h / 2, options.angle, options.scale, options.scale, Play:getWidth() / 2, Play:getHeight() / 2)
		love.graphics.draw(Options, options.x, options.y2 + options.h / 2, options.angle, options.scale, options.scale, Options:getWidth() / 2, Options:getHeight() / 2)
		love.graphics.draw(Exit, options.x, options.y3 + options.h / 2, options.angle, options.scale, options.scale, Exit:getWidth() / 2, Exit:getHeight() / 2)
	end
	love.graphics.setFont(ecranbig)
	love.graphics.print(LoadedFrom, 15, 15)

	-- Ends the scalling
	push:apply("end")
end

function Mainmenu:leave()
	-- Erase stuff
	r       = nil
	g       = nil
	b       = nil
	Play    = nil
	Options = nil
	Exit    = nil
end

function Mainmenu:touchpressed(id, x, y, dx, dy, pressure)
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	-- Play bubble sound when touching a button
	if PressedButton(x, y, options.x, options.y, options.w, options.h) then
		bubble[love.math.random(1, 3)]:play()
	-- If release after touching the menu button
	elseif PressedButton(x, y, options.x, options.y2, options.w, options.h) then
		bubble[love.math.random(1, 3)]:play()
	-- If release after touching the quit button
	elseif PressedButton(x, y, options.x, options.y3, options.w, options.h) then
		bubble[love.math.random(1, 3)]:play()
	end
end

function Mainmenu:touchreleased(id, x, y, dx, dy, pressure)
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	-- If the touch don't move much before released
	if dx < 20 and dy < 20 and logo.scale == 1 then
		-- If release after touching the Play Button
		if PressedButton(x, y, options.x, options.y, options.w, options.h) then
			ChangeState(Game)
		-- If release after touching the menu button
	elseif PressedButton(x, y, options.x, options.y2, options.w, options.h) then
			Gamestate.push(Optionsmenu)
		-- If release after touching the quint button
	elseif PressedButton(x, y, options.x, options.y3, options.w, options.h) then
			love.event.quit()
		end
	end
	logo.scale = 1
end

function Mainmenu:keyreleased(key, isrepeat)
	bubble[love.math.random(1, 3)]:play()
	if key == "escape" then
		love.event.quit()
	elseif key == "return" then
		ChangeState(Game)
	elseif key == "m" then
		Gamestate.push(Optionsmenu)
	elseif key == "p" then
		Settings.language.Current = "Português"
		Settings.text     = Settings.language.Portuguese
	elseif key == "e" then
		Settings.language.Current = "English"
		Settings.text = Settings.language.English
	end
end
