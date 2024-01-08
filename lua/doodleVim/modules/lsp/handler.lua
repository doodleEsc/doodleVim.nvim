local M = {}

local codicons = require("codicons")

M.lsp_highlight_document = function()
	require("doodleVim.extend.lsp").register_on_attach(function(client, bufnr)
		if client.server_capabilities.documentHighlightProvider then
			local CursorHoldOpts = {
				group = "lsp_document_highlight",
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			}

			local CursorHoldIOpts = {
				group = "lsp_document_highlight",
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			}

			local CursorMovedOpts = {
				group = "lsp_document_highlight",
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			}
			vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
			vim.api.nvim_create_autocmd("CursorHold", CursorHoldOpts)
			vim.api.nvim_create_autocmd("CursorHoldI", CursorHoldIOpts)
			vim.api.nvim_create_autocmd("CursorMoved", CursorMovedOpts)
		end
	end)
end

M.lsp_hover = function()
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
end

M.lsp_diagnostic = function()
	vim.diagnostic.config({
		underline = true,
		signs = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			focusable = false,
			header = { codicons.get("debug") .. "  Diagnostics:", "DiagnosticHeader" },
			source = "if_many",
		},
		virtual_text = {
			spacing = 4,
			source = "always",
			severity = {
				min = vim.diagnostic.severity.HINT,
			},
		},
	})

	require("doodleVim.extend.diagnostics").setup({
		error_sign = codicons.get("error"),
		warn_sign = codicons.get("warning"),
		hint_sign = codicons.get("question"),
		infor_sign = codicons.get("info"),
		debug_sign = codicons.get("debug"),
		use_diagnostic_virtual_text = false,
	})
end

M.null_ls_depress = function()
	-- from null-ls to other lsp clients
	-- @see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/197#issuecomment-922792992
	local default_exe_handler = vim.lsp.handlers["workspace/executeCommand"]
	vim.lsp.handlers["workspace/executeCommand"] = function(err, result, ctx, config)
		-- supress NULL_LS error msg
		--
		local prefix = "NULL_LS"
		if err and ctx.params.command:sub(1, #prefix) == prefix then
			return
		end
		return default_exe_handler(err, result, ctx, config)
	end
end

return M
