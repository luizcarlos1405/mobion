optionsmenu = {}

function optionsmenu:enter()

	-- Set random colors
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10))

	-- Load title
	title = {}
	title.text  = love.graphics.newText(ecranbigger, options.text[1])
	title.x     = Width / 2
	title.y     = title.text:getHeight()
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
	options.ox     = options.w / 2
	options.oy     = 0
	options.x      = title.x
	options.x2     = title.x - options.ox - 300
	options.x3     = title.x + options.ox
	options.y      = title.y + 200
	options.y2     = options.y + options.h
	options.y3     = options.y2 + options.h
	options.angle  = 0
	options.scale  = 1

	-- Load language
	if settings.language == "Portuguese" then
		options.text = settings.Portuguese.optionsmenu
	elseif settings.language == "English" then
		options.text = settings.English.optionsmenu
	else
		options.text = settings.Portuguese.optionsmenu
	end

	-- Choose options text
	ABButton       = {}
	ABButton.image = love.graphics.newImage("sprites/abbutton.png")
	ABButton.text  = love.graphics.newText(ecranbigger, "A")
	ABButton.w     = ABButton.image:getWidth()
	ABButton.h     = ABButton.image:getHeight()
	ABButton.ox    = ABButton.w / 2
	ABButton.oy    = 0
	ABButton.x     = options.x3 + options.w / 2 + 80
	ABButton.y     = options.y + 18
	ABButton.angle = 0
	ABButton.scale = 1

	-- Create text objects
	Language    = love.graphics.newText(ecranbig, options.text[2])
	RControl    = love.graphics.newText(ecranbig, options.text[3])
	MusicVolume = love.graphics.newText(ecranbig, options.text[4])
	FXVolume    = love.graphics.newText(ecranbig, options.text[5])
	Save        = love.graphics.newText(ecranbigger, options.text[6])
	Cancel      = love.graphics.newText(ecranbigger, options.text[7])

end

function optionsmenu:draw()
	-- Starts the scalling
	push:apply("start")

	-- Sets the random color
	love.graphics.setColor(r, g, b)

	-- Draw Buttons
	love.graphics.draw(options.button, options.x2, options.y, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(options.button, options.x3, options.y, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(options.button, options.x2, options.y2, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(options.button, options.x3, options.y2, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(options.button, options.x2, options.y3, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(options.button, options.x3, options.y3, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(ABButton.image, ABButton.x, ABButton.y, ABButton.angle, ABButton.scale, ABButton.scale, ABButton.ox, ABButton.oy)

	-- Draw text objects
	love.graphics.draw(title.text, title.x, title.y, title.angle, title.scale, title.scale, title.text:getWidth() / 2, title.text:getHeight() / 2)
	love.graphics.draw(Language, options.x2, options.y + options.h / 2, options.angle, options.scale, options.scale, Language:getWidth() / 2, Language:getHeight() / 2)
	love.graphics.draw(RControl, options.x3, options.y + options.h / 2, options.angle, 0.5, 0.5, RControl:getWidth() / 2, RControl:getHeight() / 2)
	love.graphics.draw(MusicVolume, options.x2, options.y2 + options.h / 2, options.angle, 0.5, 0.5, MusicVolume:getWidth() / 2, MusicVolume:getHeight() / 2)
	love.graphics.draw(FXVolume, options.x3, options.y2 + options.h / 2, options.angle, 0.45, 0.45, FXVolume:getWidth() / 2, FXVolume:getHeight() / 2)
	love.graphics.draw(Save, options.x2, options.y3 + options.h / 2, options.angle, 0.6, 0.6, Save:getWidth() / 2, Save:getHeight() / 2)
	love.graphics.draw(Cancel, options.x3, options.y3 + options.h / 2, options.angle, 0.5, 0.5, Cancel:getWidth() / 2, Cancel:getHeight() / 2)
	love.graphics.draw(ABButton.text, ABButton.x + 7, ABButton.y + ABButton.h / 2, ABButton.angle, 1, 1, ABButton.text:getWidth() / 2, ABButton.text:getHeight() / 2)

	-- Ends the scalling
	push:apply("end")
end

function optionsmenu:touchreleased(id, x, y, dx, dy, pressure)
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	if PressedButton(x, y, options.x3, options.y, options.w, options.h) then
		if RControl == "RotationAtLeft" then
			RControl      = "RotationAtRight"
			ABButton.text = "B"
		elseif RControl == "RotationAtRight" then
			RControl      = "RotationAtLeft"
			ABButton.text = "A"
		end
	elseif PressedButton(x, y, options.x3, options.y, options.w, options.h) then
		if Language == "Portuguese" then
			Language = "English"
		elseif Language == "English" then
			Language = "Portuguese"
		end
	elseif PressedButton(x, y, options.x2, options.y3, options.w, options.h) then
		settings.language = Language
		settings.controls = RControl
		SaveSettings()
	elseif PressedButton(x, y, options.x3, options.y3, options.w, options.h) then
		LoadSettings()
	end
end

function optionsmenu:keyreleased(key, isrepeat)
	if key == "escape" then
		Gamestate.switch(mainmenu)
	end
end
