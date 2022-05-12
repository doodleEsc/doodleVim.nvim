local config = {}

function config.lualine()
  require('doodleVim.modules.ui.lualine_config')
end

function config.treesitter()
  require('doodleVim.utils.defer').load_immediately('nvim-treesitter-textobjects')
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      "bash",
      "cmake",
      "comment",
      "c",
      "cpp",
      "dot",
      "dockerfile",
      "go",
      "gomod",
      "gowork",
      "hjson",
      "html",
      "lua",
      "make",
      "python",
      "regex",
      "rust",
      "toml",
      "vim",
      "yaml",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["as"] = "@statement.outer",
        ["ah"] = "@call.outer",
        ["ih"] = "@call.inner",
        },
      },
    }
  }
end

function config.blankline()
  require("indent_blankline").setup {
    show_end_of_line = true,
  }
end

function config.gitsigns()
  require('gitsigns').setup{
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '▐', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 2000,
      follow_files = true
    },
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 200,
      ignore_whitespace = false,
    },
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
  },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  }
end

function config.alpha()
  require("doodleVim.modules.ui.alpha")
end

return config
