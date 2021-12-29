local ui = require("plugins.ui.config")
local tools = require("plugins.tools.config")
local completion = require("plugins.completion.config")
local editor = require("plugins.editor.config")
local debug = require("plugins.debug.config")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- COMPLETION {
	-- coc.nvim
  	use {'neoclide/coc.nvim', branch = 'release', event = 'BufReadPre'}
	-- use {'honza/vim-snippets', after='coc.nvim'}
	use {'rafamadriz/friendly-snippets', after = 'coc.nvim'}

  -- DEBUG {
  	-- nvim-dap
	use {'mfussenegger/nvim-dap', opt = true, config = debug.dap}
	use {'rcarriga/nvim-dap-ui', after = "nvim-dap", config = debug.dapui}
	use {'theHamsta/nvim-dap-virtual-text',
		after = "nvim-dap",
		config = function() vim.g.dap_virtual_text = true end
	}
  -- }

	-- treesitter
	use {'nvim-treesitter/nvim-treesitter', event = 'BufRead', config = ui.treesitter}
	use {'p00f/nvim-ts-rainbow', after = 'nvim-treesitter'}

	-- statusline
	-- use {'glepnir/galaxyline.nvim', branch = 'main', config = ui.galaxyline, requires = {'kyazdani42/nvim-web-devicons'}}
	use {'nvim-lualine/lualine.nvim', config = ui.lualine, requires = {'kyazdani42/nvim-web-devicons', opt = true}}

	-- colorizer
	use {'norcalli/nvim-colorizer.lua', ft={"lua", "vim", "markdown"}, config = function() require('colorizer').setup() end}
	use {"cinuor/gruvbox.nvim", opt=true,requires = {"rktjmp/lush.nvim", opt=true}}

	-- tabline
	use {'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'},
		config = ui.barbar,
		setup = function() require("core.utils").packer_defer_load("barbar.nvim", 1000) end
	}

  -- }

  -- EDITOR {

	use {'tyru/caw.vim', keys={'n','<Leader>c'}, config = editor.caw}

	use {'easymotion/vim-easymotion', keys={"n","<Leader>s"}, config = editor.easymotion}

	use {'junegunn/vim-easy-align', keys={{"n","ma"},{"x","ma"}}, config=editor.easyalign}

  -- }

  -- TOOLS {
  	-- startuptime
  	use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

	-- telescope
	use {'nvim-telescope/telescope.nvim', opt = true,
		setup = function() require("core.utils").packer_defer_load("telescope.nvim", 500) end,
		config = tools.telescope,
		requires = {
			{'nvim-lua/popup.nvim', opt = true},
			{'nvim-lua/plenary.nvim',opt = true},
			{'nvim-telescope/telescope-fzy-native.nvim', opt = true},
			{'fannheyward/telescope-coc.nvim',  opt = true},
			{'folke/todo-comments.nvim', opt = true, config = editor.todo},
		},
	}

	-- nvim-tree
	use {'kyazdani42/nvim-tree.lua',
		cmd = "NvimTreeToggle",
		config = tools.nvim_tree,
		requires = 'kyazdani42/nvim-web-devicons'
	}

	-- vista
	use {'liuchengxu/vista.vim', cmd = 'Vista', config = tools.vista}

	-- markdown-preview
	use {'iamcco/markdown-preview.nvim', ft = 'markdown', run = function() vim.cmd [[:call mkdp#util#install()]] end, config = tools.mkdp}

	-- translator
	use {'voldikss/vim-translator', cmd = {'TranslateW'}}

	-- floaterm
	-- use {'voldikss/vim-floaterm', cmd = {'FloatermToggle', 'FloatermNew'}, config = tools.floaterm}
	use {'cinuor/FTerm.nvim', cmd = {'FTermToggle'}, config = tools.fterm}

	-- vim ascii draw
	use {'jbyuki/venn.nvim', cmd = {'VBox', 'VFill'}}

	-- cheat.sh
	use {'RishabhRD/nvim-cheat.sh', cmd = {'Cheat', 'CheatList', 'CheatWithoutComments', 'CheatListWithoutComments'}}
	use {'RishabhRD/popfix', after = 'nvim-cheat.sh'}

	-- vim-solidity
	use {'TovarishFin/vim-solidity', ft = 'solidity'}

	-- speed up
	use {'lewis6991/impatient.nvim'}

  -- }
end)
