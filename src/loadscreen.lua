LoadScreen = {}

function LoadScreen:enter()
	loadtime = 0.1
end

function LoadScreen:update(dt)
	loadtime = loadtime - dt
end

function LoadScreen:draw()
	-- Starts the scalling
	push:apply("start")

	local loading = love.graphics.newText(ecranbigger, "LOADING...")
	love.graphics.draw(loading, Width / 2, Height / 2, 0, 1, 1, loading:getWidth() / 2, loading:getHeight() / 2)

	-- Ends the scalling
	push:apply("end")

	if loadtime < 0 then
		Gamestate.switch(CurrentState)
	end
end

function LoadScreen:leave()
	loadtime = nil
end
