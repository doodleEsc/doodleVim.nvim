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
            local langs = {
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
                "solidity"
            }
            local update = require("nvim-treesitter.install").update { with_sync = true }
            local ok, _ = pcall(update, langs)
            if not ok then
                vim.notify("TSUpdate Failed...")
            end
        end)
    end,
    config = conf.treesitter
}

ui['norcalli/nvim-colorizer.lua'] = {
    ft = { "lua", "vim", "markdown" },
    config = function() require('colorizer').setup() end
}

ui['kyazdani42/nvim-web-devicons'] = {}

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
