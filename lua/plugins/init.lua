local ui = require("plugins.ui.config")
local tools = require("plugins.tools.config")
local completion = require("plugins.completion.config")
local editor = require("plugins.editor.config")
local debug = require("plugins.debug.config")

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use { "bfredl/nvim-luadev" }

	-- COMPLETION
	use {'hrsh7th/nvim-cmp',
		opt = true,
		setup = function()
			require("utils.defer").packer_defer_load("nvim-cmp", 150)
		end,
		config = completion.nvim_cmp
	}
	use {'hrsh7th/cmp-nvim-lsp', after = "nvim-cmp"}
	use {'saadparwaiz1/cmp_luasnip', after = "nvim-cmp"}
	use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
	use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
	use {'tzachar/cmp-tabnine', after = 'nvim-cmp', run='./install.sh'}
	use {'L3MON4D3/LuaSnip', after = "nvim-cmp", config = completion.luasnip}
	use {'rafamadriz/friendly-snippets', opt = true}

  -- LSP AND COMPLETION {
	use {'neovim/nvim-lspconfig',
		after = "nvim-cmp",
	}
	use {"ray-x/lsp_signature.nvim",
		after = 'nvim-lspconfig',
	}
	use {'williamboman/nvim-lsp-installer',
		after={'nvim-lspconfig', 'lsp_signature.nvim'},
		config = completion.nvim_lsp_installer
	}

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
		setup = function() require("utils.defer").packer_defer_load("nvim-treesitter", 100) end,
		config = ui.treesitter,
		requires = {'nvim-treesitter/nvim-treesitter-textobjects', opt = true}
	}

	-- statusline
	use {'nvim-lualine/lualine.nvim',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("lualine.nvim", 100) end,
		requires = {'kyazdani42/nvim-web-devicons'},
		config = ui.lualine,
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
		setup = function()
			require("plugins.ui.config").barbar()
			require("utils.defer").add("barbar.nvim", 90)
		end,
		requires = {'kyazdani42/nvim-web-devicons'},
		-- config = ui.barbar
	}

	-- blankline
	use {'lukas-reineke/indent-blankline.nvim',
		opt = true,
		setup = function() require("utils.defer").add("indent-blankline.nvim", 90) end,
		config = ui.blankline,
	}
  -- }

  -- EDITOR {
	-- comment
	use {'numToStr/Comment.nvim',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("Comment.nvim", 1000) end,
		config = editor.comment,
	}

	-- cursor move
	use {'easymotion/vim-easymotion',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("vim-easymotion", 1000) end,
	}

	-- align format
	use {'andymass/vim-matchup',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("vim-matchup", 1000) end,
	}

	use {'junegunn/vim-easy-align',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("vim-easy-align", 1000) end,
	}

	-- smooth scroll
	use {'karb94/neoscroll.nvim',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("neoscroll.nvim", 1000) end,
		config = editor.neoscroll,
	}

	-- todo-comments
	use {'folke/todo-comments.nvim',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("todo-comments.nvim", 100) end,
		config = editor.todo
	}

	use {'windwp/nvim-autopairs',
		opt = true,
		setup = function() require("utils.defer").packer_defer_load("nvim-autopairs", 1000) end,
		config = editor.autopairs
	}

	use {"cinuor/lsp-action.nvim",
		after = "nvim-lspconfig",
		config = editor.lspaction
	}

  -- }

-- TOOLS {
	-- startuptime
	use {'dstein64/vim-startuptime', cmd = 'StartupTime'}

	-- telescope
	use {'nvim-telescope/telescope.nvim',
		opt = true,
		setup = function() require("utils.defer").add("telescope.nvim", 90) end,
		config = tools.telescope,
		requires = {
			{'nvim-telescope/telescope-fzy-native.nvim', opt = true},
			{'nvim-telescope/telescope-file-browser.nvim', opt = true},
		},
	}

	-- git stafff
	use {'lewis6991/gitsigns.nvim',
		opt = true,
		config = tools.gitsigns,
		requires = {'nvim-lua/plenary.nvim'},
		setup = function() require("utils.defer").add("gitsigns.nvim", 90) end,
	}

	-- nvim-tree
	use {'kyazdani42/nvim-tree.lua',
		opt = true,
		config = tools.nvim_tree,
		requires = 'kyazdani42/nvim-web-devicons'
	}

	-- vista
	use {'liuchengxu/vista.vim',
		opt = true,
		setup = function()
			require("plugins.tools.config").vista()
			require("utils.defer").packer_defer_load("vista.vim", 1000)
		end
	}

	-- markdown-preview
	use {'iamcco/markdown-preview.nvim',
		ft = 'markdown',
		setup = tools.mkdp,
		run = function() vim.cmd [[:call mkdp#util#install()]] end,
	}

	-- translator
	use {'voldikss/vim-translator', cmd = {'TranslateW'}}

	-- floaterm
	use {'voldikss/vim-floaterm',
		opt = true,
		setup = function()
			require("plugins.tools.config").floaterm()
			require("utils.defer").packer_defer_load("vim-floaterm", 1000)
		end,
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
