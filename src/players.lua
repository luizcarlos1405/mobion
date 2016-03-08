Player = {}

function Player.load()
	Player.shotparticle      = love.graphics.newImage("sprites/sparticle.png")
	Player.image             = love.graphics.newImage("sprites/pwneon.png")
	Player.scale             = 1
	Player.shotspark         = love.graphics.newImage("sprites/sneon.png")
	Player.w                 = Player.image:getWidth() * Player.scale
	Player.h                 = Player.image:getHeight() * Player.scale
	Player.body              = love.physics.newBody(World, Width / 2, Height / 2, "dynamic")
	Player.shape             = love.physics.newRectangleShape(Player.w, Player.h)
	Player.fixture           = love.physics.newFixture(Player.body, Player.shape, 5)
	Player.xvel, Player.yvel = 0, 0
	Player.avel              = 7
	Player.prop              = 80
	Player.cooldown          = 0
	Player.sparktime         = 0
	Player.bullets           = {}
	Player.fixture:setUserData("Player")
	Player.body:setAngle(0)
	Player.angle             = Player.body:getAngle() - math.pi / 2
	Player.body:setLinearDamping(1)
	Player.body:setAngularDamping(15)
	--Player.image:setFilter("nearest", "nearest")
	--Player.body:setAngularVelocity(5)
	--Player.body:setLinearVelocity(100, 0)
	Player.fixture:setCategory(2)

	bullimg = love.graphics.newImage("sprites/bneon.png")

	rgb = -999999999
	ColorChangeVel = 0.02
end

function Player.update(dt)
	-- For changing colors with the time
	rgb = rgb + ColorChangeVel * dt

	-- Updates Player position
	Player.angle             = Player.body:getAngle() - math.pi / 2
	Player.xvel, Player.yvel = Player.body:getLinearVelocity()
	Player.cooldown          = Player.cooldown - dt
	Player.sparktime         = Player.sparktime - dt

	for i, b in ipairs(Player.bullets) do
		b.lifetime = b.lifetime - dt
		if b.lifetime <= 0 then
			table.remove(Player.bullets, i)
		end
	end
end

function Player.draw()
	-- Change color over the time
	love.graphics.setColor((math.sin(rgb) + 1) * 127.5, --R
	(math.sin(rgb + 2/3 * math.pi) + 1) * 127.5,        --G
	(math.sin(rgb + 4/3 * math.pi) + 1) * 127.5)        --B

	-- Draws the Player

	love.graphics.draw(Player.image,                    -- Image
	Player.body:getX(),                                 -- X position
	Player.body:getY(),                                 -- Y position
	Player.angle, Player.scale, Player.scale, -- Angle and scale
	Player.w / 2,                                       -- X center
	Player.h / 2)                                       -- Y center
	-- (image, xposition, yposition, rotation, multiplyimageWidth, multiplyimageHeight, xcenter, ycenter, kx, ky)

	for _,b in ipairs(Player.bullets) do
		love.graphics.draw(b.image, b.body:getX(), b.body:getY(), b.body:getAngle(), b.stretch, b.stretch, b.w / 4, b.h / 2)
	end

	if Player.sparktime > 0 then
		love.graphics.draw(Player.shotspark,
		Player.body:getX() + (Player.h / 2 - 12) * math.cos(Player.angle),
		Player.body:getY() + (Player.w / 2 - 12) * math.sin(Player.angle),
		Player.angle, Player.scale, Player.scale,
		Player.shotspark:getWidth() / 2,
		Player.shotspark:getHeight() / 2)
	end
end

function Player.fire()
	if Player.cooldown <= 0 then
		bullet           = {}
		Player.cooldown  = 0.3
		bullet.body      = love.physics.newBody(World, Player.body:getX(), Player.body:getY(), "kinematic")
		bullet.shape     = love.physics.newCircleShape(8)
		bullet.fixture   = love.physics.newFixture(bullet.body, bullet.shape, 0.05)
		Player.sparktime = 0.1
		bullet.image     = bullimg
		bullet.w         = bullimg:getWidth()
		bullet.h         = bullimg:getHeight()
		bullet.vel       = 2000
		bullet.stretch   = 1
		bullet.lifetime  = 1
		bullet.fixture:setUserData("Bullet")
		bullet.body:setBullet(true)
		bullet.body:setAngle(Player.angle)
		bullet.body:setX((((Player.h + 18) / 2) * math.cos(bullet.body:getAngle())) + Player.body:getX())
		bullet.body:setY((((Player.w + 18) / 2) * math.sin(bullet.body:getAngle())) + Player.body:getY())
		bullet.body:setLinearVelocity(bullet.vel * math.cos(bullet.body:getAngle()), bullet.vel * math.sin(bullet.body:getAngle()))

		Particles.emit(5,                                                  -- Particle Damping
		math.pi / 12,                                                      -- SpreadAngle
		Player.shotparticle,                                               -- ParticleImage
		100,                                                               -- Number
		300,                                                               -- Speed
		3,                                                                 -- LifeTime
		(math.sin(rgb) + 1) * 127.5,                                       -- R
		(math.sin(rgb + 2/3 * math.pi) + 1) * 127.5,                       -- G
		(math.sin(rgb + 4/3 * math.pi) + 1) * 127.5,                       -- B
		Player.body:getX() + (Player.h / 2 - 12) * math.cos(Player.angle), -- EmitX
		Player.body:getY() + (Player.w / 2 - 12) * math.sin(Player.angle), -- EmitY
		Player.angle)      -- EmitAngle

		table.insert(Player.bullets, bullet)

		shot:play()
	end
end
