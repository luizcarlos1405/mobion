player = {one = {}, two = {}, tree = {}, four = {}}

function player.load(width, height)
	player.one.i = love.graphics.newImage("sprites/player2.png")
	player.one.x = width / 2 - 10
	player.one.y = height / 2 - 10
	player.one.w = 20
	player.one.h = 20
	player.one.r = 0
	player.one.xvel = 0
	player.one.yvel = 0
	player.one.dxspeed = 0
	player.one.dyspeed = 0
	player.one.minspeed = 0.005
	player.one.fric = 0.035
end

function player.update(dt)
	-- Updates player.one position
	player.one.y = player.one.y + player.one.yvel
	player.one.x = player.one.x + player.one.xvel

	-- Don'to get out of the screen, NEVAR. Colision control
	-- If the player.one is in the left border
	if player.one.x <= 0 + player.one.w then
		-- Assure he wont transpass the left border moving him to the border
		if player.one.x < 0 + player.one.w  then
			player.one.x = 0 + player.one.w
			player.one.xvel = 0
		-- Only moves to the right
	elseif dx > 0 + player.one.h then
			player.one.xvel = player.one.xvel + dx / linesig
		end
	end
	-- The same for the other possibilities
	-- If he is in the right border
	if player.one.x >= width - player.one.w then
		if player.one.x > width - player.one.w then
			player.one.x = width - player.one.w
			player.one.xvel = 0
		elseif dx < 0 then
			player.one.xvel = player.one.xvel + dx / linesig
		end
	end
	-- If he is the down border
	if player.one.y <= 0 + player.one.h then
		if player.one.y < 0 + player.one.h then
			player.one.y = 0 + player.one.h
			player.one.yvel = 0
		elseif dy > 0 then
			player.one.yvel = player.one.yvel + dy / linesig
		end
	end
	-- If he is in the up border
	if player.one.y >= height - player.one.h then
		if player.one.y > height - player.one.h then
			player.one.y = height - player.one.h
			player.one.yvel = 0
		elseif dy < 0 then
			player.one.yvel = player.one.yvel + dy / linesig
		end
	end

	-- Aplies player.one.fric and updates player.one speed
	if (player.one.xvel ^ 2) ^ (1 / 2) > player.one.minspeed then
		player.one.xvel = player.one.xvel - player.one.xvel * player.one.fric

	elseif (player.one.xvel ^ 2) ^ (1 / 2) < player.one.minspeed then
		player.one.xvel = 0
	end
	if (player.one.yvel ^ 2) ^ (1 / 2) > player.one.minspeed then

		player.one.yvel = player.one.yvel - player.one.yvel * player.one.fric
	elseif (player.one.yvel ^ 2) ^ (1 / 2) < player.one.minspeed then
		player.one.yvel = 0

	end
end

function player.draw()
	-- Draws the player.one
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(player.one.i, player.one.x, player.one.y, player.one.r, 1, 1, player.one.w, player.one.h)
	-- (image, xposition, yposition, multiplyimagewidth, multiplyimageheight, xcenter, ycenter, kx, ky)
end

return player.one
