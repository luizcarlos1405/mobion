text = "Last colisions:"
--Colisions betwen bullets and enemies
function beginContact(fa, fb, coll)
	-- Destroy the bodies and erase enemies and bullets that collide
	for j,b in ipairs(Player.bullets) do
		if b.fixture == fa or b.fixture == fb then
			for i,e in ipairs(Enemies) do
				if e.fixture == fa or e.fixture == fb then
					table.remove(Enemies, i)
					table.remove(Player.bullets, j)
					morritimer = 2
					morrix = e.body:getX() - 16
					morriy = e.body:getY() - 5
					morri:play()
					e.body:destroy()
					b.body:destroy()
				end
			end
		end
	end
	text = "Last colision: "..fa:getUserData().." and "..fb:getUserData()
end

function endContact(a, b, coll)

end

function preSolve(a, b, coll)

end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
