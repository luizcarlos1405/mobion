Gameovermenu = {}
ecranbigger  = love.graphics.newFont("fonts/ecran-monochrome.ttf", 120)
local menu = love.graphics.newText(ecranbigger, "You lose")-- love.graphics.newImage("assets/sprites/gameovermenu.png")

function Gameovermenu:draw()
	-- Starts the scalling
	-- push:apply("start")
	-- camera:setPosition(Player.body:getX(), Player.body:getY())
	love.graphics.draw(menu, camera.x + Width / 2, camera.y + Height / 2, 0, 1, 1, menu:getWidth() / 2, menu:getHeight() / 2)
	-- Ends the scalling
	-- push:apply("end")
end
