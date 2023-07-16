local lsp = {}

function lsp.mason(plugin)
    require("doodleVim.extend.lazy").add("mason", function()
        local binaries = {
            "gopls",
            "json-lsp",
            "lua-language-server",
            "python-lsp-server",
            "delve",
            "gotests",
            "gomodifytags",
            "impl",
            "clangd",
            "debugpy",
            "ruff",
            "solhint",
            "jdtls",
            "java-debug-adapter",
            "java-test",
            "xmlformatter",
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

        -- local trim = require("doodleVim.utils.utils").trim
        local jdtls_path = require("mason-core.path").package_prefix("jdtls")
        local lombok_jar = jdtls_path .. "/plugins/" .. "lombok.jar"

        -- pylsp install dependencies;
        -- vim.cmd("PylspInstall python-lsp-black pyls-isort python-lsp-ruff pylsp-rope")

        -- check lombok and install
        if not vim.loop.fs_stat(lombok_jar) then
            vim.schedule(function()
                vim.fn.system({
                    "wget",
                    "https://projectlombok.org/downloads/lombok.jar",
                    "-O",
                    lombok_jar,
                })
                vim.fn.system({
                    "chmod",
                    "755",
                    lombok_jar,
                })
            end)
        end
    end)
end

function lsp.lsp_signature(plugin)
    require("doodleVim.extend.lsp").register_on_attach(function(client, bufnr)
        require("lsp_signature").on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            handler_opts = {
                border = "rounded",
            },
        }, bufnr)
    end)
end

return lsp
