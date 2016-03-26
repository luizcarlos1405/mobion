Game = {}

local SettingsButton = {}
local SoundButton    = {}
local PlayAgain      = {}
local music          = true

function Game:enter()
	points = 0

	-- audio load
	backsound = love.audio.newSource("assets/sounds/back.mp3", "stream")
	shot      = love.audio.newSource("assets/sounds/sneon.mp3", "static")

	-- World loading and callbacks
	love.physics.setMeter(64)
	World = love.physics.newWorld(0, 0, true)
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

	Player.load()
	Virus.load()
	Controls.load()
	Map.load()

	if Settings.MusicVolume ~= nil then
		love.audio.setVolume(Settings.MusicVolume)
	else
		love.audio.setVolume(1)
	end
	backsound:play()
end

function Game:resume()
	if Settings.controls == "B" then
		-- Reference buttons for spinning
		spin.image   = love.graphics.newImage("assets/sprites/spin.png")
		spin.w       = spin.image:getWidth()
		spin.h       = spin.image:getHeight()
		spin.x       = Width - spin.w / 2 - 80
		spin.y       = Height - spin.h - 30
		spin.ox      = spin.w / 2
		spin.oy      = 0
		spin.angle   = 0
		spin.scale   = 1

		fire.w      = fire.image:getWidth()
		fire.h      = fire.image:getHeight()
		fire.x      = spin.x - fire.w / 2
		fire.y      = spin.y - fire.h - 15
		fire.ox     = fire.w / 2
		fire.oy     = 0
		fire.angle  = 0
		fire.scale  = 1

	elseif Settings.controls == "A" then
		fire.w      = fire.image:getWidth()
		fire.h      = fire.image:getHeight()
		fire.x      = Width - fire.w - 80
		fire.y      = Height - fire.h - 80
		fire.ox     = fire.w / 2
		fire.oy     = 0
		fire.angle  = 0
		fire.scale  = 1
	end
end

function Game:update(dt)

	World:update(dt)
	Map.update(dt)
	Virus.update(dt)
	if Player.life > 0 then
		Player.update(dt)
		Controls.update(dt)
	end
	if love.keyboard.isDown("space") then
		Player.fire()
	end
	if Player.life > 0 then
		x, y = Player.body:getLinearVelocity()
	end
	fps = love.timer.getFPS()

	Particles.update(dt)

	-- cam:lookAt(Player.body:getX(), Player.body:getY())
end

function Game:draw()
	-- Starts the scalling
	push:apply("start")
	-- Set camera
	camera:set()

	-- The draw functions that should run in the gama gamestate
	Map.draw()
	Virus.draw()
	Player.draw()
	if morritimer > 0 then
		love.graphics.setFont(ecranbig)
		love.graphics.print("Morri!",  morrix - 45 , morriy - 15)
	end
	Particles.draw()
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
	--
	-- love.graphics.print("FPS: "..fps..
	-- "\nX: "..Player.body:getX()..
	-- "\ny: "..Player.body:getY()..
	-- "\nAngle: "..Player.body:getAngle()..
	-- "\nX velocity: "..x..
	-- "\nY velocity: "..y..
	-- "\nExisting bullets: "..#Player.bullets..
	-- "\nScreen Width: "..Width..
	-- "\nScreen Height: "..Height..
	-- "\nScreen Dangle: "..move.dangle..
	-- "\nExisting viruses: "..#viruses..
	-- "\nLast behavior: "..Behavior..
	-- "\n"..text..
	-- "\nParticles systems: "..#Particles..
	-- "\nSave directory: "..savedir,5, 5)

	--Ends the scalling
	push:apply("end")
end

function Game:leave()
	-- Destroy any remanescent enemie or bullet
	Player.bullets = nil
	points         = nil
	viruses        = nil
	backsound      = nil
	shot           = nil
	World          = nil
	Points         = nil
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
		Gamestate.switch(Game)
	end
end

function Game:touchpressed(id, x, y, dx, dy, pressure)

end

-- Virus = {}
