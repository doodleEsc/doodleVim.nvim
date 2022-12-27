local completion = {}
local conf = require("doodleVim.modules.completion.config")

-- COMPLETION
completion["hrsh7th/nvim-cmp"] = {
    -- lazy = true,
    -- init = function()
    --     require("doodleVim.utils.defer").add("nvim-cmp", 50)
    -- end,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-path",
        "octaltree/cmp-look",
        "hrsh7th/cmp-cmdline",
        "ray-x/cmp-treesitter",
        "lukas-reineke/cmp-under-comparator",
        "doodleEsc/friendly-snippets",
        { "danymat/neogen", config = conf.neogen },
        { "L3MON4D3/LuaSnip", config = conf.luasnip },

    },
    config = conf.nvim_cmp,
}

-- completion["hrsh7th/cmp-nvim-lsp"] = {
--     after = "nvim-cmp",
-- }

-- completion["saadparwaiz1/cmp_luasnip"] = {
--     after = "nvim-cmp",
-- }

-- completion["hrsh7th/cmp-buffer"] = {
--     after = "nvim-cmp",
-- }

-- completion["hrsh7th/cmp-path"] = {
--     after = "nvim-cmp",
-- }

-- completion["tzachar/cmp-tabnine"] = {
--     after = "nvim-cmp",
--     run = "./install.sh",
-- }

-- completion["octaltree/cmp-look"] = {
--     after = "nvim-cmp",
-- }

-- completion["hrsh7th/cmp-cmdline"] = {
--     after = "nvim-cmp",
-- }

-- completion["ray-x/cmp-treesitter"] = {
--     after = "nvim-cmp",
-- }

-- completion["lukas-reineke/cmp-under-comparator"] = {
--     lazy = true,
-- }

-- completion["L3MON4D3/LuaSnip"] = {
--     after = "nvim-cmp",
--     config = conf.luasnip,
-- }

-- completion["doodleEsc/friendly-snippets"] = {
--     lazy = true,
-- }

completion["neovim/nvim-lspconfig"] = {
    -- lazy = true,
    -- init = function()
    --     require("doodleVim.utils.defer").add("nvim-lspconfig", 100)
    -- end
}

completion["ray-x/lsp_signature.nvim"] = {
    dependencies = {
        "nvim-lspconfig"
    },
}

completion["tamago324/nlsp-settings.nvim"] = {
    dependencies = {
        "nvim-lspconfig"
    },
    config = conf.nlsp_settings,
}

completion["williamboman/mason.nvim"] = {
    -- lazy = true,
    init = function()
        -- require("doodleVim.utils.defer").add("mason", 50)
        require("doodleVim.extend.packer").add("mason", function()
            -- require("doodleVim.utils.defer").immediate_load("mason.nvim")
            local binaries = { "gopls", "json-lsp", "lua-language-server", "python-lsp-server", "delve",
                "gotests", "gomodifytags", "impl" }
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
    config = conf.mason,
}

completion["williamboman/mason-lspconfig.nvim"] = {
    lazy = true,
    after = {
        "mason.nvim",
        "nvim-lspconfig",
        "nlsp-settings.nvim",
        "lsp_signature.nvim"
    },
    config = conf.mason_lspconfig,
}

completion["doodleEsc/lightbulb.nvim"] = {
    after = "mason-lspconfig.nvim",
    config = conf.lightbulb,
}

-- completion["doodleEsc/gotools.nvim"] = {
--     lazy = true,
--     init = function()
--         require("doodleVim.utils.defer").add("gotools", 50)
--     end,
--     dependencies = { "mason-lspconfig.nvim", "nui.nvim" },
--     config = conf.gotools
-- }

completion["jose-elias-alvarez/null-ls.nvim"] = {
    dependencies = {
        "mason-lspconfig.nvim",
        { "doodleEsc/gotools.nvim", config = conf.gotools }
    },
    config = conf.null_ls,
}

-- completion["danymat/neogen"] = {
--     after = { "nvim-cmp", "LuaSnip" },
--     config = conf.neogen,
-- }

completion["doodleEsc/rename.nvim"] = {
    -- lazy = true,
    -- init = function()
    --     require("doodleVim.utils.defer").add("rename", 50)
    -- end,
    dependencies = {
        "nvim-lspconfig",
        "nui.nvim"
    },
}

return completion
