require("src/players")
require("src/controls")

function love.load()
	love.graphics.setBackgroundColor(0, 10, 20)
	love.graphics.setLineWidth(1)
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	player.load(width, height)
	controls.load(width, height)

end

function love.update(dt)


	controls.update(width, height)
	player.update()

end

function love.draw()
	player.draw()
	controls.draw(width, height)

	love.graphics.setColor(255, 255, 255)

	love.graphics.print(touch.x, 5, 0)
	love.graphics.print(touch.y, 5, 30)
	love.graphics.print(linelen, 5, 60)
	love.graphics.print(width, 200, 5)
	love.graphics.print(height, 200, 35)
	--love.graphics.print(, 200, 65)
	--love.graphics.print(player.one.x, 400, 5)
	--love.graphics.print(player.one.y, 400, 35)
	--love.graphics.print(player.one.xspeed, 600, 5)
	--love.graphics.print(player.one.yspeed, 600, 35)
end
