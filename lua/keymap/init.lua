local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args

local plug_map = {
    --window navigation
    ["n|<C-h>"]         = map_cmd("<C-w>h"):with_noremap(),
    ["n|<C-l>"]         = map_cmd("<C-w>l"):with_noremap(),
    ["n|<C-j>"]         = map_cmd("<C-w>j"):with_noremap(),
    ["n|<C-k>"]         = map_cmd("<C-w>k"):with_noremap(),

    -- Packer
    ["n|<Leader>pu"]    = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
    ["n|<Leader>pi"]    = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
    ["n|<Leader>pc"]    = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();



    -- Plugin MarkdownPreview
    ["n|mp"] = map_cu('MarkdownPreviewToggle'):with_noremap():with_silent(),

    -- Plugin FTerm
    ["n|ft"]    = map_cu('FTermToggle'):with_noremap():with_silent(),
    ["n|fg"]    = map_cu('FTermRun gitui'):with_noremap():with_silent(),
    ["t|ft"]    = map_cu([[<C-\><C-n>:FTermToggle<CR>]]):with_noremap():with_silent(),
    ["t|fn"]    = map_cu([[<C-\><C-n>:FTermExit<CR>]]):with_noremap():with_silent(),

    -- Plugin Telescope
	["n|<Leader>f"] = map_args('Telescope'):with_noremap(),

	-- Comment
	["n|<Leader>cc"] = map_cr('lua require("Comment.api").toggle_current_linewise()'):with_noremap():with_silent(),
	["n|<Leader>bb"] = map_cr('lua require("Comment.api").toggle_current_linewise()'):with_noremap():with_silent(),
	["x|<Leader>cc"] = map_cu('lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())'),
	["x|<Leader>bb"] = map_cu('lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())'),

    -- Plugin Vista
    ["n|<Leader>v"] = map_cu('Vista!!'):with_noremap():with_silent(),

	-- Plugin NvimTree
	["n|tt"] = map_cr("lua require('extend.tree').toggle()"):with_noremap():with_silent(),

	-- Plugin translator
	["n|<Leader>t"] = map_cu("TranslateW"):with_silent(),
	["v|<Leader>t"] = map_cr("TranslateW"):with_silent(),

	-- Plugin nvim-dap
	["n|<F5>"]  = map_cmd("<cmd>lua require('extend.dap').debug_continue()<CR>"):with_noremap(),
	["n|<F17>"] = map_cmd("<cmd>lua require('extend.dap').debug_stop()<CR>"):with_noremap(), -- shift + F5
	["n|<F6>"]  = map_cmd("<cmd>lua require('extend.dap').debug_pause()<CR>"):with_noremap(),
	["n|<F18>"] = map_cmd("<cmd>lua require('extend.dap').debug_restart()<CR>"):with_noremap(), -- shift + F6
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
};

bind.nvim_load_mapping(plug_map)
