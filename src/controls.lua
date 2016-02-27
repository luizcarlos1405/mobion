
Controls    = {}
local move  = {}
local spin  = {}
local touch = {}
local fire  = {}

function Controls.load(w, h)
	-- Divides dx and dy so the velocity don't get directly proportional to the
	-- lenght of the line
	-- Reference circle for moving properties
	move.rad = 150
	move.ox = move.rad + 80
	move.oy = h - move.rad - 80
	move.dx = 0
	move.dy = 0
	-- Reference rectangle for spinning properties
	spin.w = move.rad * 2
	spin.h = move.rad / 2
	spin.x = w - spin.w - 80
	spin.y = h - spin.h - 80
	spin.ox = spin.x + (spin.w / 2)
	spin.oy = spin.y + (spin.h / 2)
	-- Fire button
	fire.image = love.graphics.newImage("sprites/firebutton.png")
	fire.rad = 120
	fire.w = fire.image:getWidth()
	fire.h = fire.image:getHeight()
	fire.x = spin.x + 20
	fire.y = spin.y - fire.h - 40
	-- Touch coordinates
	touch.x = 0
	touch.y = 0
	--touch.x2 = touch.ox2
	--touch.y2 = touch.oy2
	-- x and y components of the distance betwen the touch and the center of then
	-- circle
	dx = 0
	dy = 0
	linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
end

function Controls.update(w, h, dt)

	-- Get the touches
	touches = love.touch.getTouches()

	-- If at least one touch is aplied Updates Player speed
	if touches[1] ~= nil then
		-- Iterates betwen the first two touches
		for i,_ in ipairs(touches) do
			-- Get the current touch coordinates
			touch.x, touch.y = love.touch.getPosition(touches[i])
			-- Tests if the Player is trying to move
			if touch.x < w / 2 then
				-- Update the x and y variation betwen the touch and the center
				-- Of the reference circle
				dx = touch.x - move.ox
				dy = touch.y - move.oy
				-- Update the distance betwen the touche and the center of the
				-- Circle
				linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
				-- Now some mathmatics to calculate the equivalent but inside
				-- The circle
				move.dx = move.rad * (dx / linelen)
				move.dy = move.rad * (dy / linelen)
				-- If the touche is outside the circle
				if linelen > move.rad then
					-- Then use the equivalent inside the circle
					Player.body:applyForce(move.dx * Player.prop, move.dy * Player.prop)
					--Player.xvel = Player.xvel - (move.dx * Player.prop)
					--Player.yvel = Player.yvel + (move.dy * Player.prop)
				else
					-- else you just use the real variation betwen the touch
					-- and the center of the circle
					Player.body:applyForce(dx * Player.prop, dy * Player.prop)
					--Player.xvel = Player.xvel - dx * Player.prop
					--Player.yvel = Player.yvel + dy * Player.prop
				end
			-- Or if the Player is trying two rotate
			elseif touch.y > spin.y - 5 and touch.y < spin.y + spin.h + 5 then
			-- The rotation velocity variates with position of the touch
			-- in the spin{} draw
				if touch.x > spin.ox then
					if touch.x > spin.x + spin.w then touch.x = spin.x + spin.w end
					Player.body:setAngularVelocity(Player.avel)
					--Player.body:setAngle(Player.body:getAngle() + Player.avel * dt)
				elseif touch.x < spin.ox and touch.x > Width / 2 then
					if touch.x < spin.x then touch.x = spin.x end
					Player.body:setAngularVelocity(- Player.avel)
					--Player.body:setAngle(Player.body:getAngle() - Player.avel * dt)
				end
			elseif touch.y > fire.y - 15 and touch.y < fire.y + fire.h + 15 then
				if touch.x > fire.x - 15 and touch.x < fire.x + fire.w + 15 then
					Player.fire()
				end
			end
		end
	end
end

function Controls.draw(w, h)

	-- Draws the control references
	love.graphics.setColor(0, 200, 30)
	if touches[1] ~= nil then
		for i,_ in ipairs(touches) do
			touch.x, touch.y = love.touch.getPosition(touches[i])
			if touch.x < Width / 2 then
				if linelen > move.rad then
					love.graphics.line(move.ox, move.oy, move.ox + move.dx, move.oy + move.dy)
				else
					love.graphics.line(move.ox, move.oy, touch.x, touch.y)
				end
			elseif touch.y > spin.y - 5 and touch.y < spin.y + spin.h then
				if touch.x > spin.x - 5 and touch.x < spin.x + spin.w then
					love.graphics.line(spin.ox, spin.oy, touch.x, spin.oy)
				elseif touch.x < spin.x then
					love.graphics.line(spin.ox, spin.oy, spin.x, spin.oy)
				else
					love.graphics.line(spin.ox, spin.oy, spin.x + spin.w, spin.oy)
				end
			end
		end
	end

	love.graphics.setColor(0, 200, 255, 50)
	love.graphics.draw(fire.image, fire.x, fire.y)
	love.graphics.circle("fill", move.ox, move.oy, move.rad)
	love.graphics.rectangle("fill", spin.x, spin.y, spin.w, spin.h)
	love.graphics.setColor(0, 0, 0, 50)
	love.graphics.circle("line", move.ox, move.oy, move.rad)
	love.graphics.rectangle("line", spin.x, spin.y, spin.w, spin.h)
	--love.graphics.setColor(255, 255, 255, 150)
end
