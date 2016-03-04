optionsmenu = {}

function optionsmenu:enter()
	r = love.math.random(127.5, 255)
	g = love.math.random(127.5, 255)
	b = love.math.random(127.5, 255)
	love.graphics.setBackgroundColor(love.math.random(2,10), love.math.random(2,10), love.math.random(2,10))

	optionsmenu.image = love.graphics.newImage("sprites/optionsmenu.png")
	optionsmenu.w       = optionsmenu.image:getWidth()
	optionsmenu.h       = optionsmenu.image:getHeight()
	optionsmenu.x       = Width / 2
	optionsmenu.y       = 0.01 * Height
	optionsmenu.ox      = optionsmenu.w / 2
	optionsmenu.oy      = 0
	optionsmenu.angle   = 0
	optionsmenu.scale   = 1
end

function optionsmenu:draw()
	-- Starts the scalling
	push:apply("start")

	love.graphics.setColor(r, g, b)
	love.graphics.draw(optionsmenu.image, optionsmenu.x, optionsmenu.y, optionsmenu.angle, optionsmenu.scale, optionsmenu.scale, optionsmenu.ox, optionsmenu.oy)

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
