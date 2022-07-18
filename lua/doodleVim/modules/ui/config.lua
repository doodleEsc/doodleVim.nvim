local config = {}

function config.lualine()
    require('doodleVim.modules.ui.lualine_config')
end

function config.treesitter()
    require('doodleVim.utils.defer').immediate_load('nvim-treesitter-textobjects')
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
            "markdown"
        },
        sync_install = false,
        auto_install = true,
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
        },
    }
end

function config.alpha()
    require("doodleVim.modules.ui.alpha")
end

return config
