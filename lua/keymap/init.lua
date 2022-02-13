local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
-- local map_args = bind.map_args

local plug_map = {

	-- --window navigation
	-- ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
	-- ["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
	-- ["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
	-- ["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),

	-- Packer
	["n|<Leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
	["n|<Leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
	["n|<Leader>pc"] = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();

	-- ["i|<C-l>"] = map_cmd("<Right>"):with_noremap();
	-- ["i|<C-h>"] = map_cmd("<Left>"):with_noremap();

	-- LSP
	["n|gd"] = map_cr("lua require('telescope.builtin').lsp_definitions()"):with_noremap():with_silent();
	["n|gD"] = map_cr("lua vim.lsp.buf.declaration()"):with_noremap():with_silent();
	["n|gt"] = map_cr("lua require('telescope.builtin').lsp_type_definitions()"):with_noremap():with_silent();
	["n|gi"] = map_cr("lua require('telescope.builtin').lsp_implementations()"):with_noremap():with_silent();
	["n|gr"] = map_cr("lua require('telescope.builtin').lsp_references()"):with_noremap():with_silent();
	["n|gh"] = map_cr("lua require('lspaction.hover').render_hover_doc()"):with_noremap():with_silent();
	["n|gf"] = map_cr("lua vim.lsp.buf.formatting()"):with_noremap():with_silent();
	["v|gf"] = map_cr("lua vim.lsp.buf.formatting()"):with_noremap():with_silent();
	["n|ga"] = map_cr("lua require('lspaction.codeaction').code_action()"):with_noremap():with_silent();
	["v|ga"] = map_cu("lua require('lspaction.codeaction').range_code_action()"):with_noremap():with_silent();
	["n|gs"] = map_cr("lua require('lsp_signature').signature()"):with_noremap():with_silent();
	["n|gn"] = map_cr("lua require('lspaction.rename').rename()"):with_noremap():with_silent();
	["n|<C-f>"] = map_cr("lua require('lspaction.action').smart_scroll_with_saga(1)"):with_noremap():with_silent();
	["n|<C-b>"] = map_cr("lua require('lspaction.action').smart_scroll_with_saga(-1)"):with_noremap():with_silent();

	-- Diagnostics
	["n|<C-n>"] = map_cr("lua require('lspaction.diagnostic').navigate'next'()"):with_noremap():with_silent();
	["n|<C-p>"] = map_cr("lua require('lspaction.diagnostic').navigate'prev'()"):with_noremap():with_silent();
	["n|<Leader>ee"] = map_cr("lua require('Telescope.builtin').diagnostics({ignore_filename=true})"):with_noremap():with_silent();
	["n|<Leader>dd"] = map_cr("lua require('Telescope.builtin').diagnostics({bufnr=0})"):with_noremap():with_silent();
	["n|<Leader>ww"] = map_cr("lua require('lspaction.diagnostic').toggle_virtual_text()"):with_noremap():with_silent();

    -- Plugin MarkdownPreview
    ["n|mw"] = map_cu('MarkdownPreviewToggle'):with_noremap():with_silent(),

	-- Plugin vim-floaterm
    ["n|ft"]    = map_cu('FloatermToggle'):with_noremap():with_silent(),
    ["t|ft"]    = map_cmd([[<C-\><C-n>:FloatermToggle<CR>]]):with_noremap():with_silent(),	-- floaterm toggle
    ["n|fr"]    = map_cu('FloatermNew --cwd=<root>'):with_noremap():with_silent(),
    ["n|fv"]    = map_cu('FloatermNew --cwd=<buffer>'):with_noremap():with_silent(),
    ["t|fg"]    = map_cmd([[<C-\><C-n>:FloatermNew gitui<CR>]]):with_noremap():with_silent(),-- open gitui
    ["t|<C-h>"] = map_cmd([[<C-\><C-n>:FloatermPrev<CR>]]):with_noremap():with_silent(),		-- previous terminal
    ["t|<C-l>"] = map_cmd([[<C-\><C-n>:FloatermNext<CR>]]):with_noremap():with_silent(),		-- next terminal
    ["t|fk"]    = map_cmd([[<C-\><C-n>:FloatermKill<CR>]]):with_noremap():with_silent(),		-- just kill the front terminal
    ["t|fd"]    = map_cmd([[<C-\><C-n>:FloatermKill!<CR>]]):with_noremap():with_silent(),	-- kill them all

    -- Plugin Telescope
	["n|<Leader>ff"] = map_cr('Telescope find_files'):with_noremap(),
	["n|<Leader>fg"] = map_cr('Telescope live_grep'):with_noremap(),

	-- Comment
	["n|<Leader>cc"] = map_cr('lua require("Comment.api").toggle_current_linewise()'):with_noremap():with_silent(),
	["n|<Leader>b"] = map_cr('lua require("Comment.api").toggle_current_linewise()'):with_noremap():with_silent(),
	["v|<Leader>cc"] = map_cu('lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())'):with_noremap():with_silent(),
	["v|<Leader>b"] = map_cu('lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())'):with_noremap():with_silent(),

    -- Plugin Vista
    ["n|<Leader>v"] = map_cu('Vista!!'):with_noremap():with_silent(),

	-- Plugin NvimTree
	["n|tt"] = map_cr("lua require('extend.tree').toggle()"):with_noremap():with_silent(),

	-- Plugin translator
	["n|tr"] = map_cu("TranslateW"):with_silent(),
	["v|tr"] = map_cr("TranslateW"):with_silent(),

	-- Plugin nvim-dap
	["n|<F7>"]  = map_cmd("<cmd>lua require('extend.dap').debug_continue()<CR>"):with_noremap(),
	["n|<F19>"] = map_cmd("<cmd>lua require('extend.dap').debug_stop()<CR>"):with_noremap(), -- shift + F7
	["n|<F8>"]  = map_cmd("<cmd>lua require('extend.dap').debug_pause()<CR>"):with_noremap(),
	["n|<F20>"] = map_cmd("<cmd>lua require('extend.dap').debug_restart()<CR>"):with_noremap(), -- shift + F8
	["n|<F9>"]  = map_cmd("<cmd>lua require('extend.dap').debug_toggle()<CR>"):with_noremap():with_silent(),
	["n|<F10>"] = map_cmd("<cmd>lua require('extend.dap').debug_step_over()<CR>"):with_noremap():with_silent(),
	["n|<F11>"] = map_cmd("<cmd>lua require('extend.dap').debug_step_into()<CR>"):with_noremap():with_silent(),
	["n|<F23>"] = map_cmd("<cmd>lua require('extend.dap').debug_step_out()<CR>"):with_noremap():with_silent(), -- shift + F11
	["n|<F12>"] = map_cmd("<cmd>lua require('extend.dap').debug_run_to_cursor()<CR>"):with_noremap():with_silent(),
	["n|<F24>"] = map_cmd("<cmd>lua require('extend.dap').debug_run_last()<CR>"):with_noremap():with_silent(), -- shift + F12

	-- barbar.nvim
	["n|<S-h>"] = map_cu("BufferPrevious"):with_noremap():with_silent(),
	["n|<S-l>"] = map_cu("BufferNext"):with_noremap():with_silent(),
	["n|<S-n>"] = map_cu("BufferClose"):with_noremap():with_silent(),
	["n|<S-b>"] = map_cu("BufferCloseBuffersLeft"):with_noremap():with_silent(),
	["n|<S-m>"] = map_cu("BufferCloseBuffersRight"):with_noremap():with_silent(),
	["n|<S-i>"] = map_cu("BufferPin"):with_noremap():with_silent(),
	["n|<S-p>"] = map_cu("BufferPick"):with_noremap():with_silent(),
	["n|<S-s>"] = map_cu("BufferOrderByBufferNumber"):with_noremap():with_silent(),

	-- ascii draw
	["v|<Leader>l"]  = map_cu("VBox"):with_noremap():with_silent(),
	["v|<Leader>ld"] = map_cu("VBoxD"):with_noremap():with_silent(),
	["v|<Leader>lh"] = map_cu("VBoxH"):with_noremap():with_silent(),
	["v|<Leader>lf"] = map_cu("VFill"):with_noremap():with_silent(),

	-- hop.nvim
	["n|<Leader>hw"] = map_cr("lua require'hop'.hint_words()"):with_noremap():with_silent(),
	["n|<Leader>hs"] = map_cu("lua require'hop'.hint_char2()"):with_noremap():with_silent(),

	-- easyalign
	["n|ma"] = map_cmd("<Plug>(EasyAlign)"),
	["x|ma"] = map_cmd("<Plug>(EasyAlign)"),

	-- gotests
	["n|tu"] = map_cr("lua require'gotests'.fun_test()"):with_noremap():with_silent(),
	["n|ta"] = map_cr("lua require'gotests'.all_test()"):with_noremap():with_silent(),
	["n|te"] = map_cr("lua require'gotests'.exported_test()"):with_noremap():with_silent(),
};

bind.nvim_load_mapping(plug_map)
