	Shipmenu = {}

function Shipmenu:enter()

	-- Set random colors
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10), 100)
	-- Ships to choose
	square   = {}
	triangle = {}

	-- Their images
	square.img   = love.graphics.newImage("assets/sprites/squared.png")
	square.x     = Width / 4
	square.y     = Height / 2
	square.ox    = square.img:getWidth() / 2
	square.oy    = square.img:getHeight() / 2

	triangle.img = love.graphics.newImage("assets/sprites/triangle.png")
	triangle.x   = Width - Width / 4
	triangle.y   = Height / 2
	triangle.ox  = triangle.img:getHeight() / 3
	triangle.oy  = triangle.img:getHeight() / 2

	-- load the logo
	logo = {}
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

	angle = 0
end

function Shipmenu:update(dt)
	angle = angle + dt
end

function Shipmenu:draw()
	-- Starts the scalling
	push:apply("start")

	-- Sets the random color
	love.graphics.setColor(r, g, b)

	-- Draw the Ships
	love.graphics.draw(square.img, square.x,square.y, angle, 1, 1, square.ox, square.oy)
	love.graphics.draw(triangle.img, triangle.x, triangle.y, angle, 1, 1, triangle.ox, triangle.oy)

	-- Palco logo
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(logo.palco, Width - logo.palco:getWidth(), Height - logo.palco:getHeight(), 0, logo.palcosize, logo.palcosize)

	-- Ends the scalling
	push:apply("end")
end

function Shipmenu:leave()
	-- Erase stuff
	r = nil
	g = nil
	b = nil
	square = nil
	triangle = nil
	angle = nil
end

function Shipmenu:touchpressed(id, x, y, dx, dy, pressure)
	-- Correct touch value
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y
	-- Play bubble sound when touhing a button
	-- if x < Width / 2 then
	-- 	Player = Square
	-- 	ChangeState(Game)
	-- else
	-- 	Player = Triangle
	-- 	ChangeState(Game)
	-- end
end

function Shipmenu:touchreleased(id, x, y, dx, dy, pressure)
	-- Correct touch position considering the screen scaling
	x = (Width / screenWidth) * x
	y = (Height / screenHeight) * y

	if dx < 20 and dy < 20 then
		if x < Width / 2 then
			Player = require("src/square")
			ChangeState(Game)
		else
			Player = require("src/triangle")
			ChangeState(Game)
		end
	end
end

function Shipmenu:keyreleased(key, isrepeat)
	if key == "escape" then
		Gamestate.switch(Mainmenu)
	elseif key == "s" then
		Player = require("src/square")
		ChangeState(Game)
	elseif key == "t" then
		Player = require("src/triangle")
		ChangeState(Game)
	end
end
