local global = {}
local home = os.getenv("HOME")
local path_sep = "/"
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.path_sep = path_sep
	self.home = home
	self.vim_path = vim.fn.stdpath("config")
	self.cache_dir = vim.fn.stdpath("cache")
	self.data_dir = vim.fn.stdpath("data")
	self.state_dir = vim.fn.stdpath("state")
end

global:load_variables()

return global
