local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
-- local map_args = bind.map_args

local plug_map = {}

plug_map.raw = {
	["t|ft"]    = map_cmd([[<C-\><C-n>:FloatermToggle<CR>]]):with_noremap():with_silent(),	-- floaterm toggle
	["t|fg"]    = map_cmd([[<C-\><C-n>:FloatermNew gitui<CR>]]):with_noremap():with_silent(),-- open gitui
	["t|<C-h>"] = map_cmd([[<C-\><C-n>:FloatermPrev<CR>]]):with_noremap():with_silent(),		-- previous terminal
	["t|<C-l>"] = map_cmd([[<C-\><C-n>:FloatermNext<CR>]]):with_noremap():with_silent(),		-- next terminal
	["t|fk"]    = map_cmd([[<C-\><C-n>:FloatermKill<CR>]]):with_noremap():with_silent(),		-- just kill the front terminal
	["t|fd"]    = map_cmd([[<C-\><C-n>:FloatermKill!<CR>]]):with_noremap():with_silent(),	-- kill them all
}

plug_map.normal = {
	["t"] = {
		name = "Tree,Gotests,Translate",
		t = bind.convert_wk_format(map_cr("lua require('extend.tree').toggle()"):with_noremap():with_silent():with_label("Enhanced NvimTree Toggle")),
		u = bind.convert_wk_format(map_cr("lua require'gotests'.fun_test()"):with_noremap():with_silent():with_label("Generate Function Test")),
		a = bind.convert_wk_format(map_cr("lua require'gotests'.all_test()"):with_noremap():with_silent():with_label("Generate All Function Test")),
		e = bind.convert_wk_format(map_cr("lua require'gotests'.exported_test()"):with_noremap():with_silent():with_label("Generate Exported Function Test")),
		r = bind.convert_wk_format(map_cu("TranslateW"):with_silent():with_label("Translate Word In Cursor"))
	},

	["g"] = {
		name = "Lsp Function",
		d = bind.convert_wk_format(map_cr("lua require('telescope.builtin').lsp_definitions()"):with_noremap():with_silent():with_label("Go To Definition")),
		D = bind.convert_wk_format(map_cr("lua vim.lsp.buf.declaration()"):with_noremap():with_silent():with_label("Go To Declaration")),
		t = bind.convert_wk_format(map_cr("lua require('telescope.builtin').lsp_type_definitions()"):with_noremap():with_silent():with_label("Go To Type Definition")),
		i = bind.convert_wk_format(map_cr("lua require('telescope.builtin').lsp_implementations()"):with_noremap():with_silent():with_label("Go To Implementation")),
		r = bind.convert_wk_format(map_cr("lua require('telescope.builtin').lsp_references()"):with_noremap():with_silent():with_label("Go To Reference")),
		h = bind.convert_wk_format(map_cr("lua require('lspsaga.hover').render_hover_doc()"):with_noremap():with_silent():with_label("Hover Documentation")),
		f = bind.convert_wk_format(map_cr("lua vim.lsp.buf.formatting()"):with_noremap():with_silent():with_label("Code Formatting")),
		a = bind.convert_wk_format(map_cr("lua require('lspsaga.codeaction').code_action()"):with_noremap():with_silent():with_label("Code Action")),
		s = bind.convert_wk_format(map_cr("lua require('lsp_signature').signature()"):with_noremap():with_silent():with_label("Function Signature")),
		n = bind.convert_wk_format(map_cr("lua require('lspsaga.rename').rename()"):with_noremap():with_silent():with_label("Rename"))
	},

	["<C-n>"] = bind.convert_wk_format(map_cr("lua require('lspsaga.diagnostic').navigate'next'()"):with_noremap():with_silent():with_label("Go To Next Diagnostic")),
	["<C-p>"]= bind.convert_wk_format(map_cr("lua require('lspsaga.diagnostic').navigate'prev'()"):with_noremap():with_silent():with_label("Go To Previous Diagnostic")),
	
	["<leader>v"] = {
		name = "Symbols-Outline",
		v = bind.convert_wk_format(map_cu('lua require"symbols-outline".toggle_outline()'):with_noremap():with_silent():with_label("Symbols And Function Preview"))
	},

	["<leader>p"] = {
		name = "Packer Manage",
		u = bind.convert_wk_format(map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait():with_label("Packer Update")),
		c = bind.convert_wk_format(map_cr("PackerCompile"):with_silent():with_noremap():with_nowait():with_label("Packer Compile")),
		x = bind.convert_wk_format(map_cr("PackerClean"):with_silent():with_noremap():with_nowait():with_label("Packer Clean")),
	},

	["<leader>d"] = {
		name = "Show Diagnostics In Buffer Or WorkSpace",
		d = bind.convert_wk_format(map_cr("lua require('telescope.builtin').diagnostics({bufnr=0})"):with_noremap():with_silent():with_label("Show Diagnostics In Current Buffer")),
		e = bind.convert_wk_format(map_cr("lua require('telescope.builtin').diagnostics({ignore_filename=true})"):with_noremap():with_silent():with_label("Show Diagnostics In WorkSpace")),
		t = bind.convert_wk_format(map_cr("lua require('lspsaga.diagnostic').toggle_virtual_text()"):with_noremap():with_silent():with_label("Toggle Diagnostics Virtual Text"))
	},

	["m"] = {
		name = "MarkdownPreview, EasyAlign",
		w = bind.convert_wk_format(map_cu('MarkdownPreviewToggle'):with_noremap():with_silent():with_label("Toggle Markdown Preview")),
		a = bind.convert_wk_format(map_cmd("<Plug>(EasyAlign)"):with_label("EasyAlign File"))
	},

	["f"] = {
		name = "Floaterm",
		t = bind.convert_wk_format(map_cu('FloatermToggle'):with_noremap():with_silent():with_label("Toggle Floaterm")),
		r = bind.convert_wk_format(map_cu('FloatermNew --cwd=<root>'):with_noremap():with_silent():with_label("Open Floaterm In Project Rood Dir")),
		v = bind.convert_wk_format(map_cu('FloatermNew --cwd=<buffer>'):with_noremap():with_silent():with_label("Open Floaterm In CWD")),
		d = {"Kill All Floaterm In Terminal Mode"},
		k = {"Kill Current Floaterm In Terminal Mode"},
	},

	["<leader>f"] = {
		name = "Telescope Search",
		f = bind.convert_wk_format(map_cr('Telescope find_files'):with_noremap():with_label("Find Files")),
		g = bind.convert_wk_format(map_cr('Telescope live_grep'):with_noremap():with_label("Live Grep")),
		h = bind.convert_wk_format(map_cr('Telescope projects'):with_noremap():with_label("Find Projects")),
		j = bind.convert_wk_format(map_cr('Telescope todo-comments todo'):with_noremap():with_label("Find Todos"))
	},

	["<leader>c"] = {
		name = "Comment",
		c = bind.convert_wk_format(map_cr('lua require("Comment.api").toggle_current_linewise()'):with_noremap():with_silent():with_label("Comment Current Line")),
	},

	["<leader>s"] = {
		name = "Search Word",
		w = bind.convert_wk_format(map_cr("lua require'hop'.hint_words()"):with_noremap():with_silent():with_label("Search Word")),
		s = bind.convert_wk_format(map_cu("lua require'hop'.hint_char2()"):with_noremap():with_silent():with_label("Search By First 2 Char"))
	},

	["<F7>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_continue()<CR>"):with_noremap():with_label("Start Or Continue Debug")),
	["<F19>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_stop()<CR>"):with_noremap():with_label("Stop Debugging, Shortcut: Shift + F7")),
	["<F8>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_pause()<CR>"):with_noremap():with_label("Pause Debug")),
	["<F20>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_restart()<CR>"):with_noremap():with_label("Restart Debug")),
	["<F9>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_toggle()<CR>"):with_noremap():with_silent():with_label("Toggle Breakpoint")),
	["<F10>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_step_over()<CR>"):with_noremap():with_silent():with_label("Step Over")),
	["<F11>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_step_into()<CR>"):with_noremap():with_silent():with_label("Step Into")),
	["<F23>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_step_out()<CR>"):with_noremap():with_silent():with_label("Step Out, Shortcut: Shift + F11")),
	["<F12>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_run_to_cursor()<CR>"):with_noremap():with_silent():with_label("Run To Cursor")),
	["<F24>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('extend.dap').debug_run_last()<CR>"):with_noremap():with_silent():with_label("Run To Last, Shortcut: Shift + F12")),

	["<S-h>"] = bind.convert_wk_format(map_cu("BufferPrevious"):with_noremap():with_silent():with_label("Previous Buffer")),
	["<S-l>"] = bind.convert_wk_format(map_cu("BufferNext"):with_noremap():with_silent():with_label("Next Buffer")),
	["<S-n>"] = bind.convert_wk_format(map_cu("BufferClose"):with_noremap():with_silent():with_label("Close Current Buffer")),
	["<S-b>"] = bind.convert_wk_format(map_cu("BufferCloseBuffersLeft"):with_noremap():with_silent():with_label("Close All Buffers Left")),
	["<S-m>"] = bind.convert_wk_format(map_cu("BufferCloseBuffersRight"):with_noremap():with_silent():with_label("Close All Buffers Right")),
	["<S-i>"] = bind.convert_wk_format(map_cu("BufferPin"):with_noremap():with_silent():with_label("Pin Buffer")),
	["<S-p>"] = bind.convert_wk_format(map_cu("BufferPick"):with_noremap():with_silent():with_label("Pick Buffer")),
	["<S-s>"] = bind.convert_wk_format(map_cu("BufferOrderByBufferNumber"):with_noremap():with_silent():with_label("Sort Buffer")),

	["<C-Space>"] = bind.convert_wk_format(map_cr("WhichKey"):with_noremap():with_silent():with_label("Show Keymaps"))
}

