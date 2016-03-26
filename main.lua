-- require all the stuff
require("src/game")
require("src/player")
require("src/controls")
require("src/colisions")
require("src/particles")
require("src/map")
require("enemies/virus")
require("src/gameover")
require("src/mainmenu")
require("src/optionsmenu")
require("src/camera")
require("src/loadscreen")

screenWidth, screenHeight = love.window.getDesktopDimensions()

push      = require("src/push")
Gamestate = require "src/humplib/gamestate"

function love.load()
	-- Screen scaling
	push:setupScreen(Width, Height, screenWidth, screenHeight, {fullscreen = true, resizable = false})
	push:setBorderColor{love.graphics.getBackgroundColor()}

	-- Font load
	ecran       = love.graphics.newFont("fonts/ecran-monochrome.ttf", 24)
	ecranbig    = love.graphics.newFont("fonts/ecran-monochrome.ttf", 80)
	ecranbigger = love.graphics.newFont("fonts/ecran-monochrome.ttf", 120)

	-- Audio load
	bubble    = {}
	bubble[1] = love.audio.newSource("assets/sounds/bubble1.mp3", "static")
	bubble[2] = love.audio.newSource("assets/sounds/bubble2.mp3", "static")
	bubble[3] = love.audio.newSource("assets/sounds/bubble3.mp3", "static")


	-- Gamestate control from humplib
	Gamestate.registerEvents()
	Gamestate.switch(Mainmenu)
end

function love.quit()
	SaveSettings()
end
