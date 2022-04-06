local bind = require('doodleVim.keymap.bind')
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
local map_cmd = bind.map_cmd


local def_map = {}

def_map.normal = {
  ["Y"] = bind.convert_wk_format(map_cmd('y$'):with_label("Copy To End Of Line")),
  ["<C-h>"] = bind.convert_wk_format(map_cmd('<C-w>h'):with_noremap():with_label("Switch To Left Window")),
  ["<C-l>"] = bind.convert_wk_format(map_cmd('<C-w>l'):with_noremap():with_label("Switch To Right Window")),
  ["<C-j>"] = bind.convert_wk_format(map_cmd('<C-w>j'):with_noremap():with_label("Switch To Down Window")),
  ["<C-k>"] = bind.convert_wk_format(map_cmd('<C-w>k'):with_noremap():with_label("Switch To Up Window")),
  ["<C-q>"] = bind.convert_wk_format(map_cr('lua require("doodleVim.extend.misc").safe_exit()'):with_noremap():with_label("Save Session And Safe Exit")),
  ["<C-s>"] = bind.convert_wk_format(map_cr('lua require("doodleVim.extend.misc").safe_save()'):with_noremap():with_silent():with_label("Save Session")),
  ["<C-d>"] = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.scroll').scroll_down()"):with_noremap():with_silent():with_label("Smooth Scroll Down")),
  ["<C-u>"] = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.scroll').scroll_up()"):with_noremap():with_silent():with_label("Smooth Scroll Up"))
}

def_map.insert = {
  ["<C-b>"] = bind.convert_wk_format(map_cmd('<Left>'):with_noremap():with_mode("i"):with_label("Cursor Left")),
  ["<C-f>"] = bind.convert_wk_format(map_cmd('<Right>'):with_noremap():with_mode("i"):with_label("Cursor Right")),
  ["<C-d>"] = bind.convert_wk_format(map_cmd('<Del>'):with_noremap():with_mode("i"):with_label("Del")),
  ["<C-h>"] = bind.convert_wk_format(map_cmd('<BS>'):with_mode("i"):with_label("Backspace")),
  ["<C-a>"] = bind.convert_wk_format(map_cmd('<ESC>^i'):with_noremap():with_mode("i"):with_label("Move Cursor To Head")),
  ["<C-e>"] = bind.convert_wk_format(map_cmd('<ESC>A'):with_noremap():with_mode("i"):with_label("Move Cursor To End")),
  ["<C-l>"] = bind.convert_wk_format(map_cmd('<Esc>o'):with_noremap():with_mode("i"):with_label("New Line Blow")),
  ["<C-o>"] = bind.convert_wk_format(map_cmd('<Esc>O'):with_noremap():with_mode("i"):with_label("New Line Up")),
  ["<C-s>"] = bind.convert_wk_format(map_cmd('<Esc>:lua require("doodleVim.extend.misc").safe_save()<CR>'):with_noremap():with_mode("i"):with_label("Save Session")),
  ["<C-q>"] = bind.convert_wk_format(map_cmd('<Esc>:lua require("doodleVim.extend.misc").safe_exit()<CR>'):with_noremap():with_mode("i"):with_label("Save Session And Safe Exit")),
}

def_map.command = {
  ["<C-b>"] = bind.convert_wk_format(map_cmd('<Left>'):with_noremap():with_mode("c"):with_label("Cursor Left")),
  ["<C-f>"] = bind.convert_wk_format(map_cmd('<Right>'):with_noremap():with_mode("c"):with_label("Cursor Right")),
  ["<C-a>"] = bind.convert_wk_format(map_cmd('<Home>'):with_noremap():with_mode("c"):with_label("Home")),
  ["<C-e>"] = bind.convert_wk_format(map_cmd('<End>'):with_noremap():with_mode("c"):with_label("End")),
  ["<C-d>"] = bind.convert_wk_format(map_cmd('<Del>'):with_noremap():with_mode("c"):with_label("Del")),
  ["<C-h>"] = bind.convert_wk_format(map_cmd('<BS>'):with_noremap():with_mode("c"):with_label("Backspace")),
  ["<C-t>"] = bind.convert_wk_format(map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap():with_mode("c"):with_label("Show Current Directory"))
}

def_map.visual = {
  ["<C-d>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('doodleVim.extend.scroll').scroll_down()<CR>"):with_noremap():with_silent():with_label("Smooth Scroll Down"):with_mode("x")),
  ["<C-u>"] = bind.convert_wk_format(map_cmd("<cmd>lua require('doodleVim.extend.scroll').scroll_up()<CR>"):with_noremap():with_silent():with_label("Smooth Scroll Up"):with_mode("x"))
}

return def_map
