local ui = require("plugins.ui.config")
local tools = require("plugins.tools.config")
local completion = require("plugins.completion.config")
local editor = require("plugins.editor.config")
local debug = require("plugins.debug.config")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- COMPLETION {
	-- coc.nvim
  	use {'neoclide/coc.nvim', branch = 'release', event = 'BufReadPost'}

	-- use {'honza/vim-snippets', after='coc.nvim'}
	use {'rafamadriz/friendly-snippets', event = "InsertEnter"}
	-- }

  -- DEBUG {
  	-- nvim-dap
	use {'mfussenegger/nvim-dap', opt = true, config = debug.dap}
	use {'rcarriga/nvim-dap-ui', after = "nvim-dap", config = debug.dapui}
	use {'theHamsta/nvim-dap-virtual-text',
		after = "nvim-dap",
		config = function() vim.g.dap_virtual_text = true end
	}
  -- }

  -- UI {
	-- treesitter
	use {'nvim-treesitter/nvim-treesitter',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("nvim-treesitter", 100) end,
		config = ui.treesitter,
		requires = {'nvim-treesitter/nvim-treesitter-textobjects', opt = true}
	}

	-- statusline
	use {'nvim-lualine/lualine.nvim',
		config = ui.lualine,
		event = "UIEnter",
		requires = {'kyazdani42/nvim-web-devicons'}
	}

	-- colorizer
	use {'norcalli/nvim-colorizer.lua',
		ft={"lua", "vim", "markdown"},
		config = function() require('colorizer').setup() end
	}

	-- colorschema
	use {"cinuor/gruvbox.nvim",opt=true}

	-- tabline
	use {'romgrk/barbar.nvim',
		opt = true,
		requires = {'kyazdani42/nvim-web-devicons'},
		setup = ui.barbar
	}
  -- }

  -- EDITOR {
	-- comment
	use {'numToStr/Comment.nvim', 
		opt = true,
		setup = function() require("core.utils").packer_defer_load("Comment.nvim", 100) end,
		config = editor.comment,
	}

	-- cursor move
	use {'easymotion/vim-easymotion', keys={"n","<Leader>s"}, config = editor.easymotion}

	-- align format
	use {'junegunn/vim-easy-align', keys={{"n","ma"},{"x","ma"}}, config=editor.easyalign}

	-- blankline
	use {'lukas-reineke/indent-blankline.nvim',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("indent-blankline.nvim", 100) end,
		config = editor.blankline,
	}

	-- smooth scroll
	use {'karb94/neoscroll.nvim',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("neoscroll.nvim", 100) end,
		config = editor.neoscroll,
	}
	
  -- }

  -- TOOLS {
  	-- startuptime
  	use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

	-- telescope
	use {'nvim-telescope/telescope.nvim',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("telescope.nvim", 1000) end,
		config = tools.telescope,
		requires = {
			{'nvim-telescope/telescope-fzy-native.nvim', opt = true},
			{'nvim-telescope/telescope-file-browser.nvim', opt = true},
			{'fannheyward/telescope-coc.nvim',  opt = true}
		},
	}

	-- todo-comments
	use {'folke/todo-comments.nvim', event = 'BufReadPost', config = editor.todo}

	-- git stafff
	use {'lewis6991/gitsigns.nvim',
		opt = true,
		config = tools.gitsigns,
		requires = {'nvim-lua/plenary.nvim'},
		setup = function() require("core.utils").packer_defer_load("gitsigns.nvim", 1000) end,
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
	use {'iamcco/markdown-preview.nvim', ft = 'markdown', run = function() vim.cmd [[:call mkdp#util#install()]] end, setup = tools.mkdp}

	-- translator
	use {'voldikss/vim-translator', cmd = {'TranslateW'}}

	-- floaterm
	use {'cinuor/FTerm.nvim', cmd = {'FTermToggle', 'FTermRun'}, config = tools.fterm}

	-- vim ascii draw
	use {'jbyuki/venn.nvim', cmd = {'VBox', 'VFill'}}

  -- Syntax {
	-- solidity
	use {'TovarishFin/vim-solidity', ft = 'solidity'}

	-- helm
	use {'towolf/vim-helm', ft='helm'}
	-- }

  -- Basic {
	-- cache plugins
	use {'lewis6991/impatient.nvim'}

	-- basic dependence
	use {'nvim-lua/plenary.nvim'}
  -- }
end)

