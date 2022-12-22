local ui = {}
local conf = require("doodleVim.modules.ui.config")

ui['nvim-treesitter/nvim-treesitter'] = {
    opt = true,
    requires = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', opt = true },
    },
    setup = function()
        require("doodleVim.utils.defer").add("nvim-treesitter", 100)
        require("doodleVim.extend.packer").add("nvim-treesitter", function()
            require("doodleVim.utils.defer").immediate_load("nvim-treesitter")
            local vendor = {
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
                "norg",
                "norg_meta",
            }

            -- HACK: add norg and norg_meta parser_info to nvim-treesitter
            local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
            parser_configs.norg = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg",
                    files = { "src/parser.c", "src/scanner.cc" },
                    branch = "main",
                    revision = "5d9c76b5c9927955f7c5d5d946397584e307f69f",
                }
            }

            parser_configs.norg_meta = {
                install_info = {
                    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
                    files = { "src/parser.c" },
                    branch = "main",
                    revision = "e93dcbc56a472649547cfc288f10ae4a93ef8795",
                }
            }

            local langs = {}
            local utils = require("doodleVim.utils.utils")
            for _, lang in ipairs(vendor) do
                if not utils.ts_is_installed(lang) then
                    table.insert(langs, lang)
                end
            end
            if #langs > 0 then
                local update = require("nvim-treesitter.install").update { with_sync = true }
                local ok, _ = pcall(update, langs)
                if not ok then
                    vim.notify("TSUpdate Failed...")
                end
            end
        end)
    end,
    config = conf.treesitter
}

ui['norcalli/nvim-colorizer.lua'] = {
    ft = { "lua", "vim", "markdown" },
    config = function() require('colorizer').setup() end
}

ui['nvim-tree/nvim-web-devicons'] = {}

ui['nvim-lualine/lualine.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("lualine.nvim", 99) end,
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf.lualine,
}

ui['doodleEsc/gruvbox.nvim'] = {
    opt = true
}

ui['MunifTanjim/nui.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("nui.nvim", 99) end,
    config = conf.nui
}

ui['goolord/alpha-nvim'] = {
    config = conf.alpha
}

return ui
