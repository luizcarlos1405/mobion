Game = {}

local Optionsmenu = require("src/optionsmenu")
local Mainmenu  = require("src/mainmenu")
local Virus     = require("enemies/virus")
local Map       = require("src/map")
local SButton   = {}
local Sound     = {}
local music     = true

function Game:enter()

	-- audio load
	backsound = love.audio.newSource("assets/sounds/back.mp3", "stream")
	shot      = love.audio.newSource("assets/sounds/sneon.mp3", "static")

	-- World loading and callbacks
	love.physics.setMeter(64)
	World = love.physics.newWorld(0, 0, true)
	World:setCallbacks(beginContact, endContact, preSolve, postSolve)

	-- Settings button
	SButton.image = love.graphics.newImage("assets/sprites/engine.png")
	SButton.w     = SButton.image:getWidth()
	SButton.h     = SButton.image:getHeight()
	SButton.ox    = SButton.w / 2
	SButton.oy    = 0
	SButton.x     = Width - SButton.ox - 30
	SButton.y     = 30
	SButton.r     = 0
	SButton.scale = 1

	-- Sound button
	Sound.image   = love.graphics.newImage("assets/sprites/sound.png")
	Sound.w       = Sound.image:getWidth()
	Sound.h       = Sound.image:getHeight()
	Sound.ox      = Sound.w / 2
	Sound.oy      = 0
	Sound.x       = SButton.x - Sound.w
	Sound.y       = SButton.y
	Sound.r       = 0
	Sound.scale   = 1

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
	Player.update(dt)
	Controls.update(dt)

	if love.keyboard.isDown("space") then
		Player.fire()
	end

	x, y = Player.body:getLinearVelocity()
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

	-- Draw control off the camera movement, cus it wont move dah!
	Controls.draw(dt)

	-- Draw Settings button and sound button
	love.graphics.draw(SButton.image, SButton.x, SButton.y, SButton.r, SButton.scale, SButton.scale, SButton.ox, SButton.oy)
	love.graphics.draw(Sound.image, Sound.x, Sound.y, Sound.r, Sound.scale, Sound.scale, Sound.ox, Sound.oy)

	-- Set the font for the control text
	love.graphics.setFont(ecran)

	love.graphics.print("FPS: "..fps..
	"\nX: "..Player.body:getX()..
	"\ny: "..Player.body:getY()..
	"\nAngle: "..Player.body:getAngle()..
	"\nX velocity: "..x..
	"\nY velocity: "..y..
	"\nExisting bullets: "..#Player.bullets..
	"\nScreen Width: "..Width..
	"\nScreen Height: "..Height..
	"\nScreen Dangle: "..move.dangle..
	"\nExisting viruses: "..#viruses..
	"\nLast behavior: "..Behavior..
	"\n"..text..
	"\nParticles systems: "..#Particles..
	"\nSave directory: "..savedir,5, 5)

	--Ends the scalling
	push:apply("end")
end

function Game:leave()
	-- Destroy any remanescent enemie or bullet
	Player.bullets = {}
	viruses = {}
end

function Game:keyreleased(key, scancode, isrepeat)
	love.keyboard.setKeyRepeat( enable )

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
end

function Game:touchreleased(id, x, y, dx, dy, pressure)
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	-- If clicks on Settings button
 	if PressedButton(x, y, SButton.x, SButton.y, SButton.w, SButton.h) and dx < 100 and dy < 100 then
		Gamestate.push(Optionsmenu)
	elseif PressedButton(x, y, Sound.x, Sound.y, Sound.w, Sound.h) and dx < 100 and dy < 100 then
		if music then
			backsound:pause()
			music = false
		else
			backsound:resume()
			music = true
		end
	end
end

function Game:touchpressed(id, x, y, dx, dy, pressure)

end

-- Virus = {}
