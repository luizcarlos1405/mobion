Enemies        = {}

function Enemies.load()
	-- Enemies and particles loading
	Enemies.image    = love.graphics.newImage("sprites/eneon.png")
	Enemies.particle = love.graphics.newImage("sprites/particle.png")
	--Some variables
	SpawnTime      = love.math.random(2, 3)
	Behavior       = 1
	morritimer     = 0
end

function Enemies.spawn()
	if SpawnTime < 0 then
		SpawnTime      = love.math.random(2, 4)
		enemy          = {}
		enemy.image    = Enemies.image
		enemy.r        = enemy.image:getWidth() / 2
		enemy.x        = love.math.random(enemy.r, Width - enemy.r)
		enemy.y        = love.math.random(enemy.r, 600)
		enemy.vel      = 400
		enemy.betime   = 0
		enemy.body     = love.physics.newBody(World, enemy.x, enemy.y, "dynamic")
		enemy.shape    = love.physics.newCircleShape(enemy.r)
		enemy.fixture  = love.physics.newFixture(enemy.body, enemy.shape, 0.05)
		enemy.behavior = love.math.random(1, 10)
		enemy.red      = love.math.random(127.5, 255)
		enemy.green    = love.math.random(127.5, 255)
		enemy.blue     = love.math.random(127.5, 255)
		enemy.body:setAngle(love.math.random(0, 2 * math.pi))
		enemy.fixture:setUserData("Enemy")
		table.insert(Enemies, enemy)
	end
end

function Enemies.update(dt)

	SpawnTime = SpawnTime - dt
	morritimer = morritimer - dt
	for _,e in ipairs(Enemies) do
		e.betime = e.betime - dt
		e.body:setAngularVelocity(0)
		if e.betime < 0 then
			e.betime = love.math.random(1, 2) / 2
			e.behavior = love.math.random(1,10)
			Behavior = e.behavior
		end
		if e.behavior == 1 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)
			e.body:setAngle(e.body:getAngle() + (math.pi / 2) * dt)

		elseif e.behavior == 2 then
			e.body:setLinearVelocity(math.sin(e.body:getAngle()) * e.vel, math.cos(e.body:getAngle()) * e.vel)
			e.body:setAngle(e.body:getAngle() - (math.pi / 2) * dt)

		elseif e.behavior == 3 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)
			e.body:setAngle(e.body:getAngle() + (math.pi / 4) * dt)

		elseif e.behavior == 4 then
			e.body:setLinearVelocity(math.sin(e.body:getAngle()) * e.vel, math.cos(e.body:getAngle()) * e.vel)
			e.body:setAngle(e.body:getAngle() - (math.pi / 4) * dt)

		elseif e.behavior == 5 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)

		elseif e.behavior == 6 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)
			e.body:setAngle(e.body:getAngle() + (math.pi / 8) * dt)

		elseif e.behavior == 7 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)
			e.body:setAngle(e.body:getAngle() - (math.pi / 8) * dt)

		elseif e.behavior == 8 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)
			e.body:setAngle(Player.body:getAngle())

		elseif e.behavior == 9 then
			e.body:setLinearVelocity(math.cos(e.body:getAngle()) * e.vel, math.sin(e.body:getAngle()) * e.vel)
			e.body:setAngle(- Player.body:getAngle())
		end
	end
end

function Enemies.draw()
	for _,e in ipairs(Enemies) do
			love.graphics.setColor(e.red, e.green, e.blue)
			love.graphics.draw(enemy.image, e.body:getX(), e.body:getY(), e.body:getAngle(), 1, 1, e.r, e.r)
	end
end
