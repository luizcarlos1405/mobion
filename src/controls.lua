
Controls    = {}
move        = {}
spin        = {}
touch       = {}
fire        = {}

function Controls.load(w, h)
	-- Reference circle for moving properties
	move.image    = love.graphics.newImage("sprites/movewglow.png")
	move.rad     = 125--move.image:getHeight(move.image) / 2
	move.ox      = move.rad + 60
	move.oy      = h - move.rad - 60
	move.dx      = 0
	move.dy      = 0
	move.linelen = 0
	-- Reference rectangle for spinning properties
	spin.image   = love.graphics.newImage("sprites/spin.png")
	spin.w       = spin.image:getWidth()
	spin.h       = spin.image:getHeight()
	spin.x       = w - spin.w - 60
	spin.y       = h - spin.h - 20
	spin.ox      = spin.x + (spin.w / 2)
	spin.oy      = spin.y + (spin.h / 2)
	-- Fire button
	fire.image  = love.graphics.newImage("sprites/firebutton.png")
	fire.rad    = 120
	fire.w      = fire.image:getWidth()
	fire.h      = fire.image:getHeight()
	fire.x      = spin.x + fire.w / 3
	fire.y      = spin.y - fire.h - 15
	-- Touch coordinates
	touch.x     = 0
	touch.y     = 0
	--touch.x2 = touch.ox2
	--touch.y2 = touch.oy2
	-- x and y components of the distance betwen the touch and the center of then
	-- circle
	dx = 0
	dy = 0
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
				move.linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
				-- Now some mathmatics to calculate the equivalent but inside
				-- The circle
				move.dx = move.rad * (dx / move.linelen)
				move.dy = move.rad * (dy / move.linelen)
				-- If the touche is outside the circle
				if move.linelen > move.rad then
					-- Then use the equivalent inside the circle
					Player.body:applyForce(move.dx * Player.prop, move.dy * Player.prop)
				else
					-- else you just use the real variation betwen the touch
					-- and the center of the circle
					Player.body:applyForce(dx * Player.prop, dy * Player.prop)
				end
			-- Or if the Player is trying two rotate
			elseif touch.y > spin.y - 5 and touch.y < spin.y + spin.h + 5 then
			-- The rotation velocity variates with position of the touch
				if touch.x > spin.ox then
					if touch.x > spin.x + spin.w then touch.x = spin.x + spin.w end
					Player.body:setAngularVelocity(Player.avel)
				elseif touch.x < spin.ox and touch.x > Width / 2 then
					if touch.x < spin.x then touch.x = spin.x end
					Player.body:setAngularVelocity(- Player.avel)
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
	if touches[1] ~= nil then
		for i,_ in ipairs(touches) do
			touch.x, touch.y = love.touch.getPosition(touches[i])
			if touch.x < Width / 2 then
				if move.linelen > move.rad then
					love.graphics.line(move.ox, move.oy, move.ox + move.dx, move.oy + move.dy)
				else
					love.graphics.line(move.ox, move.oy, touch.x, touch.y)
				end
			end
		end
	end

	love.graphics.draw(fire.image, fire.x, fire.y)
	love.graphics.draw(move.image, move.ox, move.oy, 0, 1, 1, move.image:getWidth() / 2, move.image:getHeight() / 2)
	love.graphics.draw(spin.image, spin.x, spin.y)
	-- (image, xposition, yposition, rotation, multiplyimageWidth, multiplyimageHeight, xcenter, ycenter, kx, ky)
end
