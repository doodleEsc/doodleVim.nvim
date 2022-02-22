local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
    -- Vim map
    -- ["n|<C-x>k"]     = map_cr('bdelete'):with_noremap():with_silent(),
    -- ["n|<C-s>"]      = map_cu('write'):with_noremap(),
    ["n|Y"]          = map_cmd('y$'),
    -- ["n|]w"]         = map_cu('WhitespaceNext'):with_noremap(),
    -- ["n|[w"]         = map_cu('WhitespacePrev'):with_noremap(),
    -- ["n|]b"]         = map_cu('bp'):with_noremap(),
    -- ["n|[b"]         = map_cu('bn'):with_noremap(),
    -- ["n|<Space>cw"]  = map_cu([[silent! keeppatterns %substitute/\s\+$//e]]):with_noremap():with_silent(),
    ["n|<C-h>"]      = map_cmd('<C-w>h'):with_noremap(),
    ["n|<C-l>"]      = map_cmd('<C-w>l'):with_noremap(),
    ["n|<C-j>"]      = map_cmd('<C-w>j'):with_noremap(),
    ["n|<C-k>"]      = map_cmd('<C-w>k'):with_noremap(),
    -- ["n|<A-[>"]      = map_cr('vertical resize -5'):with_silent(),
    -- ["n|<A-]>"]      = map_cr('vertical resize +5'):with_silent(),
    -- ["n|<C-q>"]      = map_cmd(':wq<CR>'),
    -- ["n|<Leader>ss"] = map_cu('SessionSave'):with_noremap(),
    -- ["n|<Leader>sl"] = map_cu('SessionLoad'):with_noremap(),
  -- Insert
    -- ["i|<C-w>"]      = map_cmd('<C-[>diwa'):with_noremap(),
	
	-- cursor move
    ["i|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
    ["i|<C-f>"]      = map_cmd('<Right>'):with_noremap(),

	-- character del
    ["i|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["i|<C-h>"]      = map_cmd('<BS>'),

	-- cursor to front or end
    ["i|<C-a>"]      = map_cmd('<ESC>^i'):with_noremap(),
    ["i|<C-e>"]      = map_cmd('<ESC>A'):with_noremap(),

	-- add new line
    ["i|<C-o>"]      = map_cmd('<Esc>O'):with_noremap(),
    ["i|<C-l>"]      = map_cmd('<Esc>o'):with_noremap(),

	-- save and quit
    ["i|<C-s>"]      = map_cmd('<Esc>:w<CR>'):with_noremap(),
    ["i|<C-q>"]      = map_cmd('<Esc>:wq<CR>'):with_noremap(),

  -- command line
    ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
	["c|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
    ["c|<C-a>"]      = map_cmd('<Home>'):with_noremap(),
    ["c|<C-e>"]      = map_cmd('<End>'):with_noremap(),
    ["c|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
    ["c|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
    ["c|<C-t>"]      = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
}

bind.nvim_load_mapping(def_map)
