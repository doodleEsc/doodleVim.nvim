local jdtls = {}
local trim = require("doodleVim.utils.utils").trim

function jdtls.get_config()
	local mason_registry = require("mason-registry")
	-- local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"

	-- get bundles
	local bundles = {}
	if mason_registry.is_installed("java-debug-adapter") then
		local java_debug_home = require("mason-core.path").package_prefix("java-debug-adapter")
		vim.notify(java_debug_home)
		local java_debug_jar_path = trim(vim.fn.system({
			"find",
			java_debug_home .. "/extension/server",
			"-name",
			"com.microsoft.java.debug.plugin-*.jar",
		}))

		vim.notify(java_debug_jar_path)
		table.insert(bundles, vim.fn.glob(java_debug_jar_path, 1))
	end

	vim.notify(vim.inspect(bundles))

	-- if mason_registry.is_installed("java-test") then
	-- 	local java_test_home = require("mason-core.path").package_prefix("java-test")
	-- 	vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_home .. "/extension/server/*.jar", 1), "\n"))
	-- end

	-- get project workspace
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace = vim.env.HOME .. "/.cache/jdtls/workspace/" .. project_name

	-- update capabilities
	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	-- home
	local home = os.getenv("HOME")

	local config = {
		-- name = "jdtls",
		-- filetypes = { "java" },
		flags = {
			allow_incremental_sync = true,
		},
		capabilities = {
			workspace = {
				configuration = true,
			},
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = true,
					},
				},
			},
		},

		root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

		init_options = {
			bundles = bundles,
			extendedClientCapabilities = extendedClientCapabilities,
		},
		cmd = { home .. "/.config/nvim/bin/java_lsp.sh", workspace },
	}

	config.settings = {
		-- ['java.format.settings.url'] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
		-- ['java.format.settings.profile'] = "GoogleStyle",
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
			-- configuration = {
			-- 	runtimes = {
			-- 		{
			-- 			name = "JavaSE",
			-- 			path = home .. "/.sdkman/candidates/java/current/",
			-- 		},
			-- 	},
			-- },
		},
	}

	config.on_init = function(client, _)
		client.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end

	-- setup handler
	config.handlers = {}
	local function configuration_handler(err, result, ctx, config)
		local client_id = ctx.client_id
		local bufnr = 0
		local client = vim.lsp.get_client_by_id(client_id)
		if client then
			-- This isn't done in start_or_attach because a user could use a plugin like editorconfig to configure tabsize/spaces
			-- That plugin may run after `start_or_attach` which is why we defer the setting lookup.
			-- This ensures the language-server will use the latest version of the options
			client.config.settings = vim.tbl_deep_extend("keep", client.config.settings or {}, {
				java = {
					format = {
						insertSpaces = vim.api.nvim_buf_get_option(bufnr, "expandtab"),
						tabSize = vim.lsp.util.get_effective_tabstop(bufnr),
					},
				},
			})
		end
		return vim.lsp.handlers["workspace/configuration"](err, result, ctx, config)
	end

	local status_callback = function(_, result)
		vim.api.nvim_command(
			string.format(':echohl Function | echo "%s" | echohl None', string.sub(result.message, 1, vim.v.echospace))
		)
	end
	config.handlers["language/status"] = status_callback
	config.handlers["workspace/configuration"] = configuration_handler

	-- setup capabilities
	local capabilities =
		vim.tbl_deep_extend("keep", config.capabilities or {}, vim.lsp.protocol.make_client_capabilities())
	local extra_capabilities = {
		textDocument = {
			codeAction = {
				codeActionLiteralSupport = {
					codeActionKind = {
						valueSet = {
							"source.generate.toString",
							"source.generate.hashCodeEquals",
							"source.organizeImports",
						},
					},
				},
			},
		},
	}
	config.capabilities = vim.tbl_deep_extend("keep", capabilities, extra_capabilities)

	config.on_attach = function(client, bufnr)
		require("jdtls.setup").add_commands()
		require("jdtls").setup_dap({
			hotcodereplace = "auto",
		})
		require("jdtls.dap").setup_dap_main_class_configs({
			on_ready = function()
				local dap = require("dap")
				for _, java_config in pairs(dap.configurations.java) do
					java_config.console = "internalConsole"
				end
			end,
		})

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- java keymap
		local opts = { noremap = true, silent = true }
		buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
		-- buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
		-- buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
		buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
		buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
		buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
	end

	return config
end

return jdtls
