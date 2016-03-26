require("src/tools")
ser = require("src/ser")

function love.conf(t)
	t.version = "0.10.1"
	t.window.title = "Mobion"

	-- Defining some global variables
	Settings       = {}
	Width, Height  = 1920, 1080

	-- Save Game stuff
	t.identity = "Mobion"
	savedir    = love.filesystem.getSaveDirectory()
	savefile   = "save.lua"

	-- Load Settings if they already exists, if don't just create the standard
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
end
