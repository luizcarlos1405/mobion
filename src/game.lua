Game = {}

local SettingsButton = {}
local SoundButton    = {}
local PlayAgain      = {}
local music          = true

function Game:enter()
	points = 0

	-- audio load
	backsound = love.audio.newSource("assets/sounds/Gunnar Olsen - Dub Zap.ogg", "stream")
	shot      = love.audio.newSource("assets/sounds/sneon.mp3", "static")
	ready     = love.audio.newSource("assets/sounds/readygo.ogg", "static")

	-- World loading and callbacks
	World = love.physics.newWorld(0, 0, true)
	love.physics.setMeter(64)
	World:setCallbacks(beginContact, endContact, preSolve, postSolve)


	-- Settings button
	SettingsButton.image = love.graphics.newImage("assets/sprites/engine.png")
	SettingsButton.w     = SettingsButton.image:getWidth()
	SettingsButton.h     = SettingsButton.image:getHeight()
	SettingsButton.ox    = SettingsButton.w / 2
	SettingsButton.oy    = 0
	SettingsButton.x     = Width - SettingsButton.ox - 30
	SettingsButton.y     = 30
	SettingsButton.r     = 0
	SettingsButton.scale = 1

	-- Sound button
	SoundButton.image   = love.graphics.newImage("assets/sprites/sound.png")
	SoundButton.w       = SoundButton.image:getWidth()
	SoundButton.h       = SoundButton.image:getHeight()
	SoundButton.ox      = SoundButton.w / 2
	SoundButton.oy      = 0
	SoundButton.x       = SettingsButton.x - SoundButton.w
	SoundButton.y       = SettingsButton.y
	SoundButton.r       = 0
	SoundButton.scale   = 1

	-- Play Again button
	PlayAgain.image     = love.graphics.newImage("assets/sprites/button.png")
	PlayAgain.w         = PlayAgain.image:getWidth()
	PlayAgain.h         = PlayAgain.image:getHeight()
	PlayAgain.ox        = PlayAgain.w / 2
	PlayAgain.oy        = 0
	PlayAgain.x         = Width / 2
	PlayAgain.y         = Height / 2 + 200
	PlayAgain.r         = 0
	PlayAgain.scale     = 1

	-- Color changing
	Game.rgb            = 0
	Game.ColorChangeVel = 0.1

	Map.load()
	Player.load()
	Virus.load()
	Controls.load()

	if Settings.MusicVolume ~= nil then
		love.audio.setVolume(Settings.MusicVolume)
	else
		love.audio.setVolume(0.2)
	end
	backsound:play()
	ready:play()
end

function Game:resume()
	Controls.load()
end

function Game:update(dt)

	World:update(dt)
	Map.update(dt)
	Virus.update(dt)
	if Player.life > 0 then
		Controls.update(dt)
	end
	Player.update(dt)
	if love.keyboard.isDown("space") then
		Player.fire()
	end
	if Player.life > 0 then
		x, y = Player.body:getLinearVelocity()
	end
	fps = love.timer.getFPS()

	Particles.update(dt)

	-- Color changing
	Game.rgb = Game.rgb + Game.ColorChangeVel * dt
	-- For changing colors with the time
	if Game.rgb > 2 * math.pi then
		Game.rgb = 0
	end
end

