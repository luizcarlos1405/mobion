Enemies     = {}
SpawnTime   = 0
Behavior    = 1
morritimer  = 0
morrix      = 0
morriy      = 0

function Enemies.spawn(w, h)
	if SpawnTime < 0 then
		SpawnTime      = love.math.random(2, 4)
		enemy          = {}
		enemy.image    = love.graphics.newImage("sprites/enemy.png")
		enemy.r        = 16
		enemy.x        = w / 2--love.math.random(enemy.r, w - enemy.r)
		enemy.y        = h / 2 - 100--love.math.random(enemy.r, 300)
		enemy.vel      = 200
		enemy.betime   = 0
		enemy.body     = love.physics.newBody(World, enemy.x, enemy.y, "dynamic")
		enemy.shape    = love.physics.newCircleShape(enemy.r)
		enemy.fixture  = love.physics.newFixture(enemy.body, enemy.shape, 0.05)
		enemy.behavior = love.math.random(1, 5)
		enemy.red      = love.math.random(0, 255)
		enemy.green    = love.math.random(0, 255)
		enemy.blue     = love.math.random(0, 255)
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
			e.betime = love.math.random(0, 3)
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
		if e.body:isDestroyed() == false then
			love.graphics.setColor(e.red, e.green, e.blue)
			love.graphics.circle("fill", e.body:getX(), e.body:getY(), e.r)
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(enemy.image, e.body:getX(), e.body:getY(), e.body:getAngle(), 1, 1, 16, 16)
		end
	end
	if morritimer > 0 then
		love.graphics.print("Morri!", morrix, morriy)
	end
end
