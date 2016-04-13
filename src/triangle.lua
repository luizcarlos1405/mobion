local Triangle = {}

function Triangle.load()
	Triangle.bullets             = {}
	Triangle.scale               = 1
	Triangle.shotparticle        = love.graphics.newImage("assets/sprites/sparticle.png")
	Triangle.image               = love.graphics.newImage("assets/sprites/triangle.png")
	-- Triangle.glow              = love.graphics.newImage("assets/sprites/triangleglow.png")
	Triangle.sideshot            = 1
	Triangle.w                   = Triangle.image:getWidth()
	Triangle.h                   = Triangle.image:getHeight()
	Triangle.body                = love.physics.newBody(World, Triangle.w, Triangle.h, "dynamic")
	Triangle.shape               = love.physics.newPolygonShape(-Triangle.h / 3, -Triangle.w / 2, -Triangle.h / 3, Triangle.w / 2, 2 * Triangle.h / 3, 0)
	Triangle.fixture             = love.physics.newFixture(Triangle.body, Triangle.shape, 5)
	Triangle.xvel, Triangle.yvel = 0, 0
	Triangle.avel                = 10
	Triangle.maxvel              = 500
	Triangle.prop                = 300
	Triangle.life                = 50
	Triangle.damage              = 5
	Triangle.cooldown            = 0
	Triangle.sparktime           = 0
	Triangle.body:setAngle(-math.pi / 2)
	Triangle.body:setLinearDamping(4)
	Triangle.body:setAngularDamping(20)
	Triangle.angle             = Triangle.body:getAngle()
	Triangle.fixture:setUserData("Triangle")
	Triangle.fixture:setCategory(2)
	Triangle.body:setPosition(Border.w / 2, Border.h / 2)
	-- Triangle.body:setAngularVelocity(5)

	bullimg = love.graphics.newImage("assets/sprites/bneon.png")
end

function Triangle.update(dt)
	-- Updates Triangle position
	-- Triangle.angle             = Triangle.body:getAngle() + dt / 8
	Triangle.angle               = Triangle.body:getAngle()
	Triangle.xvel, Triangle.yvel = Triangle.body:getLinearVelocity()
	Triangle.cooldown            = Triangle.cooldown - dt
	Triangle.sparktime           = Triangle.sparktime - dt

	for i, b in ipairs(Triangle.bullets) do
		b.lifetime = b.lifetime - dt
		if b.lifetime <= 0 then
			table.remove(Triangle.bullets, i)
		end
	end

	camera:setPosition(Triangle.body:getX(), Triangle.body:getY())
	-- camera:setAngle(Triangle.body:getAngle())
end

function Triangle.draw()
	 -- Change color over the time
	love.graphics.setColor((math.sin(Map.rgb) + 1) * 127.5, --R
	(math.sin(Map.rgb + 2/3 * math.pi) + 1) * 127.5,        --G
	(math.sin(Map.rgb + 4/3 * math.pi) + 1) * 127.5)        --B

	-- Draw bullets
	for _,b in ipairs(Triangle.bullets) do
		love.graphics.draw(b.image, b.body:getX(), b.body:getY(), b.body:getAngle(), b.stretch, b.stretch, b.w / 4, b.h / 2)
	end

	-- Draws the Triangle
	if Triangle.life > 0 then
		love.graphics.draw(Triangle.image,                    -- Image
		Triangle.body:getX(),                                 -- X position
		Triangle.body:getY(),                                 -- Y position
		Triangle.angle, Triangle.scale, Triangle.scale,       -- Angle and scale
		Triangle.h / 3,                                       -- X center
		Triangle.h / 2)                                       -- Y center
	else
		-- End games when life ends
		Gameovermenu:draw()
	end

	-- Draw lifebar
	love.graphics.setLineWidth(10)
	love.graphics.line(camera.x + 15, camera.y + 15, camera.x + 15 + Triangle.life * 10, camera.y + 15)
end

function Triangle.fire()
	if Triangle.cooldown <= 0 then
		bullet           = {}
		Triangle.cooldown  = 0.2
		bullet.body      = love.physics.newBody(World, Triangle.body:getX(), Triangle.body:getY(), "kinematic")
		bullet.shape     = love.physics.newCircleShape(8)
		bullet.fixture   = love.physics.newFixture(bullet.body, bullet.shape, 0.05)
		Triangle.sparktime = 0.1
		bullet.image     = bullimg
		bullet.w         = bullimg:getWidth()
		bullet.h         = bullimg:getHeight()
		bullet.vel       = 3000
		bullet.stretch   = 0.8
		bullet.lifetime  = 2
		bullet.fixture:setUserData("Bullet")
		bullet.body:setBullet(true)
		bullet.body:setAngle(Triangle.angle)
		if Triangle.sideshot == 1 then
			bullet.body:setX(Triangle.body:getX() + 25 * math.sin(Triangle.angle))
			bullet.body:setY(Triangle.body:getY() - 25 * math.cos(Triangle.angle))
			Triangle.sideshot = 2
		else
			bullet.body:setX(Triangle.body:getX() - 25 * math.sin(Triangle.angle))
			bullet.body:setY(Triangle.body:getY() + 25 * math.cos(Triangle.angle))
			Triangle.sideshot = 1
		end
		bullet.body:setLinearVelocity(bullet.vel * math.cos(bullet.body:getAngle()), bullet.vel * math.sin(bullet.body:getAngle()))
		bullet.fixture:setMask(2)
		-- Emit particles
		if Triangle.sideshot == 2 then
			Particles.emit(5,                                                  -- Particle Damping
			math.pi / 5,                                                      -- SpreadAngle
			Triangle.shotparticle,                                               -- ParticleImage
			100,                                                               -- Number
			200,                                                               -- Speed
			3,                                                                 -- LifeTime
			(math.sin(Map.rgb) + 1) * 127.5,                                       -- R
			(math.sin(Map.rgb + 2/3 * math.pi) + 1) * 127.5,                       -- G
			(math.sin(Map.rgb + 4/3 * math.pi) + 1) * 127.5,                       -- B
			Triangle.body:getX() + (Triangle.h / 2 - 18) * math.cos(Triangle.angle) + 25 * math.sin(Triangle.angle), -- EmitX
			Triangle.body:getY() + (Triangle.w / 2 - 18) * math.sin(Triangle.angle) - 25 * math.cos(Triangle.angle), -- EmitY
			Triangle.angle)                                                    -- EmitAngle
		else
			Particles.emit(5,                                                  -- Particle Damping
			math.pi / 5,                                                      -- SpreadAngle
			Triangle.shotparticle,                                               -- ParticleImage
			100,                                                               -- Number
			200,                                                               -- Speed
			3,                                                                 -- LifeTime
			(math.sin(Map.rgb) + 1) * 127.5,                                       -- R
			(math.sin(Map.rgb + 2/3 * math.pi) + 1) * 127.5,                       -- G
			(math.sin(Map.rgb + 4/3 * math.pi) + 1) * 127.5,                       -- B
			Triangle.body:getX() + (Triangle.h / 2 - 18) * math.cos(Triangle.angle) - 25 * math.sin(Triangle.angle), -- EmitX
			Triangle.body:getY() + (Triangle.w / 2 - 18) * math.sin(Triangle.angle) + 25 * math.cos(Triangle.angle), -- EmitY
			Triangle.angle)                                                    -- EmitAngle
		end

		table.insert(Triangle.bullets, bullet)

		love.audio.setVolume(1)
		shot:play()
		love.audio.setVolume(0.2)
	end
end

return Triangle
