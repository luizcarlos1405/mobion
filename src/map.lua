Map = {}

function Map.load()

	-- Quads
	tilemap = require("src/tilemap2")
	tilemap.img = love.graphics.newImage("assets/sprites/tilemap.png")
	tilemap.quad =
	{
		love.graphics.newQuad(1, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(130, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(259, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(388, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(517, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(646, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(775, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(904, 0, 128, 128, tilemap.img:getDimensions()),
		love.graphics.newQuad(1, 129, 128, 128, tilemap.img:getDimensions())
	}
	tilemap.csh = love.physics.newCircleShape(tilemap.tilewidth / 2)
	tilemap.ssh = love.physics.newRectangleShape(tilemap.tilewidth, tilemap.tileheight)
	tilemap.bod = {}

	-- Colors and scale
	Map.scale          = 1
	Map.angle          = 0

	-- Creating a chainshape that won't allow to get out of the screen
	Border         = {}
	Border.x       = tilemap.tilewidth / 2
	Border.y       = tilemap.tileheight / 2
	Border.w       = tilemap.width * tilemap.tilewidth - (tilemap.tilewidth * 1.5)
	Border.h       = tilemap.height * tilemap.tileheight - (tilemap.tileheight * 1.5)
	Border.body    = love.physics.newBody(World, 0, 0, "static")
	Border.shape   = love.physics.newChainShape(true, Border.x, Border.y, Border.w, Border.y, Border.w, Border.h, Border.x, Border.h)
	Border.fixture = love.physics.newFixture(Border.body, Border.shape)
	Border.fixture:setUserData("Border")

	-- Background
	Bground = {}
	Bground.image  = love.graphics.newImage("assets/sprites/background.png")
	Bground.w      = Bground.image:getWidth()
	Bground.h      = Bground.image:getHeight()
	Bground.x      = Border.w / 2
	Bground.y      = Border.h / 2
	Bground.ox     = Bground.w / 2
	Bground.oy     = Bground.h / 2
	Bground.scale  = Map.scale
	Bground.angle  = Map.angle

	-- Create pilar bodies
	tilemap.x = 0
	tilemap.y = 0
	for i, layer in ipairs(tilemap.layers) do
		for j=1, #layer.data do
			if tilemap.quad[layer.data[j]] then
				if layer.data[j] ~=1 and layer.data[j] ~=2 then
					if layer.data[j] == 3 then
						local quad = {}
						quad.body = love.physics.newBody(World, tilemap.x, tilemap.y, "static")
						quad.shape = tilemap.ssh
						quad.fixture = love.physics.newFixture(quad.body, quad.shape)
						quad.fixture:setUserData("Square Pilar")
						table.insert(tilemap.bod, quad)
					else
						local quad = {}
						quad.body = love.physics.newBody(World, tilemap.x, tilemap.y, "static")
						quad.shape = tilemap.csh
						quad.fixture = love.physics.newFixture(quad.body, quad.shape)
						quad.fixture:setUserData("Circle Pilar")
						table.insert(tilemap.bod, quad)
					end
				end
			end
			if j % tilemap.width == 0 then
				tilemap.y = tilemap.y + tilemap.tileheight
				tilemap.x = -tilemap.tilewidth
			end
			tilemap.x = tilemap.x + tilemap.tilewidth
		end
	end
end

function Map.update(dt)
	if Player.life > 0 then
		Bground.x = Player.body:getX() - Player.body:getX() / 2
		Bground.y = Player.body:getY() - Player.body:getY() / 2
	end
end

function Map.draw()
	love.graphics.draw(Bground.image, Bground.x, Bground.y, Bground.angle, Bground.scale, Bground.scale, Bground.ox, Bground.oy)

	tilemap.x = 0
	tilemap.y = 0
	for i, layer in ipairs(tilemap.layers) do
		for j=1, #layer.data do
			if tilemap.quad[layer.data[j]] then
				love.graphics.draw(tilemap.img, tilemap.quad[layer.data[j]], tilemap.x, tilemap.y, 0, 1, 1, tilemap.tilewidth / 2, tilemap.tileheight / 2)
			end
			if j % tilemap.width == 0 then
				tilemap.y = tilemap.y + tilemap.tileheight
				tilemap.x = -tilemap.tilewidth
			end
			tilemap.x = tilemap.x + tilemap.tilewidth
		end
	end
end
