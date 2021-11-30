local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
-- require('keymap.config')

local plug_map = {
    --window navigation
    ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
    ["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
    ["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
    ["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),

    -- CR enhancement
    -- ["i|<CR>"] = map_cmd('pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"'):with_noremap():with_expr():with_silent(),
    ["i|<CR>"] = map_cmd('pumvisible() ? coc#_select_confirm() : "<CR>"'):with_noremap():with_expr():with_silent(),

    -- Packer
    ["n|<Leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
    ["n|<Leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
    ["n|<Leader>pc"] = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();

    -- Lsp map work when insertenter and lsp start
    ["n|<C-f>"] = map_cmd('coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"'):with_silent():with_noremap():with_expr():with_nowait(),
    ["v|<C-f>"] = map_cmd('coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"'):with_silent():with_noremap():with_expr():with_nowait(),
    ["i|<C-f>"] = map_cmd('coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"'):with_silent():with_noremap():with_expr():with_nowait(),
    ["n|<C-b>"] = map_cmd('coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"'):with_silent():with_noremap():with_expr():with_nowait(),
    ["v|<C-b>"] = map_cmd('coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"'):with_silent():with_noremap():with_expr():with_nowait(),
    ["i|<C-b>"] = map_cmd('coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"'):with_silent():with_noremap():with_expr():with_nowait(),
    ["n|<C-n>"] = map_cu("call CocActionAsync('diagnosticNext')"):with_noremap():with_silent(),
    ["n|<C-p>"] = map_cu("call CocActionAsync('diagnosticPrevious')"):with_noremap():with_silent(),
    ["v|gf"]    = map_cu("call CocActionAsync('formatSelected',visualmode())"):with_noremap():with_silent(),
    ["n|gf"]    = map_cu("call CocActionAsync('format')"):with_noremap():with_silent(),
    ["n|gn"]    = map_cu("call CocActionAsync('rename')"):with_noremap():with_silent(),
    ["n|ga"]    = map_cu("call CocActionAsync('codeAction','')"):with_noremap():with_silent(),
    ["v|ga"]    = map_cu("call CocActionAsync('codeAction',visualmode())"):with_noremap():with_silent(),
    ["n|gd"]    = map_cu("call       CocActionAsync('jumpDefinition')"):with_noremap():with_silent(),
    ["n|gD"]    = map_cu("call       CocActionAsync('jumpDeclaration')"):with_noremap():with_silent(),
    ["n|gi"]    = map_cu("call       CocActionAsync('jumpImplementation')"):with_noremap():with_silent(),
    ["n|gt"]    = map_cu("call       CocActionAsync('jumpTypeDefinition')"):with_noremap():with_silent(),
    ["n|gr"]    = map_cu("call       CocActionAsync('jumpReferences')"):with_noremap():with_silent(),
    ["n|gu"]    = map_cu("call       CocActionAsync('jumpUsed')"):with_noremap():with_silent(),
    ["n|gq"]    = map_cu("call       CocActionAsync('doQuickfix')"):with_noremap():with_silent(),
    ["n|gm"]    = map_cu("call       CocActionAsync('refactor')"):with_noremap():with_silent(),
    ["n|gh"]    = map_cu("call CocActionAsync('doHover')"):with_noremap():with_silent(),
    ["n|gs"]    = map_cu("call CocActionAsync('showSignatureHelp')"):with_noremap():with_silent(),
	["n|tu"]    = map_cu("CocCommand go.test.generate.function"):with_noremap():with_silent(),
	["i|<C-l>"] = map_cmd("coc#_insert_key('request', 'snippets-expand', 1)"):with_noremap():with_silent():with_expr(),

    -- Plugin MarkdownPreview
    ["n|mp"]            = map_cu('MarkdownPreviewToggle'):with_noremap():with_silent(),

    -- Plugin Floaterm
    ["n|fn"]    = map_cu('FloatermNew'):with_noremap():with_silent(),
    ["n|fg"]    = map_cu('FloatermNew --width=0.9 --height=0.9 --name=git gitui'):with_noremap():with_silent(),
    ["n|ft"]    = map_cu('FloatermToggle'):with_noremap():with_silent(),
    ["t|ft"]    = map_cu([[<C-\><C-n>:FloatermToggle<CR>]]):with_noremap():with_silent(),
    ["t|<C-n>"] = map_cu([[<C-\><C-n>:FloatermNext]]):with_noremap():with_silent(),
    ["t|<C-p>"] = map_cu([[<C-\><C-n>:FloatermPrev]]):with_noremap():with_silent(),

    -- -- Plugin Telescope
    -- ["n|<Leader>ft"] = map_cu('Telescope buffers'):with_noremap():with_silent(),
    -- ["n|<Leader>fb"] = map_cu('Telescope file_browser'):with_noremap():with_silent(),
    -- ["n|<Leader>ff"] = map_cu('Telescope find_files'):with_noremap():with_silent(),
    -- ["v|<Leader>fs"] = map_cu('Telescope grep_string'):with_noremap():with_silent(),
    -- ["n|<Leader>fw"] = map_cu('Telescope live_grep'):with_noremap():with_silent(),
    -- ["n|<Leader>fh"] = map_cu('Telescope oldfiles'):with_noremap():with_silent(),
    -- ["n|<Leader>fc"] = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    -- ["n|<Leader>fg"] = map_cu('Telescope git_files'):with_noremap():with_silent(),
	
	["n|<Leader>f"] = map_args('Telescope'):with_noremap(),

    -- Plugin Vista
    ["n|<Leader>v"] = map_cu('Vista!!'):with_noremap():with_silent(),

	-- Plugin NvimTree
	["n|tt"] = map_cmd("<cmd>lua require('extend.tree').TreeToggle()<CR>"):with_noremap():with_silent(),

	-- Plugin translator
	["n|<Leader>t"] = map_cr(":TranslateW"):with_silent(),
	["v|<Leader>t"] = map_cu("TranslateW"):with_silent(),

	-- Plugin nvim-dap
	["n|<F5>"]    = map_cmd("<cmd>lua require('extend.dap').debug_continue()<CR>"):with_noremap(),
	["n|<F17>"]  = map_cmd("<cmd>lua require('extend.dap').debug_stop()<CR>"):with_noremap(), -- shift + F5
	["n|<F6>"]    = map_cmd("<cmd>lua require('extend.dap').debug_pause()<CR>"):with_noremap(),
	["n|<F18>"]  = map_cmd("<cmd>lua require('extend.dap').debug_restart()<CR>"):with_noremap(), -- shift + F6
	["n|<F9>"]    = map_cmd("<cmd>lua require('extend.dap').debug_toggle()<CR>"):with_noremap():with_silent(),
	["n|<F10>"]   = map_cmd("<cmd>lua require('extend.dap').debug_step_over()<CR>"):with_noremap():with_silent(),
	["n|<F11>"]   = map_cmd("<cmd>lua require('extend.dap').debug_step_into()<CR>"):with_noremap():with_silent(),
	["n|<F23>"] = map_cmd("<cmd>lua require('extend.dap').debug_step_out()<CR>"):with_noremap():with_silent(), -- shift + F11
	["n|<F12>"]   = map_cmd("<cmd>lua require('extend.dap').debug_run_to_cursor()<CR>"):with_noremap():with_silent(),
	["n|<F24>"] = map_cmd("<cmd>lua require('extend.dap').debug_run_last()<CR>"):with_noremap():with_silent(), -- shift + F12

	-- barbar.nvim
	["n|<S-h>"] = map_cr(":BufferPrevious"):with_noremap():with_silent(),
	["n|<S-l>"] = map_cr(":BufferNext"):with_noremap():with_silent(),
	["n|<S-n>"] = map_cr(":BufferClose"):with_noremap():with_silent(),
	["n|<S-b>"] = map_cr(":BufferCloseBuffersLeft"):with_noremap():with_silent(),
	["n|<S-m>"] = map_cr(":BufferCloseBuffersRight"):with_noremap():with_silent(),
	["n|<S-i>"] = map_cr(":BufferPin"):with_noremap():with_silent(),
	["n|<S-p>"] = map_cr(":BufferPick"):with_noremap():with_silent(),
	["n|<S-s>"] = map_cr(":BufferOrderByBufferNumber"):with_noremap():with_silent(),

	-- ascii draw
	["v|<Leader>l"]  = map_cr("VBox"):with_noremap():with_silent(),
	["v|<Leader>ld"] = map_cr("VBoxD"):with_noremap():with_silent(),
	["v|<Leader>lh"] = map_cr("VBoxH"):with_noremap():with_silent(),
	["v|<Leader>lf"] = map_cr("VFill"):with_noremap():with_silent(),


};

bind.nvim_load_mapping(plug_map)
