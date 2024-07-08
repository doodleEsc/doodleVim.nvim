local config = {}
local vim_path = require("doodleVim.core.global").vim_path

function config.lspconfig(plugin, opts)
	local handler = require("doodleVim.modules.lsp.handler")
	handler.lsp_hover()
	handler.lsp_diagnostic()
	handler.null_ls_depress()
	handler.lsp_highlight_document()

	local servers = opts.servers or {}
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities(),
		opts.capabilities or {}
	)

	local function setup(server)
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = vim.deepcopy(capabilities),
		}, servers[server] or {})

		if server_opts.disabled then
			return
		end

		if opts.setup then
			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
		end

		require("lspconfig")[server].setup(server_opts)
	end

	local mlsp = require("mason-lspconfig")
	local available = mlsp.get_available_servers()
	local ensure_installed = {} ---@type string[]
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(available, server) then
				setup(server)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end
	require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
	require("mason-lspconfig").setup_handlers({ setup })
end

function config.mason()
	require("mason").setup({
		ui = {
			check_outdated_packages_on_open = true,
			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = "rounded",
			icons = {
				-- The list icon to use for installed packages.
				package_installed = "◍",
				-- The list icon to use for packages that are installing, or queued for installation.
				package_pending = "◍",
				-- The list icon to use for packages that are not installed.
				package_uninstalled = "◍",
			},
			keymaps = {
				-- Keymap to expand a package
				toggle_package_expand = "<CR>",
				-- Keymap to install the package under the current cursor position
				install_package = "i",
				-- Keymap to reinstall/update the package under the current cursor position
				update_package = "u",
				-- Keymap to check for new version for the package under the current cursor position
				check_package_version = "c",
				-- Keymap to update all installed packages
				update_all_packages = "U",
				-- Keymap to check which installed packages are outdated
				check_outdated_packages = "C",
				-- Keymap to uninstall a package
				uninstall_package = "X",
				-- Keymap to cancel a package installation
				cancel_installation = "<C-c>",
				-- Keymap to apply language filter
				apply_language_filter = "<C-f>",
			},
		},
		-- The directory in which to install packages.
		install_root_dir = require("mason-core.path").concat({ vim.fn.stdpath("data"), "mason" }),
		PATH = "prepend",
		pip = {
			-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
			-- and is not recommended.
			--
			-- Example: { "--proxy", "https://proxyserver" }
			install_args = {},
		},
		-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
		-- debugging issues with package installations.
		log_level = vim.log.levels.INFO,
		-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
		-- packages that are requested to be installed will be put in a queue.
		max_concurrent_installers = 4,
		github = {
			-- The template URL to use when downloading assets from GitHub.
			-- The placeholders are the following (in order):
			-- 1. The repository (e.g. "rust-lang/rust-analyzer")
			-- 2. The release version (e.g. "v0.3.0")
			-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
			download_url_template = "https://github.com/%s/releases/download/%s/%s",
		},
		providers = {
			"mason.providers.registry-api",
		},
	})
end

function config.nlsp_settings()
	require("nlspsettings").setup({
		config_home = vim_path .. "/nlsp-settings",
		local_settings_dir = ".nlsp-settings",
		local_settings_root_markers = { ".git" },
		append_default_schemas = true,
		loader = "json",
	})
end

