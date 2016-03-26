camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0

function camera:set()
	love.graphics.push()
	love.graphics.translate(Width / 2, Height / 2)
	love.graphics.rotate(-self.rotation)
	love.graphics.translate(- Width / 2, - Height / 2)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
	love.graphics.pop()
end

function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
	self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
	self.x = (x - Width / 2) or self.x
	self.y = (y - Height / 2) or self.y
end

function camera:setAngle(a)
	self.rotation = a
	length = ((Width / 2) ^ 2 + (Height / 2) ^ 2) ^ (1 / 2)
	-- self.x = self.x - math.cos(Player.body:getAngle()) * length--math.cos(Player.body:getAngle()) * (((screenWidth / 2) ^ 2 + (screenHeight / 2) ^ 2) ^ (1 / 2))
	-- self.y = self.y - math.sin(Player.body:getAngle()) * length--math.sin(Player.body:getAngle()) * (((screenWidth / 2) ^ 2 + (screenHeight / 2) ^ 2) ^ (1 / 2))
end

function camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end
