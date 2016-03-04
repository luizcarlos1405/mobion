require("src/players")
require("src/controls")
require("src/enemies")
require("src/colisions")
require("src/particles")
require("src/mainmenu")
require("src/game")
require("src/optionsmenu")
require("src/tabletofile")
push = require("src/push")
Gamestate = require "src/humplib/gamestate"

-- Defining some global variables
settings              = {}
Width, Height         = 1280, 720
gameWidth, gameHeight = love.window.getDesktopDimensions()
function love.load()
	-- Screen scaling
	push:setupScreen(Width, Height, gameWidth, gameHeight, {fullscreen = true, resizable = false})

	-- Save game stuff
	folder   = love.filesystem.getIdentity()
	savedir  = love.filesystem.getSaveDirectory()
	savefile = savedir.."/save.game"

	-- Load settings if they already exists, if don't just create the standard
	if love.filesystem.exists("save.game") then
		LoadSettings()
	else
		love.filesystem.write("save.game", '')
		settings.gametime      = 0
		settings.MusicVolume   = 1
		settings.EffectsVolume = 1
		settings.controls      = "RotationAtLeft"
		settings.language      = "Choose"

		SaveSettings()
	end

	-- Gamestate control from humplib
    Gamestate.registerEvents()
    Gamestate.switch(mainmenu)
end
-- Simple function for saveing the settings
function SaveSettings()
	table.save(settings, savefile)
end
-- Simple function for loading the settings
function LoadSettings()
	settings = table.load(savefile)
end
