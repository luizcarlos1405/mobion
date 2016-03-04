function love.conf(t)
	--t.love.version           = 0.10.1
	gameWidth, gameHeight = 1280, 720
	t.window.title  	= "Mobion"
	love.filesystem.setIdentity("saves")
	--t.console       	= true
end
