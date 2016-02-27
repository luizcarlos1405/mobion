Player = {}

function Player.load(Width, Height)
	Player.image             = love.graphics.newImage("sprites/pwgun.png")
	Player.shotspark         = love.graphics.newImage("sprites/shotspark.png")
	Player.body              = love.physics.newBody(World, Player.x, Player.y, "dynamic")
	Player.shape             = love.physics.newRectangleShape(Player.image:getWidth(), Player.image:getHeight())
	Player.fixture           = love.physics.newFixture(Player.body, Player.shape, 5)
	Player.w                 = Player.image:getWidth()
	Player.h                 = Player.image:getHeight()
	Player.xvel, Player.yvel = 0, 0
	Player.avel              = 5
	Player.prop              = 40
	Player.cooldown          = 0
	Player.sparktime         = 0
	Player.bullets           = {}
	Player.fixture:setUserData("Player")
	Player.body:setX(Width / 2)
	Player.body:setY(Height / 2)
	Player.body:setAngle(- math.pi / 2)
	Player.body:setLinearDamping(1)
	Player.body:setAngularDamping(15)
	--Player.body:setAngularVelocity(Player.avel)
	--Player.body:setLinearVelocity(100, 0)
	--Player.fixture:setMask(10)
end

function Player.update(dt)
	-- Updates Player position
	Player.xvel, Player.yvel = Player.body:getLinearVelocity()
	Player.cooldown  = Player.cooldown - dt
	Player.sparktime = Player.sparktime - dt
end

function Player.draw()
	-- Draws the Player
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(Player.image, Player.body:getX(), Player.body:getY(), Player.body:getAngle(), 1, 1, Player.w / 2, Player.h / 2)
	-- (image, xposition, yposition, rotation, multiplyimageWidth, multiplyimageHeight, xcenter, ycenter, kx, ky)
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
		bullet.lifetime  = 1.5
		bullet.fixture:setUserData("Bullet")
		bullet.body:setBullet(true)
		bullet.body:setAngle(Player.body:getAngle())
		bullet.body:setX((((Player.h + 18) / 2) * math.cos(bullet.body:getAngle())) + Player.body:getX())
		bullet.body:setY((((Player.w + 18) / 2) * math.sin(bullet.body:getAngle())) + Player.body:getY())
		bullet.body:setLinearVelocity(bullet.vel * math.cos(bullet.body:getAngle()), bullet.vel * math.sin(bullet.body:getAngle()))
		--bullet.fixture:setMask(10)
		table.insert(Player.bullets, bullet)
		shot:play()
	end
end
