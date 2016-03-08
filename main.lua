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
Width, Height         = 1920, 1080
screenWidth, screenHeight = love.window.getDesktopDimensions()

function love.load()
	-- Screen scaling
	push:setupScreen(Width, Height, screenWidth, screenHeight, {fullscreen = true, resizable = false})
	push:setBorderColor{love.graphics.getBackgroundColor()}

	-- Save game stuff
	savedir  = love.filesystem.getSaveDirectory()
	savefile = savedir.."/mobion.savegame"

	-- Font load
	ecran        = love.graphics.newFont("fonts/ecran-monochrome.ttf", 24)
	ecranbig     = love.graphics.newFont("fonts/ecran-monochrome.ttf", 80)
	ecranbigger  = love.graphics.newFont("fonts/ecran-monochrome.ttf", 120)

	-- Load settings if they already exists, if don't just create the standard
	-- if love.filesystem.exists("mobion.savegame") then
	-- 	LoadSettings()
	-- else
		love.filesystem.write("mobion.savegame", '')
		settings.gametime      = 0
		settings.MusicVolume   = 1
		settings.EffectsVolume = 1
		settings.controls      = "RotationAtLeft"
		settings.language      = "Choose"
		settings.Portuguese    = {mainmenu    = {"Jogar", "Opções", "Sair"},
								  optionsmenu = {"Configurações", "Idioma", "Controle de giro", "Volume da música", "Volume dos efeitos", "Salvar", "Cancelar"}}

		settings.English       = {mainmenu    = {"Play", "Options", "Quit"},
								  optionsmenu = {"Settings", "Language", "Rotation control", "Music volume", "Save", "Effects volume", "Cancel"}}
		SaveSettings()
	-- end

	-- Gamestate control from humplib
    Gamestate.registerEvents()
    Gamestate.switch(mainmenu)
end
-- Simple function for saving the settings
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
