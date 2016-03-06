optionsmenu = {}

function optionsmenu:enter()

	-- Set random colors
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10))

	-- Load language
	if settings.language == "Portuguese" then
		options.text = settings.Portuguese.optionsmenu
	elseif settings.language == "English" then
		options.text = settings.English.optionsmenu
	else
		options.text = settings.English.optionsmenu
	end

	-- Load title
	title = {}
	title.text  = love.graphics.newText(ecranbigger, options.text[1])
	title.x     = Width / 2
	title.y     = 40
	title.ox    = title.text:getWidth() / 2
	title.oy    = 0
	title.angle = 0
	title.scale = 1

	-- Load the options
	options = {}
	options.text   = {}
	options.button = love.graphics.newImage("sprites/button.png")
	options.w      = options.button:getWidth()
	options.h      = options.button:getHeight()
	options.x      = title.x
	options.y      = title.y + 200
	options.y2     = options.y + options.h
	options.y3     = options.y2 + options.h
	options.ox     = options.w / 2
	options.oy     = 0
	options.angle  = 0
	options.scale  = 1

	-- Create text objects
	RControl    = love.graphics.newText(ecranbig, options.text[2])
	MusicVolume = love.graphics.newText(ecranbig, options.text[3])
	FXVolume    = love.graphics.newText(ecranbig, options.text[4])
	Save        = love.graphics.newText(ecranbig, options.text[5])
	Cancel      = love.graphics.newText(ecranbig, options.text[6])
end

function optionsmenu:draw()
	-- Starts the scalling
	push:apply("start")

	-- Sets the random color
	love.graphics.setColor(r, g, b)

	-- Draw Buttons
	love.graphics.draw(options.buttton, options.x, options.y, options.angle, options.scale, options.scale, options.w / 2, 0)
	love.graphics.draw(options.buttton, options.x, options.y2, options.angle, options.scale, options.scale, options.w / 2, 0)
	love.graphics.draw(options.buttton, options.x, options.y3, options.angle, options.scale, options.scale, options.w / 2, 0)

	-- Draw text objects
	love.graphics.draw(Settigs, title.x, title.y, title.angle, title.scale, title.scale, Settings:getWidth() / 2, Settigs:getHeight() / 2)
	love.graphics.draw(RControl, options.x, options.y, options.angle, options.scale, options.scale, Settings:getWidth() / 2, Settigs:getHeight() / 2)

	-- Ends the scalling
	push:apply("end")
end

function optionsmenu:touchreleased()
	Gamestate.switch(mainmenu)
end

function optionsmenu:keyreleased(key, isrepeat)
	if key == "escape" then
		Gamestate.switch(mainmenu)
	end
end
