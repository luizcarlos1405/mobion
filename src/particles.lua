Particles = {}

-- Updates the existing particle system and remove the ones that are no longer
-- necessary
function Particles.update(dt)
	for i,P in ipairs(Particles) do
		if P:getCount() == 0  then
			table.remove(Particles, i)
		end
		P:update(dt)
	end
end
--Draw any particle system existing
function Particles.draw()
	for _,P in ipairs(Particles) do
		love.graphics.draw(P, P.x, P.y)
	end
end
--Emits particles and put then in a table so they can be emitted everywhere
function Particles.emit(ParticleDamping, SpreadAngle, ParticleImage, Number, Speed, LifeTime, ParticleRed, ParticleGreen, ParticleBlue, EmitX, EmitY, EmitAngle)
	system = love.graphics.newParticleSystem(ParticleImage)
	system:setPosition(EmitX, EmitY)
	system:setParticleLifetime(0.5, LifeTime)
	system:setSizeVariation(0.5)
	system:setLinearDamping(ParticleDamping)
	system:setSpeed(0, Speed)
	system:setSpread(SpreadAngle)
	system:setEmitterLifetime(0.2)
	system:setDirection(EmitAngle)
	system:setColors(ParticleRed, ParticleGreen, ParticleBlue, ParticleRed, ParticleGreen, ParticleBlue, 255, 0) -- Fade to transparency.
	system:setEmitterLifetime(0.5, LifeTime)
	system:emit(Number)
	table.insert(Particles, system)
end
