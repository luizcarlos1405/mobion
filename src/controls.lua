
controls   = {}
circ       = {}
rect       = {}
touch      = {}

function controls.load(w, h)
	linesig = 200
	circ.rad = 150
	rect.w = circ.rad * 2
	rect.h = circ.rad / 2
	rect.x = w - rect.w - 80
	rect.y = h - rect.h - 80
	circ.ox = circ.rad + 80
	circ.oy = h - circ.rad - 80
	touch.x = 0
	touch.y = 0
	rect.ox = rect.x + (rect.w / 2)
	rect.oy = rect.y + (rect.h / 2)
	touch.x2 = touch.ox2
	touch.y2 = touch.oy2
	dx = 0
	dy = 0
	circ.dx = 0
	circ.dy = 0
	linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
end

function controls.update(w, h)
	-- Get the touches
	touches = love.touch.getTouches()

	-- If one touch is aplied Updates player speed
	if touches[2] ~= nil then
		x, y = love.touch.getPosition(touches[1])
		if x < w / 2 then
			dx = x - ox
			dy = y - oy
			linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
			circ.dx = circ.rad * (dx / linelen)
			circ.dy = circ.rad * (dy / linelen)
			if linelen > circ.rad then
				player.one.xvel = player.one.xvel + ((circ.dx) / linesig)
				player.one.yvel = player.one.yvel + ((circ.dy) / linesig)
			else
				player.one.xvel = player.one.xvel + dx / linesig
				player.one.yvel = player.one.yvel + dy / linesig
			end
		end
	elseif touches[1] ~= nil then
		if drawrefline == false then
			drawrefline = true
		else
			x, y = love.touch.getPosition(touches[1])
			if x < w / 2 then
				dx = touch.x - circ.ox
				dy = touch.y - circ.oy
				linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
				circ.dx = circ.rad * (dx / linelen)
				circ.dy = circ.rad * (dy / linelen)
				if linelen > circ.rad then
					player.one.xvel = player.one.xvel + (circ.dx / linesig)
					player.one.yvel = player.one.yvel + (circ .dy / linesig)
				else
					player.one.xvel = player.one.xvel + dx / linesig
					player.one.yvel = player.one.yvel + dy / linesig
				end
			else
				touch.x2, touch.y2 = love.touch.getPosition(touches[1])
			end
		end
	end
end

function controls.draw(w, h)
	-- Draws the control references
	love.graphics.setColor(0, 200, 30)

	if touches[1] ~= nil and x < w / 2 then
		if linelen > circ.rad then
			love.graphics.line(circ.ox, circ.oy, circ.ox + circ.dx, circ.oy + circ.dy)
		else
			love.graphics.line(circ.ox, circ.oy, touch.x, touch.y)
		end
	end

	love.graphics.setColor(0, 200, 255, 50)
	love.graphics.circle("fill", circ.ox, circ.oy, circ.rad)
	love.graphics.rectangle("fill", rect.x, rect.y, rect.w, rect.h)
	love.graphics.setColor(0, 0, 0)
	love.graphics.circle("line", circ.ox, circ.oy, circ.rad)
	love.graphics.rectangle("line", rect.x, rect.y, rect.w, rect.h)
end
