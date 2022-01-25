local ui = require("plugins.ui.config")
local tools = require("plugins.tools.config")
local completion = require("plugins.completion.config")
local editor = require("plugins.editor.config")
local debug = require("plugins.debug.config")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- LSP AND COMPLETION {
	use {'neovim/nvim-lspconfig',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("nvim-lspconfig", 100) end,
		config = completion.lspconfig
	}
	use {'williamboman/nvim-lsp-installer', after='nvim-lspconfig'}
	use {'tami5/lspsaga.nvim', after='nvim-lspconfig'}

--	use {'L3MON4D3/LuaSnip', event = 'InsertEnter', after=''}
--	use {'onsails/lspkind-nvim', event = 'InsertEnter', config = completion.lspkind_nvim}
--	use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
--	use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
--	use {'tzachar/cmp-tabnine', after = 'nvim-cmp', run='./install.sh'}
--	use {'saadparwaiz1/cmp_luasnip', after='nvim-cmp'}
	use {'hrsh7th/cmp-nvim-lsp'}
	use {'hrsh7th/nvim-cmp', config = completion.nvim_cmp}

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
		event = "UIEnter",
		config = ui.lualine,
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
	use {'easymotion/vim-easymotion',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("vim-easymotion", 1500) end,
	}

	-- align format
	use {'andymass/vim-matchup',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("Comment.nvim", 100) end
	}

	use {'junegunn/vim-easy-align',
		opt = true,
		setup = function() require("core.utils").packer_defer_load("vim-easy-align", 1500) end,
	}

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

	-- todo-comments
	use {'folke/todo-comments.nvim', event = 'BufReadPost', config = editor.todo}

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

	-- git stafff
	use {'lewis6991/gitsigns.nvim',
		opt = true,
		config = tools.gitsigns,
		requires = {'nvim-lua/plenary.nvim'},
		setup = function() require("core.utils").packer_defer_load("gitsigns.nvim", 1000) end,
	}

	-- nvim-tree
	use {'kyazdani42/nvim-tree.lua',
		opt = true,
		config = tools.nvim_tree,
		requires = 'kyazdani42/nvim-web-devicons'
	}

	-- vista
	use {'liuchengxu/vista.vim', cmd = 'Vista', setup = tools.vista}

	-- markdown-preview
	use {'iamcco/markdown-preview.nvim', ft = 'markdown', run = function() vim.cmd [[:call mkdp#util#install()]] end, setup = tools.mkdp}

	-- translator
	use {'voldikss/vim-translator', cmd = {'TranslateW'}}

	-- floaterm
	use {'voldikss/vim-floaterm',
		opt = true,
		setup = tools.floaterm
	}

	-- vim ascii draw
	use {'jbyuki/venn.nvim', cmd = {'VBox', 'VFill'}}
	-- }

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
