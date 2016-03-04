text = "Last colisions:"

function beginContact(fa, fb, coll)
	-- Destroy the bodies and erase enemies and bullets that collide
	for j,b in ipairs(Player.bullets) do
		if b.fixture == fa or b.fixture == fb then
			for i,e in ipairs(Enemies) do
					if e.fixture == fa or e.fixture == fb then
					-- emit the particles (enemy explosion)
					Particles.emit(2,           -- Particle Damping
					math.pi / 2,                -- SpreadAngle
					Enemies.particle,           -- ParticleImage
					30,                         -- Number
					300,                        -- Speed
					10,                         -- LifeTime
					e.red,                      -- ParticleRed
					e.green,                    -- ParticleGreen
					e.blue,                     -- ParticleBlue
					e.body:getX(),              -- EmitX
					e.body:getY(),              -- EmitY
					b.body:getAngle())          -- EmitAngle
					-- Set where the Morri! text should appear
					morrix = e.body:getX()
					morriy = e.body:getY()
					morritimer = 2
					morri:play()
					-- Kills enemy and bullet
					table.remove(Enemies, i)
					table.remove(Player.bullets, j)
					e.body:destroy()
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
