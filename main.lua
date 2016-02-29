require("src/players")
require("src/controls")
require("src/enemies")
require("src/colisions")
require("src/particles")
Gamestate = require "src/humplib/gamestate"

local menu = {}
local game = {}

function love.load()
	love.physics.setMeter(64)
	--audio load
	love.audio.setVolume(1)
	morri     = love.audio.newSource("sounds/morri.mp3", "static")
	backsound = love.audio.newSource("sounds/back.mp3", "stream")
	shot      = love.audio.newSource("sounds/sneon.mp3", "static")
	-- Font load
	ecran = love.graphics.newFont("fonts/ecran-monochrome.ttf", 12)
	ecranbig = love.graphics.newFont("fonts/ecran-monochrome.ttf", 26)
	love.graphics.setFont(ecran)
	--World loading and callbacks
	World = love.physics.newWorld(0, 0, true)
	World:setCallbacks(beginContact, endContact, preSolve, postSolve)
	--Getting Width and creating a chainshape that won't allow to get out of the screen
	Width          = love.graphics.getWidth()
	Height         = love.graphics.getHeight()
	Border         = {}
	Border.body    = love.physics.newBody(World, 0, 0, "static")
	Border.shape   = love.physics.newChainShape(true, 0, 0, Width, 0, Width, Height, 0, Height)
	Border.fixture = love.physics.newFixture(Border.body, Border.shape)
	Border.fixture:setUserData("Border")
	Border.ebody   = love.physics.newBody(World, 0, 0, "static")
	Border.eshape  = love.physics.newChainShape(false, 0, 400, Width, 400)
	Border.efixture= love.physics.newFixture(Border.ebody, Border.eshape)
	Border.efixture:setMask(2)
	Border.efixture:setUserData("Enemy Border")

	Player.load(Width, Height)

	Enemies.load()

	love.graphics.setLineWidth(1)

	Controls.load(Width, Height)

	backsound:play()

end

function love.update(dt)
	--psystem:setAreaSpread(uniform, 50,50)

	love.graphics.setBackgroundColor((math.sin(rgb) + 1) * 8, --R
	(math.sin(rgb + 2/3 * 	math.pi) + 1) * 8,                 --G
	(math.sin(rgb + 4/3 * math.pi) + 1) * 8)                   --B

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

	Particles.update(dt)
end

function love.draw()
	Enemies.draw()
	Player.draw()
	Controls.draw(Width, Height, dt)
	Particles.draw()
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
	"\nExisting enemies: "..#Enemies..
	"\nLast behavior: "..Behavior..
	"\n"..text..
	"\nParticles systems: "..#Particles,5, 5)

end

function game:load()

end


function love.keypressed(key, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif key == "appback" and isrepeat then
		love.event.quit()
	end
end

--function love.keyreleased(key)
--	if key == "appback" then
--		love.event.quit()
--	end
--end