function config.gotools()
	require("gotools").setup({
		gotests = {
			bin = require("mason-core.path").bin_prefix() .. "/" .. "gotests",
			win_opts = {
				prompt = "Select An Action",
				kind = "gotools",
			},
		},
		gomodifytags = {
			bin = require("mason-core.path").bin_prefix() .. "/" .. "gomodifytags",
			skip_unexported = true,
			win_opts = {
				prompt = "Tags:",
			},
		},
		impl = {
			bin = require("mason-core.path").bin_prefix() .. "/" .. "impl",
			win_opts = {
				prompt = "Select An Action",
				kind = "gotools",
			},
		},
	})

	require("dressing.select.telescope").custom_kind["gotools"] = function(opts, defaults, items)
		local finders = require("telescope.finders")
		local make_indexed = function(items)
			local indexed_items = {}
			local widths = {
				idx = 0,
				command_title = 0,
			}
			for idx, item in ipairs(items) do
				local entry = {
					idx = idx,
					command_title = item,
					text = item,
				}
				table.insert(indexed_items, entry)
				widths.idx = math.max(widths.idx, require("plenary.strings").strdisplaywidth(entry.idx))
				widths.command_title =
					math.max(widths.command_title, require("plenary.strings").strdisplaywidth(entry.command_title))
			end
			return indexed_items, widths
		end

		local make_displayer = function(widths)
			return require("telescope.pickers.entry_display").create({
				separator = " ",
				items = {
					{ width = widths.idx + 1 }, -- +1 for ":" suffix
					{ width = widths.command_title },
				},
			})
		end
		local make_display_factory = function(displayer)
			return function(e)
				return displayer({
					{ e.value.idx .. ":", "TelescopePromptPrefix" },
					{ e.value.command_title },
				})
			end
		end

		local make_ordinal = function(e)
			return e.idx .. e.command_title
		end

		local indexed_items, widths = make_indexed(items)
		local displayer = make_displayer(widths)
		local make_display = make_display_factory(displayer)

		defaults.finder = finders.new_table({
			results = indexed_items,
			entry_maker = function(e)
				return {
					value = e,
					display = make_display,
					ordinal = make_ordinal(e),
				}
			end,
		})

		defaults.initial_mode = "normal"
	end
end

function config.null_ls()
	local null_ls = require("null-ls")

	null_ls.setup({
		cmd = { "nvim" },
		debounce = 250,
		debug = false,
		default_timeout = 5000,
		diagnostics_format = "#{m}",
		fallback_severity = vim.diagnostic.severity.ERROR,
		log = {
			enable = true,
			level = "warn",
			use_console = "async",
		},
		on_attach = nil,
		on_exit = nil,
		sources = {
			null_ls.builtins.code_actions.gitsigns,
			null_ls.builtins.code_actions.gomodifytags,
			null_ls.builtins.code_actions.impl,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.codespell,
			null_ls.builtins.diagnostics.spectral,
		},
		update_in_insert = false,
	})
end

