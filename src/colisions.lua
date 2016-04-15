text = "Last colisions:"

function beginContact(fa, fb, coll)
	-- Destroy the bodies and erase Viruses and bullets that collide
	for j,b in ipairs(Player.bullets) do
		if b.fixture == fa or b.fixture == fb then
			table.remove(Player.bullets, j)
			b.fixture:destroy()
			b.body:destroy()
			for i,v in ipairs(Viruses) do
				if v.fixture == fa or v.fixture == fb then
					v.life = v.life - Player.damage
					if v.life <= 0 then
						-- emit the particles (virus explosion)
						Particles.emit(0.5,               -- Particle Damping
							math.pi / 2,                -- SpreadAngle
							Virus.particle,             -- ParticleImage
							30,                         -- Number
							300,                        -- Speed
							10,                         -- LifeTime
							255,                        -- ParticleRed
							255,                        -- ParticleGreen
							255,                        -- ParticleBlue
							v.body:getX(),              -- EmitX
							v.body:getY(),              -- EmitY
							b.body:getAngle())          -- EmitAngle
						-- Set where the Morri! text should appear
						morrix = v.body:getX() - 40
						morriy = v.body:getY()
						morritimer = 2
						Virus.deathsound:play()
						-- Kills virus and bullet
						table.remove(Viruses, i)
						table.remove(Player.bullets, j)
						v.body:destroy()
						local xdistance = Player.body:getX() - v.body:getX()
						local ydistance = Player.body:getY() - v.body:getY()
						local distance  = (xdistance ^ 2 + ydistance ^ 2) ^ (1 / 2)
						points = (points + math.floor(distance / 4))
						-- points = points - (points % 1)
					else
						Particles.emit(2,               -- Particle Damping
						math.pi / 2,                -- SpreadAngle
						Player.shotparticle,             -- ParticleImage
						30,                         -- Number
						300,                        -- Speed
						10,                         -- LifeTime
						255,                        -- ParticleRed
						255,                        -- ParticleGreen
						255,                        -- ParticleBlue
						v.body:getX(),              -- EmitX
						v.body:getY(),              -- EmitY
						b.body:getAngle())          -- EmitAngle
					end
				end
			end
		end
	end
	text = "Last colision: "..fa:getUserData().." and "..fb:getUserData()
end

function endContact(fa, fb, coll)

end

function preSolve(fa, fb, coll)
	local dt = love.timer.getDelta()
	for i,v in ipairs(Viruses) do
		if v.fixture == fa or v.fixture == fb then
			if Player.fixture == fa or Player.fixture == fb then
				if v.behavior >= 10 then
					Player.life = Player.life - Virus.damage * dt
				end
				if Player.life <= 0 then
					Particles.emit(2,               -- Particle Damping
					2 * math.pi,                -- SpreadAngle
					Virus.particle,             -- ParticleImage
					100,                         -- Number
					300,                        -- Speed
					10,                         -- LifeTime
					255,                        -- ParticleRed
					255,                        -- ParticleGreen
					255,                        -- ParticleBlue
					Player.body:getX(),         -- EmitX
					Player.body:getY(),         -- EmitY
					0)                          -- EmitAngle
					Player.fixture:setMask(3)
				end
			end
		end
	end
end

function postSolve(fa, fb, coll, normalimpulse, tangentimpulse)

end
