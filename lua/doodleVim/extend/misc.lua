local utils = require("doodleVim.utils.utils")

local misc = {}
misc.which_key_loaded = false
misc.barbecue_shown = false

misc.toggle_barbecue = function()
	if not misc.barbecue_shown then
		require("barbecue.ui").toggle(true)
		misc.barbecue_shown = true
	else
		require("barbecue.ui").toggle(false)
		misc.barbecue_shown = false
	end
end

misc.safe_exit = function()
	-- close floaterm
	if require("lazy.core.config").plugins["vim-floaterm"]._.loaded then
		local floatermBufnr = vim.call("floaterm#buflist#gather")
		if #floatermBufnr ~= 0 then
			vim.cmd([[FloatermKill]])
		end
	end

	-- close nvim-tree
	if require("lazy.core.config").plugins["nvim-tree.lua"]._.loaded then
		local view = require("nvim-tree.view")
		if view.is_visible() then
			require("doodleVim.extend.tree").toggle()
		end
	end

	-- quit
	vim.cmd([[confirm qa]])
end

misc.safe_save = function()
	vim.cmd([[write]])
	require("auto-session").SaveSession()
	vim.notify("Current Session Saved")
end

misc.wrapped_notify = function(message, level, o)
	if message:match("NULL_LS_CODE_ACTION", 1) then
		return
	end
	local wrapped_msg = require("doodleVim.utils.utils").wrap(message, 52)
	require("notify")(wrapped_msg, level, o)
end

misc.toggle_nu = function()
	vim.cmd([[:set nornu]])
	if vim.wo.nu then
		vim.cmd([[:set nonu]])
	else
		vim.cmd([[:set nu]])
	end
end

misc.toggle_rnu = function()
	vim.cmd([[:set nonu]])
	if vim.wo.rnu then
		vim.cmd([[:set nornu]])
	else
		vim.cmd([[:set rnu]])
	end
end

misc.reload = function()
	utils.remove_cached_package("^doodleVim")
	require("doodleVim.core")
	vim.notify("Configuration Reloaded")
end

misc.toggle_whichkey = function()
	local mode = vim.api.nvim_get_mode()
	if misc.which_key_loaded then
		require("which-key.view").on_close()
		misc.which_key_loaded = false
	else
		if mode.mode == "V" or mode.mode == "\22" then
			mode.mode = "v"
		end
		require("which-key").show("", mode)
		misc.which_key_loaded = true
	end
end

misc.treesitter_install_all = function()
	local status, _ = pcall(require, "nvim-treesitter")
	if status then
		local vendor = {
			"bash",
			"cmake",
			"comment",
			"c",
			"cpp",
			"dot",
			"dockerfile",
			"go",
			"gosum",
			"gomod",
			"gowork",
			"json",
			"html",
			"lua",
			"make",
			"python",
			"regex",
			"rust",
			"toml",
			"vim",
			"yaml",
			"solidity",
			"markdown",
			"org",
			"java",
		}
		local langs = {}
		local utils = require("doodleVim.utils.utils")
		for _, lang in ipairs(vendor) do
			if not utils.ts_is_installed(lang) then
				table.insert(langs, lang)
			end
		end
		if #langs > 0 then
			local update = require("nvim-treesitter.install").update({ with_sync = true })
			local ok, _ = pcall(update, langs)
			if not ok then
				vim.notify("TSUpdate Failed...")
			end
		end
	end
end

misc.lsp_install_all = function()
	-- local binaries = {
	-- 	"gopls",
	-- 	"json-lsp",
	-- 	"lua-language-server",
	-- 	"python-lsp-server",
	-- 	"delve",
	-- 	"gotests",
	-- 	"gomodifytags",
	-- 	"impl",
	-- 	"clangd",
	-- 	"debugpy",
	-- 	"ruff",
	-- 	-- "solhint",
	-- 	"jdtls",
	-- 	"java-debug-adapter",
	-- 	"java-test",
	-- 	"xmlformatter",
	-- 	"docker-compose-language-service",
	-- 	"dockerfile-language-server",
	-- }
	-- local register = require("mason-registry")
	-- local bins = ""
	-- for _, bin in ipairs(binaries) do
	-- 	if not register.is_installed(bin) then
	-- 		bins = bins .. " " .. bin
	-- 	end
	-- end
	-- if #bins > 0 then
	-- 	vim.cmd("MasonInstall" .. bins)
	-- end
	--
	-- -- local trim = require("doodleVim.utils.utils").trim
	-- local jdtls_path = require("mason-core.path").package_prefix("jdtls")
	-- local lombok_jar = jdtls_path .. "/plugins/" .. "lombok.jar"
	--
	-- -- check lombok and install
	-- if not vim.loop.fs_stat(lombok_jar) then
	-- 	vim.schedule(function()
	-- 		vim.fn.system({
	-- 			"wget",
	-- 			"https://projectlombok.org/downloads/lombok.jar",
	-- 			"-O",
	-- 			lombok_jar,
	-- 		})
	-- 		vim.fn.system({
	-- 			"chmod",
	-- 			"755",
	-- 			lombok_jar,
	-- 		})
	-- 	end)
	-- end
	--
	require("doodleVim.modules.lsp.setup").mason()
end

return misc
