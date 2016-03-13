-- require all the stuff
require("src/game")
require("src/player")
require("src/controls")
require("src/colisions")
require("src/particles")
require("src/tabletofile")
require("src/map")
require("enemies/virus")

local Mainmenu  = require("src/mainmenu")
local Optionsmenu = require("src/optionsmenu")

push      = require("src/push")
Gamestate = require "src/humplib/gamestate"
-- Camera    = require "src/humplib/camera"

-- Defining some global variables
Settings                  = {}
Width, Height             = 1920, 1080
screenWidth, screenHeight = love.window.getDesktopDimensions()

function love.load()
	-- Screen scaling
	push:setupScreen(Width, Height, screenWidth, screenHeight, {fullscreen = true, resizable = false})
	push:setBorderColor{love.graphics.getBackgroundColor()}

	-- Save Game stuff
	savedir  = love.filesystem.getSaveDirectory()
	savefile = savedir.."/stdsettings"

	-- Font load
	ecran        = love.graphics.newFont("fonts/ecran-monochrome.ttf", 24)
	ecranbig     = love.graphics.newFont("fonts/ecran-monochrome.ttf", 80)
	ecranbigger  = love.graphics.newFont("fonts/ecran-monochrome.ttf", 120)

	-- Load Settings if they already exists, if don't just create the standard
	-- if love.filesystem.exists("stdsettings") then
	-- 	LoadSettings()
	-- else
		love.filesystem.write("stdsettings", '')
		Settings.text           = {}
		Settings.volume         = {}
		Settings.controls       = "A"
		Settings.language       = "English"

		Portuguese              = {}
		Portuguese.Mainmenu     = {Play = "Jogar", Options = "Opções", Exit = "Sair"}
		Portuguese.Optionsmenu  = {Title = "Opções", Language = "Idioma", Controls = "Controles", TurnMode = "Modo de Giro", Save = "Salvar", Cancel = "Cancelar"}
		Portuguese.Game         = {}

		English                 = {}
		English.Mainmenu        = {Play = "Play", Options = "Options", Exit = "Exit"}
		English.Optionsmenu     = {Title = "Settings", Language = "Language", Controls = "Controls", TurnMode = "Turn Mode", Save = "Save", Cancel = "Cancel"}
		English.Game            = {}

		Settings.volume.effects = 1
		Settings.volume.music   = 1

		if Settings.language == "English" then
			Settings.text = English
		elseif Settings.language == "Português" then
			Settings.text = Portuguese
		end
		SaveSettings()
	-- end

	-- Gamestate control from humplib
    Gamestate.registerEvents()
    Gamestate.switch(Mainmenu)
end
-- Simple function for saving the Settings
function SaveSettings()
	table.save(Settings, savefile)
end
-- Simple function for loading the Settings
function LoadSettings()
	Settings = table.load(savefile)
end
-- Simple function that returns true or false for pressing some image
function PressedButton(touchx, touchy, imagex, imagey, imagew, imageh)
	if touchx >= imagex - imagew / 2 and touchx <= imagex + imagew / 2 and touchy >= imagey and touchy <= imagey + imageh then
		return true
	else
		return false
	end
end
