local Square = {}

function Square.load()
	Square.bullets           = {}
	Square.scale             = 0.8
	Square.shotparticle      = love.graphics.newImage("assets/sprites/sparticle.png")
	Square.image             = love.graphics.newImage("assets/sprites/squared.png")
	Square.shotspark         = love.graphics.newImage("assets/sprites/sneon.png")
	Square.w                 = Square.image:getWidth()
	Square.h                 = Square.image:getHeight()
	Square.body              = love.physics.newBody(World, Width / 2, Height / 2, "dynamic")
	Square.shape             = love.physics.newRectangleShape(Square.w * Square.scale, Square.h * Square.scale)
	Square.fixture           = love.physics.newFixture(Square.body, Square.shape, 5)
	Square.xvel, Square.yvel = 0, 0
	Square.avel              = 10
	Square.maxvel            = 500
	Square.prop              = 280
	Square.life              = 100
	Square.damage            = 10
	Square.cooldown          = 0
	Square.sparktime         = 0
	Square.body:setAngle(-math.pi / 2)
	Square.body:setLinearDamping(4)
	Square.body:setAngularDamping(20)
	Square.angle             = Square.body:getAngle()
	Square.fixture:setUserData("Square")
	Square.fixture:setCategory(2)
	Square.body:setPosition(Border.w / 2, Border.h / 2)
	-- Square.body:setAngularVelocity(5)

	bullimg = love.graphics.newImage("assets/sprites/bneon.png")
end

function Square.update(dt)
	-- Updates Square position
	Square.angle             = Square.body:getAngle()
	Square.xvel, Square.yvel = Square.body:getLinearVelocity()
	Square.cooldown          = Square.cooldown - dt
	Square.sparktime         = Square.sparktime - dt

	for i, b in ipairs(Square.bullets) do
		b.lifetime = b.lifetime - dt
		if b.lifetime <= 0 then
			table.remove(Square.bullets, i)
		end
	end

	camera:setPosition(Square.body:getX(), Square.body:getY())
	-- camera:setAngle(Square.body:getAngle())
end

function Square.draw()
	-- Draws the Square
	if Square.life > 0 then
		love.graphics.draw(Square.image,                    -- Image
		Square.body:getX(),                                 -- X position
		Square.body:getY(),                                 -- Y position
		Square.angle, Square.scale, Square.scale,           -- Angle and scale
		Square.w / 2,                                       -- X center
		Square.h / 2)                                       -- Y center
	else
		Gameovermenu:draw()
	end
	-- Draw bullets
	for _,b in ipairs(Square.bullets) do
		love.graphics.draw(b.image, b.body:getX(), b.body:getY(), b.body:getAngle(), b.stretch, b.stretch, b.w / 4, b.h / 2)
	end
	-- Draw shotspark
	if Square.sparktime > 0 and Square.life > 0 then
		love.graphics.draw(Square.shotspark,
		Square.body:getX() + (Square.h / 2 - 22) * math.cos(Square.angle),
		Square.body:getY() + (Square.w / 2 - 22) * math.sin(Square.angle),
		Square.angle, Square.scale, Square.scale,
		Square.shotspark:getWidth() / 2,
		Square.shotspark:getHeight() / 2)
	end
	-- Draw lifebar
	love.graphics.setLineWidth(10)
	love.graphics.line(camera.x + 15, camera.y + 15, camera.x + 15 + Square.life * 10, camera.y + 15)
end

function Square.fire()
	if Square.cooldown <= 0 then
		bullet           = {}
		Square.cooldown  = 0.4
		bullet.body      = love.physics.newBody(World, Square.body:getX(), Square.body:getY(), "kinematic")
		bullet.shape     = love.physics.newCircleShape(8)
		bullet.fixture   = love.physics.newFixture(bullet.body, bullet.shape, 0.05)
		Square.sparktime = 0.1
		bullet.image     = bullimg
		bullet.w         = bullimg:getWidth()
		bullet.h         = bullimg:getHeight()
		bullet.vel       = 3000
		bullet.stretch   = 1
		bullet.lifetime  = 2
		bullet.fixture:setUserData("Bullet")
		bullet.body:setBullet(true)
		bullet.body:setAngle(Square.angle)
		bullet.body:setX((((Square.h) / 2) * math.cos(bullet.body:getAngle())) + Square.body:getX())
		bullet.body:setY((((Square.w) / 2) * math.sin(bullet.body:getAngle())) + Square.body:getY())
		bullet.body:setLinearVelocity(bullet.vel * math.cos(bullet.body:getAngle()), bullet.vel * math.sin(bullet.body:getAngle()))
		bullet.fixture:setMask(2)

		Particles.emit(5,                                                  -- Particle Damping
		math.pi / 12,                                                      -- SpreadAngle
		Square.shotparticle,                                               -- ParticleImage
		100,                                                               -- Number
		300,                                                               -- Speed
		3,                                                                 -- LifeTime
		255,                                                               -- R
		255,                                                               -- G
		255,                                                               -- B
		Square.body:getX() + (Square.h / 2 - 20) * math.cos(Square.angle), -- EmitX
		Square.body:getY() + (Square.w / 2 - 20) * math.sin(Square.angle), -- EmitY
		Square.angle)      -- EmitAngle

		table.insert(Square.bullets, bullet)

		love.audio.setVolume(1)
		shot:play()
		love.audio.setVolume(0.2)
	end
end

return Square
