local completion = {}
local conf = require("doodleVim.modules.completion.config")

completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("nvim-cmp", 50)
    end,
    requires = {
        { "hrsh7th/cmp-nvim-lsp", opt = true },
        { "saadparwaiz1/cmp_luasnip", opt = true },
        { "hrsh7th/cmp-buffer", opt = true },
        { "hrsh7th/cmp-path", opt = true },
        { "octaltree/cmp-look", opt = true },
        { "hrsh7th/cmp-cmdline", opt = true },
        { "ray-x/cmp-treesitter", opt = true },
        { "lukas-reineke/cmp-under-comparator", opt = true },
        { "windwp/nvim-autopairs", opt = true },
        { "L3MON4D3/LuaSnip", opt = true, config = conf.luasnip },
        { "danymat/neogen", opt = true, config = conf.neogen }
    },
    config = conf.nvim_cmp
}

completion['kylechui/nvim-surround'] = {
    after = "nvim-cmp",
    config = conf.nvim_surround
}

completion["williamboman/mason-lspconfig.nvim"] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("mason-lspconfig.nvim", 60)
    end,
    requires = {
        { "neovim/nvim-lspconfig", opt = true },
        { "ray-x/lsp_signature.nvim", opt = true },
        { "tamago324/nlsp-settings.nvim", opt = true, config = conf.nlsp_settings },
        {
            "williamboman/mason.nvim",
            opt = true,
            setup = function()
                require("doodleVim.extend.packer").add("mason", function()
                    require("doodleVim.utils.defer").immediate_load("mason.nvim")
                    local binaries = {
                        "gopls",
                        "json-lsp",
                        "lua-language-server",
                        "python-lsp-server",
                        "debugpy",
                        "ruff",
                        "delve",
                        "gotests",
                        "gomodifytags",
                        "clangd",
                        "impl"
                    }
                    local register = require("mason-registry")
                    local bins = ""
                    for _, bin in ipairs(binaries) do
                        if not register.is_installed(bin) then
                            bins = bins .. " " .. bin
                        end
                    end
                    if #bins > 0 then
                        vim.cmd("MasonInstall" .. bins)
                    end
                end)
            end,
            config = conf.mason
        }
    },
    config = conf.mason_lspconfig,
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("null-ls.nvim", 50)
    end,
    requires = {
        { "doodleEsc/gotools.nvim", opt = true, config = conf.gotools },
    },
    config = conf.null_ls,
}

completion["doodleEsc/lightbulb.nvim"] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("lightbulb.nvim", 40)
    end,
    config = conf.lightbulb,
}

completion["doodleEsc/rename.nvim"] = {
    opt = true,
    setup = function()
        require("doodleVim.utils.defer").add("rename.nvim", 40)
    end,
}

completion["doodleEsc/friendly-snippets"] = {
    opt = true,
}

return completion