function config.lightbulb()
	local codicons = require("codicons")

	vim.fn.sign_define("LightBulbSign", { text = codicons.get("lightbulb"), texthl = "GruvboxYellowSign" })

	require("nvim-lightbulb").setup({
		-- Priority of the lightbulb for all handlers except float.
		priority = 10,

		-- Whether or not to hide the lightbulb when the buffer is not focused.
		-- Only works if configured during NvimLightbulb.setup
		hide_in_unfocused_buffer = true,

		-- Whether or not to link the highlight groups automatically.
		-- Default highlight group links:
		--   LightBulbSign -> DiagnosticSignInfo
		--   LightBulbFloatWin -> DiagnosticFloatingInfo
		--   LightBulbVirtualText -> DiagnosticVirtualTextInfo
		--   LightBulbNumber -> DiagnosticSignInfo
		--   LightBulbLine -> CursorLine
		-- Only works if configured during NvimLightbulb.setup
		link_highlights = true,

		-- Perform full validation of configuration.
		-- Available options: "auto", "always", "never"
		--   "auto" only performs full validation in NvimLightbulb.setup.
		--   "always" performs full validation in NvimLightbulb.update_lightbulb as well.
		--   "never" disables config validation.
		validate_config = "auto",

		-- Code action kinds to observe.
		-- To match all code actions, set to `nil`.
		-- Otherwise, set to a table of kinds.
		-- Example: { "quickfix", "refactor.rewrite" }
		-- See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#codeActionKind
		action_kinds = nil,

		-- Configuration for various handlers:
		-- 1. Sign column.
		sign = {
			enabled = true,
			-- Text to show in the sign column.
			-- Must be between 1-2 characters.
			text = "💡",
			-- Highlight group to highlight the sign column text.
			hl = "LightBulbSign",
		},

		-- 2. Virtual text.
		virtual_text = {
			enabled = false,
			-- Text to show in the virt_text.
			text = "💡",
			-- Position of virtual text given to |nvim_buf_set_extmark|.
			-- Can be a number representing a fixed column (see `virt_text_pos`).
			-- Can be a string representing a position (see `virt_text_win_col`).
			pos = "eol",
			-- Highlight group to highlight the virtual text.
			hl = "LightBulbVirtualText",
			-- How to combine other highlights with text highlight.
			-- See `hl_mode` of |nvim_buf_set_extmark|.
			hl_mode = "combine",
		},

		-- 3. Floating window.
		float = {
			enabled = false,
			-- Text to show in the floating window.
			text = "💡",
			-- Highlight group to highlight the floating window.
			hl = "LightBulbFloatWin",
			-- Window options.
			-- See |vim.lsp.util.open_floating_preview| and |nvim_open_win|.
			-- Note that some options may be overridden by |open_floating_preview|.
			win_opts = {
				focusable = false,
			},
		},

		-- 4. Status text.
		-- When enabled, will allow using |NvimLightbulb.get_status_text|
		-- to retrieve the configured text.
		status_text = {
			enabled = false,
			-- Text to set if a lightbulb is available.
			text = "💡",
			-- Text to set if a lightbulb is unavailable.
			text_unavailable = "",
		},

		-- 5. Number column.
		number = {
			enabled = false,
			-- Highlight group to highlight the number column if there is a lightbulb.
			hl = "LightBulbNumber",
		},

		-- 6. Content line.
		line = {
			enabled = false,
			-- Highlight group to highlight the line if there is a lightbulb.
			hl = "LightBulbLine",
		},

		-- Autocmd configuration.
		-- If enabled, automatically defines an autocmd to show the lightbulb.
		-- If disabled, you will have to manually call |NvimLightbulb.update_lightbulb|.
		-- Only works if configured during NvimLightbulb.setup
		autocmd = {
			-- Whether or not to enable autocmd creation.
			enabled = true,
			-- See |updatetime|.
			-- Set to a negative value to avoid setting the updatetime.
			updatetime = 200,
			-- See |nvim_create_autocmd|.
			events = { "CursorHold", "CursorHoldI" },
			-- See |nvim_create_autocmd| and |autocmd-pattern|.
			pattern = { "*" },
		},

		-- Scenarios to not show a lightbulb.
		ignore = {
			-- LSP client names to ignore.
			-- Example: {"null-ls", "lua_ls"}
			clients = { "null-ls" },
			-- Filetypes to ignore.
			-- Example: {"neo-tree", "lua"}
			ft = { "NvimTree" },
			-- Ignore code actions without a `kind` like refactor.rewrite, quickfix.
			actions_without_kind = false,
		},
	})
end

function config.jdtls(plugin, options)
	local function attach_jdtls()
		local jdtls_config = require("doodleVim.modules.lsp.jdtls").get_config()
		require("jdtls").start_or_attach(jdtls_config)
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = attach_jdtls,
	})

	attach_jdtls()
end

function config.mason_null_ls()
	require("mason-null-ls").setup({
		-- A list of sources to install if they're not already installed.
		-- This setting has no relation with the `automatic_installation` setting.
		ensure_installed = {},
		-- Enable or disable null-ls methods to get set up
		-- This setting is useful if some functionality is handled by other plugins such as `conform` and `nvim-lint`
		methods = {
			diagnostics = true,
			formatting = true,
			code_actions = true,
			completion = true,
			hover = true,
		},
		-- Run `require("null-ls").setup`.
		-- Will automatically install masons tools based on selected sources in `null-ls`.
		-- Can also be an exclusion list.
		-- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
		automatic_installation = false,
		-- See [#handlers-usage](#handlers-usage) section
		handlers = nil,
	})
end

-- function config.copilot()
-- 	require("copilot").setup({})
-- end

return config
