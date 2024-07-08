local ui = {}
local conf = require("doodleVim.modules.ui.config")
-- local setup = require("doodleVim.modules.ui.setup")
local lazy = require("doodleVim.extend.lazy")


ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	config = conf.alpha,
}




return ui
