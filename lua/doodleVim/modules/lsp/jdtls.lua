local jdtls = {}
local trim = require("doodleVim.utils.utils").trim

local function get_system()
    local os_name = vim.loop.os_uname().sysname
    local system = os_name == "Linux" and "linux" or os_name == "Windows" and "win" or "mac"
    return system
end

function jdtls.setup()
    -- get current system
    local system = get_system()
    -- get jdtls and config jar path
    local jdtls_home = require("mason-core.path").package_prefix("jdtls")
    local jdtls_jar_path = trim(vim.fn.system({
        "find", jdtls_home .. "/plugins", "-name", "org.eclipse.equinox.launcher_*.jar"
    }))
    local config_path = jdtls_home .. "/config_" .. system

    -- get bundles
    local java_debug_home = require("mason-core.path").package_prefix("java-debug-adapter")
    local java_test_home = require("mason-core.path").package_prefix("java-test")
    local java_debug_jar_path = trim(vim.fn.system({
        "find", java_debug_home .. "/extension/server", "-name", "com.microsoft.java.debug.plugin-*.jar"
    }))
    local bundles = {
        vim.fn.glob(java_debug_jar_path, 1),
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_home .. "/extension/server/*.jar", 1), "\n"))

    -- get project workspace
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace = vim.env.HOME .. "/.cache/jdtls/workspace/" .. project_name

    -- get lombok path
    local lombok_jar = trim(jdtls_home .. "/plugins/" .. "lombok.jar")
    local javaagent = "-javaagent:" .. lombok_jar
    local Xbootclasspath = "-Xbootclasspath/a:" .. lombok_jar

    -- update capabilities
    local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- home
    local home = os.getenv('HOME')

    local config = {
        flags = {
            allow_incremental_sync = true,
        },
        capabilities = {
            workspace = {
                configuration = true
            },
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = true
                    }
                }
            }
        },
        root_dir = require('jdtls.setup').find_root({ 'gradlew', 'pom.xml', '.git' }),
        init_options = {
            bundles = bundles,
            extendedClientCapabilities = extendedClientCapabilities
        },
        cmd = { home .. "/.config/nvim/bin/java_lsp.sh", workspace }
    }

    config.settings = {
        -- ['java.format.settings.url'] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
        -- ['java.format.settings.profile'] = "GoogleStyle",
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = home .. "/.sdkman/candidates/java/17.0.6-oracle/",
                    },
                }
            },
        },
    }

    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end

    config.on_attach = function(client, bufnr)
        require 'jdtls.setup'.add_commands()
        require('jdtls').setup_dap({
            hotcodereplace = 'auto',
        })
        require('jdtls.dap').setup_dap_main_class_configs({
            on_ready = function()
                local dap = require("dap")
                for _, java_config in pairs(dap.configurations.java) do
                    java_config.console = 'internalConsole'
                end
            end
        })
    end


    local finders = require 'telescope.finders'
    local sorters = require 'telescope.sorters'
    local actions = require 'telescope.actions'
    local pickers = require 'telescope.pickers'
    require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
        local opts = {}
        pickers.new(opts, {
            prompt_title    = prompt,
            finder          = finders.new_table {
                results = items,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = label_fn(entry),
                        ordinal = label_fn(entry),
                    }
                end,
            },
            sorter          = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                actions.goto_file_selection_edit:replace(function()
                    local selection = actions.get_selected_entry(prompt_bufnr)
                    actions.close(prompt_bufnr)

                    cb(selection.value)
                end)

                return true
            end,
        }):find()
    end


    require('jdtls').start_or_attach(config)
end

return jdtls