plug_map.visual = {
	["g"] = {
		name = "Lsp Function",
		f = bind.convert_wk_format(map_cr("lua vim.lsp.buf.formatting()"):with_noremap():with_silent():with_label("Selected Code Formatting"):with_mode("v")),
		a = bind.convert_wk_format(map_cr("lua require('lspsaga.codeaction').code_action()"):with_noremap():with_silent():with_label("Range Code Action"):with_mode("v")),
	},

	["m"] = {
		name = "EasyAlign",
		a = bind.convert_wk_format(map_cmd("<Plug>(EasyAlign)"):with_label("EasyAlign Selected Buffer"):with_mode("v"))
	},

	["t"] = {
		name = "Tree,Gotests,Translate",
		r = bind.convert_wk_format(map_cu("TranslateW"):with_silent():with_label("Translate Selected Buffer"):with_mode("v"))
	},

	["<leader>c"] = {
		name = "Comment",
		c = bind.convert_wk_format(map_cr('lua require("Comment.api").toggle_current_linewise()'):with_noremap():with_silent():with_label("Comment Selected Line"):with_mode("v")),
		b = bind.convert_wk_format(map_cu('lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())'):with_noremap():with_silent():with_label("Comment Selected Code Block"):with_mode("v"))
	},

	["<leader>l"] = {
		name = "Draw Ascii Picture",
		l = bind.convert_wk_format(map_cu("VBox"):with_noremap():with_silent():with_label("Normal Line"):with_mode("v")),
		d = bind.convert_wk_format(map_cu("VBoxD"):with_noremap():with_silent():with_label("Double Line"):with_mode("v")),
		h = bind.convert_wk_format(map_cu("VBoxH"):with_noremap():with_silent():with_label("Hard Line"):with_mode("v")),
		f = bind.convert_wk_format(map_cu("VFill"):with_noremap():with_silent():with_label("Fill Box"):with_mode("v"))
	},

	["<C-Space>"] = bind.convert_wk_format(map_cu("WhichKey '' v"):with_noremap():with_label("Show Keymaps"):with_mode("v"))

}

plug_map.insert = {
	["<C-Space>"] = bind.convert_wk_format(map_cmd("<Esc>:WhichKey '' i<CR>"):with_noremap():with_label("Show Keymaps"):with_mode("i"))
}

return plug_map
