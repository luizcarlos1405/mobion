-- require all the stuff
require("src/game")
require("src/triangle")
require("src/square")
require("src/controls")
require("src/colisions")
require("src/particles")
require("src/map")
require("enemies/virus")
require("src/gameover")
require("src/mainmenu")
require("src/optionsmenu")
require("src/shipmenu")
require("src/camera")
require("src/loadscreen")
push      = require("src/push")
Gamestate = require "src/humplib/gamestate"

-- Defining some global variables
Settings                  = {}
Width, Height             = 1920, 1080
screenWidth, screenHeight = love.window.getDesktopDimensions()

function love.load()
	-- Save game stuff
	savedir    = love.filesystem.getSaveDirectory()
	savefile   = "save.lua"
	love.audio.setVolume(0.2)

	-- Load Settings if they already exists, if don't load the standard
	if love.filesystem.exists(savefile) then
		LoadSettings()
		LoadedFrom = "save.lua"
	else
		Settings = require("stdsettings")
		LoadedFrom = "stdsettings.lua"

		-- love.filesystem.write(savefile, '')
		-- Settings.text           = {}
		-- Settings.volume         = {}
		-- Settings.controls       = "A"
		-- Settings.language       = {English, Portuguese, Current = "English"}
		--
		-- Settings.language.Portuguese              = {}
		-- Settings.language.Portuguese.Mainmenu     = {Play = "Jogar", Options = "Opções", Exit = "Sair"}
		-- Settings.language.Portuguese.Optionsmenu  = {Title = "Opções", Language = "Idioma", Controls = "Controles", TurnMode = "Modo de Giro", Save = "Salvar", Cancel = "Cancelar"}
		-- Settings.language.Portuguese.Game         = {}
		--
		-- Settings.language.English                 = {}
		-- Settings.language.English.Mainmenu        = {Play = "Play", Options = "Options", Exit = "Exit"}
		-- Settings.language.English.Optionsmenu     = {Title = "Settings", Language = "Language", Controls = "Controls", TurnMode = "Turn Mode", Save = "Save", Cancel = "Cancel"}
		-- Settings.language.English.Game            = {}
		--
		-- Settings.volume.effects = 1
		-- Settings.volume.music   = 1
		--
		-- Settings.text = Settings.language.English
		--
		-- SaveSettings()
	end

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
