

function bullload()
	bullimg = love.graphics.newImage("sprites/bullet2.png")
end

function bullupdate(dt)
	for i, b in ipairs(Player.bullets) do
		b.lifetime = b.lifetime - dt
		if b.lifetime <= 0 then
			table.remove(Player.bullets, i)
		end
	end
end

function bulldraw()

	love.graphics.setColor(255, 255, 255)
	for _,b in ipairs(Player.bullets) do
		love.graphics.draw(b.image, b.body:getX(), b.body:getY(), b.body:getAngle(), b.stretch, b.stretch, b.w / 4, b.h / 2)
	end
end

function sparkdraw()
	if Player.sparktime > 0 then
		love.graphics.draw(Player.shotspark, Player.body:getX() + ((Player.h / 2) * math.cos(Player.body:getAngle())), Player.body:getY() + ((Player.w / 2) * math.sin(Player.body:getAngle())), Player.body:getAngle(), 1, 1, 8, 8)
	end
end
