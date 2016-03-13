local Virus        = {}

function Virus.load()
	viruses = {}
	-- Virus and particles loading
	Virus.image    = love.graphics.newImage("assets/sprites/eneon.png")
	Virus.particle = love.graphics.newImage("assets/sprites/particle.png")
	Virus.deathsound = love.audio.newSource("assets/sounds/morri.mp3", "static")
	--Some variables
	SpawnTime      = love.math.random(2, 3)
	Behavior       = 1
	morritimer     = 0
end

function Virus.spawn()
	if SpawnTime < 0 then
		SpawnTime        = love.math.random(2, 4)
		virus            = {}
		virus.image      = Virus.image
		virus.r          = virus.image:getWidth() / 2
		virus.x          = love.math.random(virus.r, Border.w - virus.r)
		virus.y          = love.math.random(virus.r, Border.h)
		virus.vel        = 400
		virus.betime     = 0
		virus.body       = love.physics.newBody(World, virus.x, virus.y, "dynamic")
		virus.shape      = love.physics.newCircleShape(virus.r)
		virus.fixture    = love.physics.newFixture(virus.body, virus.shape, 0.05)
		virus.behavior   = love.math.random(1, 10)
		virus.red        = love.math.random(127.5, 255)
		virus.green      = love.math.random(127.5, 255)
		virus.blue       = love.math.random(127.5, 255)
		virus.body:setAngle(love.math.random(0, 2 * math.pi))
		virus.fixture:setUserData("Enemy")
		table.insert(viruses, virus)
	end
end

function Virus.update(dt)

	SpawnTime = SpawnTime - dt
	morritimer = morritimer - dt
	for _,v in ipairs(viruses) do
		v.betime = v.betime - dt
		v.body:setAngularVelocity(0)
		if v.betime < 0 then
			v.betime = love.math.random(1, 2) / 2
			v.behavior = love.math.random(1,13)
			Behavior = v.behavior
		end
		if v.behavior == 1 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)
			v.body:setAngle(v.body:getAngle() + (math.pi / 2) * dt)

		elseif v.behavior == 2 then
			v.body:setLinearVelocity(math.sin(v.body:getAngle()) * v.vel, math.cos(v.body:getAngle()) * v.vel)
			v.body:setAngle(v.body:getAngle() - (math.pi / 2) * dt)

		elseif v.behavior == 3 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)
			v.body:setAngle(v.body:getAngle() + (math.pi / 4) * dt)

		elseif v.behavior == 4 then
			v.body:setLinearVelocity(math.sin(v.body:getAngle()) * v.vel, math.cos(v.body:getAngle()) * v.vel)
			v.body:setAngle(v.body:getAngle() - (math.pi / 4) * dt)

		elseif v.behavior == 5 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)

		elseif v.behavior == 6 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)
			v.body:setAngle(v.body:getAngle() + (math.pi / 8) * dt)

		elseif v.behavior == 7 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)
			v.body:setAngle(v.body:getAngle() - (math.pi / 8) * dt)

		elseif v.behavior == 8 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)
			v.body:setAngle(Player.body:getAngle())

		elseif v.behavior == 9 then
			v.body:setLinearVelocity(math.cos(v.body:getAngle()) * v.vel, math.sin(v.body:getAngle()) * v.vel)
			v.body:setAngle(- Player.body:getAngle())
		elseif v.behavior == 10 or v.behavior == 11 or v.behavior == 12 or v.behavior == 13 then
			local xdistance = Player.body:getX() - v.body:getX()
			local ydistance = Player.body:getY() - v.body:getY()
			local distance  = (xdistance ^ 2 + ydistance ^ 2) ^ (1 / 2)
			v.body:setLinearVelocity((xdistance / distance) * v.vel * 2, (ydistance / distance) * v.vel * 2)
			v.body:setAngle(v.body:getAngle() + 1)
		end
	end

	Virus.spawn(dt)
end

function Virus.draw()
	for _,v in ipairs(viruses) do
			love.graphics.setColor(v.red, v.green, v.blue)
			love.graphics.draw(virus.image, v.body:getX(), v.body:getY(), v.body:getAngle(), 1, 1, v.r, v.r)
	end
end

return Virus
