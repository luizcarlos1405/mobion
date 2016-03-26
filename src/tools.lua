-- Simple function that returns true or false for pressing some image
function PressedButton(touchx, touchy, imagex, imagey, imagew, imageh)
	if touchx >= imagex - imagew / 2 and touchx <= imagex + imagew / 2 and touchy >= imagey and touchy <= imagey + imageh then
		return true
	else
		return false
	end
end
-- Simple function for saving the Settings
function SaveSettings()
	-- love.filesystem.remove(savefile)
	love.filesystem.write(savefile, ser(Settings))
end
-- Simple function for loading the Settings
function LoadSettings()
	Settings = require("save")
end
-- For changing states showing a loadscreen
function ChangeState(to)
	CurrentState = to
	Gamestate.switch(LoadScreen)
end
