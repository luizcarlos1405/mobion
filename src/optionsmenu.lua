local Optionsmenu = {}

local options = {}


function Optionsmenu:enter()

	-- Set random colors
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10), 100)

	-- Load language
	options.text = Settings.text.Optionsmenu

	-- Load title
	title       = {}
	title.text  = love.graphics.newText(ecranbigger, options.text.Title)
	title.x     = Width / 2
	title.y     = title.text:getHeight()
	title.ox    = title.text:getWidth() / 2
	title.oy    = 0
	title.angle = 0
	title.scale = 1

	-- Load the options
	options.button = love.graphics.newImage("assets/sprites/button.png")
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


	-- Create text objects
	Language       = love.graphics.newText(ecranbig, options.text.Language)
	Control        = love.graphics.newText(ecranbig, options.text.Controls)
	Save           = love.graphics.newText(ecranbig, options.text.Save)
	Cancel         = love.graphics.newText(ecranbig, options.text.Cancel)
	-- EffectsVolume = love.graphics.newText(ecranbig, Settings.volume.effects)
	-- Language   = love.graphics.newText(ecranbig, Settings.volume.music)

end

function Optionsmenu:draw()
	-- Starts the scalling
	push:apply("start")

	-- Sets the random color
	love.graphics.setColor(r, g, b)

	-- Draw Buttons
	love.graphics.draw(options.button, options.x2, options.y, options.angle, options.scale, options.scale, options.ox, options.oy)
	love.graphics.draw(options.button, options.x2, options.y2, options.angle, options.scale, options.scale, options.ox, options.oy)

	-- Draw text objects
	love.graphics.setFont(ecranbig)
	love.graphics.draw(title.text, title.x, title.y, title.angle, title.scale, title.scale, title.text:getWidth() / 2, title.text:getHeight() / 2)
	love.graphics.draw(Language, options.x2, options.y + options.h / 2, options.angle, options.scale, options.scale, Language:getWidth() / 2, Language:getHeight() / 2)
	love.graphics.print(Settings.language, options.x3 - 400, options.y + 70)
	love.graphics.draw(Control, options.x2, options.y2 + options.h / 2, options.angle, options.scale, options.scale, Control:getWidth() / 2, Control:getHeight() / 2)
	love.graphics.print(Settings.controls, options.x3 - 400, options.y2 + 70)
	love.graphics.draw(Save, options.x2, options.y3 + options.h / 2, options.angle, options.scale, options.scale, Save:getWidth() / 2, Save:getHeight() / 2)
	love.graphics.draw(Cancel, options.x3, options.y3 + options.h / 2, options.angle, options.scale, options.scale, Cancel:getWidth() / 2, Cancel:getHeight() / 2)

	-- Ends the scalling
	push:apply("end")
end

function Optionsmenu:leave()
	Language       = nil
	Control        = nil
	Save           = nil
	Cancel         = nil
end

function Optionsmenu:touchreleased(id, x, y, dx, dy, pressure)
	-- Correct touch position considering the screen scaling
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y

	if PressedButton(x, y, options.x2, options.y2, options.w, options.h) then
		if Settings.controls == "A" then
			Settings.controls = "B" -- switch to control rotation with right buttons

		elseif Settings.controls == "B" then
			Settings.controls = "A" -- switch to control rotation with the left pad

		end
	elseif PressedButton(x, y, options.x2, options.y, options.w, options.h) then
		if Settings.language == "Português" then
			Settings.language = "English"
			Settings.text = English
			options.text = Settings.text.Optionsmenu
			-- Re-create text objects
			Language       = love.graphics.newText(ecranbig, options.text.Language)
			Save           = love.graphics.newText(ecranbig, options.text.Save)
			Cancel         = love.graphics.newText(ecranbig, options.text.Cancel)
		elseif Settings.language == "English" then
			Settings.language = "Português"
			Settings.text     = Portuguese
			options.text      = Settings.text.Optionsmenu
			-- Re-create text objects
			Language       = love.graphics.newText(ecranbig, options.text.Language)
			Save           = love.graphics.newText(ecranbig, options.text.Save)
			Cancel         = love.graphics.newText(ecranbig, options.text.Cancel)
		end
	elseif PressedButton(x, y, options.x2, options.y3, options.w, options.h) then
		SaveSettings()
		Gamestate.pop(Optionsmenu)
	elseif PressedButton(x, y, options.x3, options.y3, options.w, options.h) then
		LoadSettings()
		Gamestate.pop(Optionsmenu)
	end
end

function Optionsmenu:keyreleased(key, isrepeat)
	if key == "escape" then
		Gamestate.pop(Optionsmenu)
	end
end

return Optionsmenu
