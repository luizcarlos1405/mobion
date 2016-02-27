require("src/players")
require("src/controls")
require("src/bullets")
require("src/enemies")
require("src/colisions")

function love.load()
	love.audio.setVolume(0.8)
	love.physics.setMeter(64)
	morri     = love.audio.newSource("sounds/morri.mp3", "static")
	backsound = love.audio.newSource("sounds/back.mp3", "stream")
	shot      = love.audio.newSource("sounds/shot.mp3", "static")

	World = love.physics.newWorld(0, 0, true)
	World:setCallbacks(beginContact, endContact, preSolve, postSolve)

	Width          = love.graphics.getWidth()
	Height         = love.graphics.getHeight()
	Border         = {}
	Border.body    = love.physics.newBody(World, 0, 0, "static")
	Border.shape   = love.physics.newChainShape(true, 0, 0, Width, 0, Width, Height, 0, Height)
	Border.fixture = love.physics.newFixture(Border.body, Border.shape)
	Border.fixture:setUserData("Border")

	bullload()
	Player.load(Width, Height)

	love.graphics.setBackgroundColor(0, 10, 20)
	love.graphics.setLineWidth(1)

	Controls.load(Width, Height)

	backsound:play()
end

function love.update(dt)
	World:update(dt)
	if love.keyboard.isDown("space") then
		Player.fire()
		morri:play()
	end

	Controls.update(Width, Height, dt)
	Player.update(dt)
	bullupdate(dt)
	Enemies.spawn(Width, Height)
	Enemies.update(dt)

	x, y = Player.body:getLinearVelocity()
end

function love.draw()
	bulldraw()
	Enemies.draw()
	Player.draw()
	sparkdraw()
	Controls.draw(Width, Height)

	--[[
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("X", 5, 5)
	love.graphics.print(Player.body:getX(), 20, 5)
	love.graphics.print("Y", 5, 35)
	love.graphics.print(Player.body:getY(), 20, 35)
	love.graphics.print("A", 5, 65)
	love.graphics.print(Player.body:getAngle(), 20, 65)
	love.graphics.print("XVel", 190, 5)
	love.graphics.print(x, 220, 5)
	love.graphics.print("YVel", 190, 35)
	love.graphics.print(y, 220, 35)
	love.graphics.print("Bull", 190, 65)
	love.graphics.print(#Player.bullets, 220, 65)
	love.graphics.print("Width", 360, 5)
	love.graphics.print(Width, 420, 5)
	love.graphics.print("Height", 360, 35)
	love.graphics.print(Height, 420, 35)
	love.graphics.print("Enemies", 360, 65)
	love.graphics.print(#Enemies, 420, 65)
	love.graphics.print("Behavior", 500, 5)
	love.graphics.print(Behavior, 560, 5)
	love.graphics.print(text, Width/2 + 50, 0)
	]]
end
