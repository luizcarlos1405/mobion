require("src/players")
require("src/controls")
require("src/enemies")
require("src/colisions")

function love.load()
	love.audio.setVolume(1)
	love.physics.setMeter(64)
	morri     = love.audio.newSource("sounds/morri.mp3", "static")
	backsound = love.audio.newSource("sounds/back.mp3", "stream")
	shot      = love.audio.newSource("sounds/sneon.mp3", "static")

	ecran = love.graphics.newFont("fonts/ecran-monochrome.ttf", 12)
	love.graphics.setFont(ecran)

	World = love.physics.newWorld(0, 0, true)
	World:setCallbacks(beginContact, endContact, preSolve, postSolve)

	Width          = love.graphics.getWidth()
	Height         = love.graphics.getHeight()
	Border         = {}
	Border.body    = love.physics.newBody(World, 0, 0, "static")
	Border.shape   = love.physics.newChainShape(true, 0, 0, Width, 0, Width, Height, 0, Height)
	Border.fixture = love.physics.newFixture(Border.body, Border.shape)
	Border.fixture:setUserData("Border")

	Player.load(Width, Height)

	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setLineWidth(1)

	Controls.load(Width, Height)

	backsound:play()
end

function love.update(dt)
	World:update(dt)
	Controls.update(Width, Height, dt)
	Player.update(dt)
	Enemies.spawn(Width, Height)
	Enemies.update(dt)

	if love.keyboard.isDown("space") then
		Player.fire()
	end

	x, y = Player.body:getLinearVelocity()
	fps = love.timer.getFPS()
end

function love.draw()
	Enemies.draw()
	Player.draw()
	Controls.draw(Width, Height, dt)

	--[[
	love.graphics.print("FPS: "..fps..
	"\nX: "..Player.body:getX()..
	"\ny: "..Player.body:getY()..
	"\nAngle: "..Player.body:getAngle()..
	"\nX velocity: "..x..
	"\nY velocity: "..y..
	"\nExisting bullets: "..#Player.bullets..
	"\nScreen Width: "..Width..
	"\nScreen Height: "..Height..
	"\nExisting enemies: "..#Enemies..
	"\nLast behavior: "..Behavior..
	"\n"..text, 5, 5)
	love.graphics.print((math.sin(rgb) + 1) * 127.5, 400, 400)
	]]
end


function love.keypressed(key, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif key == "appback" and isrepate then
		love.event.quit()
	end
end

--function love.keyreleased(key)
--	if key == "appback" then
--		love.event.quit()
--	end
--end
