Controls = {}

function Controls.load()
	move     = {}
	spin     = {}
	touch    = {}
	fire     = {}
	-- Reference circle for moving properties
	move.image   = love.graphics.newImage("sprites/movewglow.png")
	move.rad     = move.image:getHeight(move.image) / 2 - 45
	move.w       = move.image:getWidth()
	move.h       = move.image:getHeight()
	move.x       = move.w / 2 + 20
	move.y       = Height - move.h / 2 - 20
	move.ox      = move.w / 2
	move.oy      = move.h / 2
	move.angle   = 0
	move.scale   = 1
	move.dx      = 0
	move.dy      = 0
	move.linelen = 0
	move.dangle  = 0

	-- Fire button
	fire.image  = love.graphics.newImage("sprites/firebutton.png")

	-- Reference buttons for spinning
	spin.image   = love.graphics.newImage("sprites/spin.png")
	spin.w       = spin.image:getWidth()
	spin.h       = spin.image:getHeight()
	spin.x       = Width - spin.w / 2 - 80
	spin.y       = Height - spin.h - 30
	spin.ox      = spin.w / 2
	spin.oy      = 0
	spin.angle   = 0
	spin.scale   = 1
	
	if settings.controls == "RotationAtRight" then
		fire.w      = fire.image:getWidth()
		fire.h      = fire.image:getHeight()
		fire.x      = spin.x - fire.w / 2
		fire.y      = spin.y - fire.h - 15
		fire.ox     = fire.w / 2
		fire.oy     = 0
		fire.angle  = 0
		fire.scale  = 1

	elseif settings.controls == "RotationAtLeft" then
		fire.w      = fire.image:getWidth()
		fire.h      = fire.image:getHeight()
		fire.x      = Width - fire.w - 80
		fire.y      = Height - fire.h - 80
		fire.ox     = fire.w / 2
		fire.oy     = 0
		fire.angle  = 0
		fire.scale  = 1
	end
	-- Touch coordinates
	touch.x     = 0
	touch.y     = 0
	-- x and y components of the distance betwen the touch and the center of then
	-- circle
	dx = 0
	dy = 0
end

function Controls.update(dt)

	-- Get the touches
	touches = love.touch.getTouches()

	-- If at least one touch is aplied Updates Player speed
	if touches[1] ~= nil then
		-- Iterates betwen the first two touches
		for i,_ in ipairs(touches) do
			-- Get the current touch coordinates
			touch.x, touch.y = love.touch.getPosition(touches[i])
			touch.x = (Width / screenWidth) * touch.x
			touch.y = (Height / screenHeight) * touch.y
			-- Tests if the Player is trying to move
			if touch.x < Width / 2 then
				-- Update the x and y variation betwen the touch and the center
				-- Of the reference circle
				dx = touch.x - move.x
				dy = touch.y - move.y
				-- Update the distance betwen the touch and the center of the
				-- Circle
				move.linelen = (dx ^ 2 + dy ^ 2) ^ (1 / 2)
				-- Now some mathmatics to calculate the equivalent but inside
				-- The circle
				move.dx = move.rad * (dx / move.linelen)
				move.dy = move.rad * (dy / move.linelen)
				-- gets the angle betwen the pad movement and the player
				move.dangle  = ((math.cos(Player.body:getAngle()) * dx + math.sin(Player.body:getAngle()) * dy) / move.linelen)
				-- If the touch is outside the circle
				if move.linelen > move.rad then
					-- Then use the equivalent inside the circle
					Player.body:applyForce(move.dx * Player.prop, move.dy * Player.prop)
				else
					-- else you just use the real variation betwen the touch
					-- and the center of the circle
					Player.body:applyForce(dx * Player.prop, dy * Player.prop)

				end
				-- Make it turn in the same direction of the movement, choosing the shorter way
				-- But just if the player setted this control setting
				if settings.controls == "RotationAtLeft" then
					-- if move.dangle < math.pi / 0.3
					-- and move.dangle > -math.pi / 0.3 then
					-- 	Player.body:setAngularVelocity(0)
					if move.dangle < 0 then
						Player.body:setAngularVelocity(Player.avel * move.dangle)
					elseif move.dangle > 0 then
						Player.body:setAngularVelocity(Player.avel * move.dangle)
					else
						player.body:setAngularVelocity(0)
					end
				end
			else
				if settings.controls == "RotationAtRight" then
					if PressedButton(touch.x, touch.y, spin.x, spin.y, spin.w, spin.h) and touch.x > spin.x then
							Player.body:setAngularVelocity(Player.avel)
					elseif  PressedButton(touch.x, touch.y, spin.x, spin.y, spin.w, spin.h) and touch.x < spin.x then
							Player.body:setAngularVelocity(- Player.avel)
					end
				end
				if PressedButton(touch.x, touch.y, fire.x, fire.y, fire.w, fire.h) then
						Player.fire()
				end
			end
		end
	end
end

function Controls.draw()

	-- Draws the control references
	if touches[1] ~= nil then
		for i,_ in ipairs(touches) do
			touch.x, touch.y = love.touch.getPosition(touches[i])
			touch.x = (Width / screenWidth) * touch.x
			touch.y = (Height / screenHeight) * touch.y
			-- love.graphics.print(touch.x.."  "..touch.y, 800, 800)
			if touch.x < Width / 2 then
				if move.linelen > move.rad then
					love.graphics.line(move.x, move.y, move.x + move.dx, move.y + move.dy)
				else
					love.graphics.line(move.x, move.y, touch.x, touch.y)
				end
			end
		end
	end

	love.graphics.draw(fire.image, fire.x, fire.y, fire.angle, fire.scale, fire.scale, fire.ox, fire.oy)
	love.graphics.draw(move.image, move.x, move.y, move.angle, move.scale, move.scale, move.ox, move.oy)
	if settings.controls == "RotationAtRight" then
		love.graphics.draw(spin.image, spin.x, spin.y, spin.angle, spin.scale, spin.scale, spin.ox, spin.oy)
	end
	-- (image, xposition, yposition, rotation, multiplyimageWidth, multiplyimageHeight, xcenter, ycenter, kx, ky)
end