function Game:draw()
	-- Starts the scalling
	push:apply("start")
	-- Set camera
	camera:set()

	-- Change color over the time
   love.graphics.setColor((math.sin(Game.rgb + 4/3 * math.pi) + 1) * 127.5, --R
   (math.sin(Game.rgb) + 1) * 127.5,        --G
   (math.sin(Game.rgb + 2/3 * math.pi) + 1) * 127.5)        --B

   -- The draw functions that should run in the game gamestate
	Map.draw()
	Particles.draw()
	Virus.draw()

	-- Change color over the time
   love.graphics.setColor((math.sin(Game.rgb) + 1) * 127.5, --R
   (math.sin(Game.rgb + 2/3 * math.pi) + 1) * 127.5,        --G
   (math.sin(Game.rgb + 4/3 * math.pi) + 1) * 127.5)        --B

   -- The draw Player if it's alive
	Player.draw()
	if morritimer > 0 then
		love.graphics.setFont(ecranbig)
		love.graphics.print("Morri!",  morrix - 45 , morriy - 15)
	end

	-- Unset Camera
	camera:unset()

	if Player.life <= 0 then
		love.graphics.draw(PlayAgain.image, PlayAgain.x, PlayAgain.y, PlayAgain.r, PlayAgain.scale, PlayAgain.scale, PlayAgain.ox, PlayAgain.oy)
	else
		-- Draw control off the camera movement, cus it wont move dah!
		Controls.draw(dt)
	end

	-- Draw Settings button and sound button
	love.graphics.draw(SettingsButton.image, SettingsButton.x, SettingsButton.y, SettingsButton.r, SettingsButton.scale, SettingsButton.scale, SettingsButton.ox, SettingsButton.oy)
	love.graphics.draw(SoundButton.image, SoundButton.x, SoundButton.y, SoundButton.r, SoundButton.scale, SoundButton.scale, SoundButton.ox, SoundButton.oy)
	love.graphics.setFont(ecranbig)
	love.graphics.print(string.format("%i", points), 15, 30)

	-- Set the font for the control text

	-- love.graphics.setFont(ecran)
	-- if Player.life > 0 and cosa ~= nil and sina ~= nil then
	-- 	love.graphics.print("FPS: "..fps..
	-- 	"\n"..text..
	-- 	"\nmove.dangle: "..move.dangle..
	-- 	"\ncosa: "..cosa..
	-- 	"\nsina: "..sina,5, 5)
	-- end
	--Ends the scalling
	push:apply("end")
end

function Game:leave()
	-- Destroy any remanescent enemie or bullet
	Player.bullets = nil
	points         = nil
	Viruses        = nil
	backsound      = nil
	shot           = nil
	World          = nil
	Points         = nil
	love.audio.stop()
	SaveSettings()
end

function Game:keyreleased(key, scancode, isrepeat)

	if key == "escape" then
		Gamestate.switch(Mainmenu)
	elseif key == "return" then
		Gamestate.push(Optionsmenu)
	elseif key == "right" then
		Player.body:setX(Player.body:getX() + 50)
	elseif key == 'p' then
		if music then
			backsound:pause()
			music = false
		else
			backsound:resume()
			music = true
		end
	end

	bubble[love.math.random(1, 3)]:play()
end

function Game:touchpressed(id, x, y, dx, dy, pressure)
	-- Isn't working and I don't know why T.T
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	-- Play bubble sound when touching a button
	if PressedButton(x, y, SettingsButton.x, SettingsButton.y, SettingsButton.w, SettingsButton.h)  then
		bubble[love.math.random(1, 3)]:play()
	elseif PressedButton(x, y, SoundButton.x, SoundButton.y, SoundButton.w, SoundButton.h)  then
		bubble[love.math.random(1, 3)]:play()
	end
end

function Game:touchreleased(id, x, y, dx, dy, pressure)
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y

	if dx < 20 and dy < 20 then
		-- If touches on Settings button
		if PressedButton(x, y, SettingsButton.x, SettingsButton.y, SettingsButton.w, SettingsButton.h)  then
			Gamestate.push(Optionsmenu)
		-- if touches sound button
		elseif PressedButton(x, y, SoundButton.x, SoundButton.y, SoundButton.w, SoundButton.h)  then
			if music then
				backsound:pause()
				music = false
			else
				backsound:resume()
				music = true
			end
		end
	end
	if Player.life <= 0 and PressedButton(x, y, PlayAgain.x, PlayAgain.y, PlayAgain.w, PlayAgain.h) then
		Player.fixture:setCategory(3)
		ChangeState(Game)
	end
end

function Game:touchpressed(id, x, y, dx, dy, pressure)

end
