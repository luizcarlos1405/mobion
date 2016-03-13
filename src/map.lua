local Map = {}

function Map.load()
	Map.rgb            = 0
	Map.ColorChangeVel = 0.1
	Map.scale          = 1
	Map.angle          = 0

	Bground = {}
	Bground.image  = love.graphics.newImage("assets/sprites/background.png")
	Bground.w      = Bground.image:getWidth()
	Bground.h      = Bground.image:getHeight()
	Bground.x      = Player.body:getX()
	Bground.y      = Player.body:getY()
	Bground.ox     = Bground.w / 2
	Bground.oy     = Bground.h / 2
	Bground.scale  = Map.scale
	Bground.angle  = Map.angle

	-- Creating a chainshape that won't allow to get out of the screen
	Border         = {}
	Border.image   = love.graphics.newImage("assets/sprites/map.png")
	Border.w       = Border.image:getWidth()
	Border.h       = Border.image:getHeight()
	Border.body    = love.physics.newBody(World, 0, 0, "static")
	Border.shape   = love.physics.newChainShape(true, 0, 0, Border.w, 0, Border.w, Border.h, 0, Border.h)
	Border.fixture = love.physics.newFixture(Border.body, Border.shape)
	Border.fixture:setUserData("Border")

	Player.body:setPosition(Border.w / 2, Border.h / 2)
end

function Map.update(dt)
	Bground.x = Player.body:getX() - Player.body:getX() / 2
	Bground.y = Player.body:getY() - Player.body:getY() / 2

	-- For changing colors with the time
	if Map.rgb > 2 * math.pi then
		Map.rgb = 0
	end
	Map.rgb = Map.rgb + Map.ColorChangeVel * dt

end

function Map.draw()
	-- Change color over the time
	love.graphics.setColor((math.sin(Map.rgb) + 1) * 127.5, --R
	(math.sin(Map.rgb + 2/3 * math.pi) + 1) * 127.5,        --G
	(math.sin(Map.rgb + 4/3 * math.pi) + 1) * 127.5)        --B

	love.graphics.draw(Bground.image, Bground.x, Bground.y, Bground.angle, Bground.scale, Bground.scale, Bground.ox, Bground.oy)
	love.graphics.draw(Border.image, 0, 0)
end

return Map
