local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
    --window navigation
    ["n|<C-h>"]         = map_cmd("<C-w>h"):with_noremap(),
    ["n|<C-l>"]         = map_cmd("<C-w>l"):with_noremap(),
    ["n|<C-j>"]         = map_cmd("<C-w>j"):with_noremap(),
    ["n|<C-k>"]         = map_cmd("<C-w>k"):with_noremap(),
    ["i|<CR>"]          = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),

    -- person keymap
    --["n|mf"]          = map_cr("<cmd>lua require('internal.fsevent').file_event()<CR>"):with_silent():with_nowait():with_noremap();

    -- Packer
    ["n|<Leader>pu"]    = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
    ["n|<Leader>pi"]    = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
    ["n|<Leader>pc"]    = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();

    -- Lsp map work when insertenter and lsp start
    ["n|<Leader>lr"]    = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
    ["n|<C-f>"]         = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|<C-b>"]         = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|<S-j>"]         = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|<S-k>"]         = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),

    ["n|ga"]            = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["v|ga"]            = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
    ["n|gh"]            = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
    ["n|gd"]            = map_cmd("<cmd>lua vim.lsp.buf.definition()<CR>"):with_noremap():with_silent(),
    ["n|gp"]            = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
    ["n|gr"]            = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|gt"]            = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
    ["n|gi"]            = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|gs"]            = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|gn"]            = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|gf"]            = map_cmd('<cmd>lua vim.lsp.buf.formatting()<CR>'):with_noremap():with_silent(),
    ["v|gf"]            = map_cmd('<cmd>lua vim.lsp.buf.formatting()<CR>'):with_noremap():with_silent(),

    --["n|<Leader>cw"]  = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    --["n|<Leader>ce"]  = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    -- ["n|<Leader>ct"] = map_args("Template"),
    -- ["n|<Leader>tf"] = map_cu('DashboardNewFile'):with_noremap():with_silent(),

    -- Plugin nvim-tree
    ["n|tt"]            = map_cr('NvimTreeToggle'):with_noremap():with_silent(),

    -- Plugin MarkdownPreview
    ["n|mf"]            = map_cu('MarkdownPreviewToggle'):with_noremap():with_silent(),

    -- Plugin Floaterm
    ["n|fj"]            = map_cu('Lspsaga open_floaterm'):with_noremap():with_silent(),
    ["t|fj"]            = map_cu([[<C-\><C-n>:Lspsaga close_floaterm<CR>]]):with_noremap():with_silent(),

    -- Far.vim
    --["n|<Leader>fa"]  = map_cr('Farf'):with_noremap():with_silent();
    --["v|<Leader>fa"]  = map_cr('Farf'):with_noremap():with_silent();

    -- Plugin Telescope
    --["n|<Leader>bb"]    = map_cu('Telescope buffers'):with_noremap():with_silent(),
    ["n|<Leader>fb"]    = map_cu('Telescope file_browser'):with_noremap():with_silent(),
    ["n|<Leader>ff"]    = map_cu('Telescope find_files'):with_noremap():with_silent(),
    ["v|<Leader>fs"]    = map_cu('Telescope grep_string'):with_noremap():with_silent(),
    ["n|<Leader>fw"]    = map_cu('Telescope live_grep'):with_noremap():with_silent(),
    ["n|<Leader>fh"]    = map_cu('Telescope oldfiles'):with_noremap():with_silent(),
    --["n|<Leader>fl"]    = map_cu('Telescope loclist'):with_noremap():with_silent(),
    ["n|<Leader>fc"]    = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    ["n|<Leader>fg"]    = map_cu('Telescope git_files'):with_noremap():with_silent(),
    --["n|<Leader>ft"]    = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    --["n|<Leader>fd"]    = map_cu('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
    --["n|<Leader>fs"]    = map_cu('Telescope gosource'):with_noremap():with_silent(),

    -- prodoc
    ["n|gcc"]           = map_cu('ProComment'):with_noremap():with_silent(),
    ["x|gcc"]           = map_cr('ProComment'),
    ["n|gcj"]           = map_cu('ProDoc'):with_silent():with_silent(),

    -- Plugin QuickRun
    ["n|<Leader>r"]     = map_cr("<cmd> lua require'internal.quickrun'.run_command()"):with_noremap():with_silent(),

    -- Plugin Vista
    ["n|<Leader>v"]     = map_cu('Vista'):with_noremap():with_silent(),

	-- Plugin vim-vsnip
	["i|<C-j>"]         = map_cmd("vsnip#jumpable(1)?'<Plug>(vsnip-jump-next)':'<C-j>'"):with_expr(),
	["s|<C-j>"]         = map_cmd("vsnip#jumpable(1)?'<Plug>(vsnip-jump-next)':'<C-j>'"):with_expr(),
	["i|<C-k>"]         = map_cmd("vsnip#jumpable(1)?'<Plug>(vsnip-jump-prev)':'<C-k>'"):with_expr(),
	["s|<C-k>"]         = map_cmd("vsnip#jumpable(1)?'<Plug>(vsnip-jump-prev)':'<C-k>'"):with_expr(),

	-- Plugin translator
	["n|tl"]            = map_cr(":TranslateW"):with_silent(),
	["v|tl"]            = map_cu("TranslateW"):with_silent(),

	-- Plugin gotests-vim
	["n|tu"]            = map_cu('GoTests'):with_silent(),
	["n|ta"]            = map_cu('GoTestsAll'):with_silent(),

};

bind.nvim_load_mapping(plug_map)