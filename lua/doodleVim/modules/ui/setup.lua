local ui = {}
local vim = vim

function ui.treesitter(plugin)
	require("doodleVim.extend.lazy").register_defer_load("DeferStartWithFile", 100, "nvim-treesitter.nvim", function()
		local ok, _ = pcall(require, "nvim-treesitter")
		if not ok then
			vim.notify("nvim-treesitter load failed", vim.log.levels.ERROR)
			return
		end
	end)

	require("doodleVim.extend.lazy").register_post_install("nvim-treesitter", function()
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
	end)
end

return ui
