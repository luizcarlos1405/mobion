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
	push:setBorderColor{love.graphics.getBackgroundColor()}

	-- Save game stuff
	savedir  = love.filesystem.getSaveDirectory()
	savefile = savedir.."/mobion.savegame"

	-- Font load
	ecran        = love.graphics.newFont("fonts/ecran-monochrome.ttf", 12)
	ecranbig     = love.graphics.newFont("fonts/ecran-monochrome.ttf", 60)
	ecranbigger  = love.graphics.newFont("fonts/ecran-monochrome.ttf", 80)

	-- Load settings if they already exists, if don't just create the standard
	if love.filesystem.exists("mobion.savegame") then
		LoadSettings()
	else
		love.filesystem.write("mobion.savegame", '')
		settings.gametime      = 0
		settings.MusicVolume   = 1
		settings.EffectsVolume = 1
		settings.controls      = "RotationAtLeft"
		settings.language      = "Choose"
		settings.Portuguese    = {mainmenu    = {"Jogar", "Opções", "Sair"},
								  optionsmenu = {"Configurações", "Controle de giro", "Volume da música", "Volume dos efeitos", "Salvar", "Cancelar"}}

		settings.English       = {mainmenu    = {"Play", "Options", "Quit"},
								  optionsmenu = {"Settings", "Rotation control", "Music volume", "Save", "Effects volume", "Cancel"}}
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
-- Simple function that returns true or false for pressing some image
function PressedButton(touchx, touchy, imagex, imagey, imagew, imageh)
	if touchx >= imagex - imagew / 2 and touchx <= imagex + imagew / 2 and touchy >= imagey and touchy <= imagey + imageh then
		return true
	else
		return false
	end
end
