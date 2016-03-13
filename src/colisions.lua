text = "Last colisions:"

local Virus = require("enemies/virus")

function beginContact(fa, fb, coll)
	-- Destroy the bodies and erase viruses and bullets that collide
	for j,b in ipairs(Player.bullets) do
		if b.fixture == fa or b.fixture == fb then
			for i,v in ipairs(viruses) do
					if v.fixture == fa or v.fixture == fb then
					-- emit the particles (virus explosion)
					Particles.emit(2,               -- Particle Damping
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
					table.remove(viruses, i)
					table.remove(Player.bullets, j)
					v.body:destroy()
					b.body:destroy()
				end
			end
		end
	end
	--Just for controlling purposes
	text = "Last colision: "..fa:getUserData().." and "..fb:getUserData()
end

function endContact(a, b, coll)

end

function preSolve(a, b, coll)

end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
