-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/fanlizhou/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/fanlizhou/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/fanlizhou/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/fanlizhou/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/fanlizhou/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\vsticky\2\fpadding\2\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n°\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\npaths\1\0\0\1\2\0\0?~/.local/share/nvim/site/pack/packer/opt/friendly-snippets\14lazy_load luasnip.loaders.from_vscode\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["barbar.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tabnine"] = {
    after_files = { "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-tabnine/after/plugin/cmp-tabnine.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  cmp_luasnip = {
    after_files = { "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n´\2\0\0\4\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\2B\0\2\1K\0\1\0&current_line_blame_formatter_opts\1\0\1\18relative_time\1\28current_line_blame_opts\1\0\4\ndelay\3Ë\a\22ignore_whitespace\1\18virt_text_pos\beol\14virt_text\2\17watch_gitdir\1\0\2\17follow_files\2\rinterval\3–\15\fkeymaps\1\0\1\23current_line_blame\1\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/gruvbox.nvim",
    url = "https://github.com/cinuor/gruvbox.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21show_end_of_line\2\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-action.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14lspaction\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/lsp-action.nvim",
    url = "https://github.com/cinuor/lsp-action.nvim"
  },
  ["lsp_signature.nvim"] = {
    after = { "nvim-lsp-installer" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    after = { "nvim-web-devicons" },
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30plugins.ui.lualine_config\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n¥\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rmappings\1\0\5\25cursor_scrolls_alone\2\22respect_scrolloff\1\24use_local_scrolloff\1\rstop_eof\2\16hide_cursor\1\1\3\0\0\n<C-u>\n<C-d>\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nõ\2\0\0\b\0\15\0\0296\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0026\1\6\0'\3\b\0B\1\2\0029\1\t\0014\3\0\0B\1\2\0016\1\6\0'\3\n\0B\1\2\0029\2\v\0\18\4\2\0009\2\f\2'\5\r\0009\6\14\1B\6\1\0A\2\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\nsetup\19nvim-autopairs\bcmp\frequire\24PackerLoad nvim-cmp\bcmd\bvim\vloaded\rnvim-cmp\19packer_plugins\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-buffer", "cmp-path", "cmp_luasnip", "cmp-nvim-lsp", "LuaSnip", "cmp-tabnine", "nvim-lspconfig" },
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire»\1\0\1\t\0\n\0\0256\1\0\0'\3\1\0B\1\2\0029\1\2\1)\3ˇˇB\1\2\2\15\0\1\0X\2\14Ä6\1\3\0009\1\4\0019\1\5\0016\3\3\0009\3\6\0039\3\a\3'\5\b\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\t\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\5\28<Plug>luasnip-jump-prev\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\rjumpable\fluasnip\frequire”\1\0\1\t\0\n\0\0246\1\0\0'\3\1\0B\1\2\0029\1\2\1B\1\1\2\15\0\1\0X\2\14Ä6\1\3\0009\1\4\0019\1\5\0016\3\3\0009\3\6\0039\3\a\3'\5\b\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\t\0B\1\3\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\5!<Plug>luasnip-expand-or-jump\27nvim_replace_termcodes\bapi\rfeedkeys\afn\bvim\23expand_or_jumpable\fluasnip\frequireü\2\0\2\t\0\r\0!9\2\0\0016\3\1\0009\3\2\3\18\5\2\0)\6ˇˇ)\aˇˇB\3\4\2\a\3\3\0X\3\aÄ6\3\1\0009\3\2\3\18\5\2\0)\6\0\0)\a˛ˇB\3\4\2=\3\0\0016\3\4\0'\5\5\0B\3\2\0026\4\1\0009\4\a\4'\6\b\0009\a\6\0018\a\a\0039\b\6\1B\4\4\2=\4\6\0015\4\n\0009\5\v\0009\5\f\0058\4\5\4=\4\t\1L\1\2\0\tname\vsource\1\0\5\rnvim_lsp\n[LSP]\16cmp_tabnine\n[TAB]\tpath\v[PATH]\fluasnip\n[SNP]\vbuffer\n[BUF]\tmenu\n%s %s\vformat\tkind\16utils.icons\frequire\6~\bsub\vstring\tabbrœ\6\1\0\n\0009\0d6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\6\0'\2\a\0B\0\2\0029\1\b\0005\3\f\0005\4\n\0003\5\t\0=\5\v\4=\4\r\0039\4\14\0009\4\15\0044\6\6\0005\a\16\0>\a\1\0065\a\17\0>\a\2\0065\a\18\0>\a\3\0065\a\19\0>\a\4\0065\a\20\0>\a\5\6B\4\2\2=\4\15\0035\4\23\0009\5\21\0009\5\22\5B\5\1\2=\5\24\0049\5\21\0009\5\25\5B\5\1\2=\5\26\0049\5\21\0009\a\21\0009\a\27\a)\t˛ˇB\a\2\0025\b\28\0B\5\3\2=\5\29\0049\5\21\0009\a\21\0009\a\27\a)\t\2\0B\a\2\0025\b\30\0B\5\3\2=\5\31\0049\5\21\0005\a!\0009\b\21\0009\b \bB\b\1\2=\b\"\a9\b\21\0009\b#\bB\b\1\2=\b$\aB\5\2\2=\5%\0049\5\21\0009\5&\0055\a)\0009\b'\0009\b(\b=\b*\aB\5\2\2=\5+\0043\5,\0=\5-\0043\5.\0=\5/\4=\4\21\0035\0044\0004\5\4\0009\0060\0009\0061\6>\6\1\0059\0060\0009\0062\6>\6\2\0059\0060\0009\0063\6>\6\3\5=\0055\0043\0056\0=\0057\4=\0048\3B\1\2\1K\0\1\0\15formatting\vformat\0\vfields\1\0\0\tMenu\tKind\tAbbr\14ItemField\n<C-j>\0\n<C-k>\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\3\0\0\6i\6c\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\1\0\1\tname\fluasnip\1\0\1\tname\16cmp_tabnine\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\fsources\vconfig\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\23PackerLoad LuaSnip\bcmd\bvim\vloaded\fLuaSnip\19packer_plugins\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-virtual-text", "nvim-dap-ui" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.debug.dapconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n«\4\0\0\6\0\27\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\0025\3\14\0004\4\5\0005\5\n\0>\5\1\0045\5\v\0>\5\2\0045\5\f\0>\5\3\0045\5\r\0>\5\4\4=\4\15\3=\3\16\0025\3\18\0005\4\17\0=\4\15\3=\3\19\0025\3\20\0005\4\22\0005\5\21\0=\5\23\4=\4\t\3=\3\24\0025\3\25\0=\3\26\2B\0\2\1K\0\1\0\fwindows\1\0\1\vindent\3\1\rfloating\nclose\1\0\0\1\3\0\0\6q\n<Esc>\1\0\3\vborder\vsingle\14max_width\4ö≥ÊÃ\tô≥Ê˛\3\15max_height\4ö≥ÊÃ\tô≥Ê˛\3\ttray\1\0\2\rposition\vbottom\tsize\3\n\1\2\0\0\trepl\fsidebar\relements\1\0\2\rposition\tleft\tsize\3(\1\0\2\aid\fwatches\tsize\4\0ÄÄ¿˛\3\1\0\2\aid\vstacks\tsize\4\0ÄÄ¿˛\3\1\0\2\aid\16breakpoints\tsize\4\0ÄÄ¿˛\3\1\0\2\aid\vscopes\tsize\4\0ÄÄ¿˛\3\rmappings\vexpand\1\0\4\topen\6o\trepl\6r\tedit\6e\vremove\6d\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\2\14collapsed\b‚ñ∏\rexpanded\b‚ñæ\nsetup\ndapui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\21dap_virtual_text\6g\bvim\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\nù\1\0\2\6\0\6\0\t6\2\0\0'\4\1\0B\2\2\0029\2\2\0025\4\3\0005\5\4\0=\5\5\4B\2\2\1K\0\1\0\17handler_opts\1\0\1\vborder\tnone\1\0\3\16hint_enable\1\tbind\2#floating_window_above_cur_line\2\14on_attach\18lsp_signature\frequireR\1\1\6\1\5\0\n5\1\0\0-\2\0\0=\2\1\0013\2\2\0=\2\3\1\18\4\0\0009\2\4\0\18\5\1\0B\2\3\1K\0\1\0\0Ä\nsetup\14on_attach\0\17capabilities\1\0\0±\2\1\0\5\0\15\0\0296\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\6\0009\0\a\0009\0\b\0B\0\1\0026\1\t\0'\3\n\0B\1\2\0029\1\v\1\18\3\0\0B\1\2\2\18\0\1\0006\1\t\0'\3\f\0B\1\2\0029\2\r\0013\4\14\0B\2\2\0012\0\0ÄK\0\1\0\0\20on_server_ready\23nvim-lsp-installer\24update_capabilities\17cmp_nvim_lsp\frequire\29make_client_capabilities\rprotocol\blsp\28PackerLoad cmp-nvim-lsp\bcmd\bvim\vloaded\17cmp-nvim-lsp\19packer_plugins\0" },
    load_after = {
      ["lsp_signature.nvim"] = true,
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp-action.nvim", "lsp_signature.nvim", "nvim-lsp-installer" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    loaded = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/start/nvim-luadev",
    url = "https://github.com/bfredl/nvim-luadev"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nŸ\3\0\0\6\0\20\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0005\4\6\0=\4\a\3=\3\b\0025\3\t\0004\4\0\0=\4\n\3=\3\v\0025\3\f\0004\4\0\0=\4\r\3=\3\14\0025\3\15\0005\4\16\0004\5\0\0=\5\17\4=\4\18\3=\3\19\2B\0\2\1K\0\1\0\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\3\16auto_resize\1\nwidth\3\31\tside\tleft\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\15update_cwd\1\venable\2\16diagnostics\nicons\1\0\4\tinfo\bÔÅö\fwarning\bÔÅ±\thint\bÔÅ™\nerror\bÔÅó\1\0\1\venable\2\23ignore_ft_on_setup\1\0\a\15update_cwd\1\18hijack_cursor\2\16open_on_tab\1\15auto_close\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\nØ\5\0\0\6\0\24\0$6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4Ä6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\6\0009\0\a\0'\2\b\0B\0\2\0016\0\3\0009\0\6\0009\0\a\0'\2\t\0B\0\2\0016\0\n\0'\2\v\0B\0\2\0029\0\f\0005\2\14\0005\3\r\0=\3\15\0025\3\16\0=\3\17\0025\3\21\0005\4\18\0005\5\19\0=\5\20\4=\4\22\3=\3\23\2B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\fkeymaps\1\0\v\aah\16@call.outer\aih\16@call.inner\aaf\20@function.outer\aal\16@loop.outer\aas\21@statement.outer\aic\17@class.inner\aib\17@block.inner\aab\17@block.outer\ail\16@loop.inner\aif\20@function.inner\aac\17@class.outer\1\0\2\14lookahead\2\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\0\1\2\0\0\vpython\nsetup\28nvim-treesitter.configs\frequire,set foldexpr=nvim_treesitter#foldexpr()\24set foldmethod=expr\17nvim_command\bapi+PackerLoad nvim-treesitter-textobjects\bcmd\bvim\vloaded nvim-treesitter-textobjects\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    load_after = {
      ["lualine.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-file-browser.nvim", "telescope-fzy-native.nvim" },
    config = { "\27LJ\2\n≥\r\0\0\t\0E\0z6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\bÄ6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\4\0'\2\6\0B\0\2\0016\0\a\0'\2\b\0B\0\2\0026\1\a\0'\3\t\0B\1\2\0026\2\a\0'\4\n\0B\2\2\0029\2\v\0025\4@\0005\5\f\0005\6\r\0=\6\14\0055\6\15\0=\6\16\0055\6\17\0=\6\18\0055\6\20\0005\a\19\0=\a\21\0065\a\22\0=\a\23\6=\6\24\0055\6\25\0=\6\26\0055\0066\0005\a\28\0009\b\27\0=\b\29\a9\b\30\0=\b\31\a9\b \0=\b!\a9\b\"\0=\b#\a9\b$\0=\b%\a9\b&\0=\b'\a9\b(\0=\b)\a9\b*\0=\b+\a9\b,\0=\b-\a9\b.\0=\b/\a9\b0\0=\b1\a9\b2\1=\b3\a5\b4\0=\b5\a=\a7\0065\a8\0009\b\27\0=\b\29\a9\b\30\0=\b\31\a9\b \0=\b!\a9\b\"\0=\b#\a9\b$\0=\b%\a9\b&\0=\b'\a9\b(\0=\b)\a9\b*\0=\b+\a9\b,\0=\b-\a9\b.\0=\b/\a9\b0\0=\b1\a9\b2\1=\b3\a5\b9\0=\b5\a=\a:\6=\6;\0055\6=\0005\a<\0=\a>\6=\6?\5=\5A\4B\2\2\0016\2\a\0'\4\n\0B\2\2\0029\2B\2'\4>\0B\2\2\0016\2\a\0'\4\n\0B\2\2\0029\2B\2'\4C\0B\2\2\0016\2\a\0'\4\n\0B\2\2\0029\2B\2'\4D\0B\2\2\1K\0\1\0\18todo-comments\17file_browser\19load_extension\rdefaults\1\0\0\15extensions\15fzy_native\1\0\0\1\0\2\25override_file_sorter\2\28override_generic_sorter\2\21default_mappings\6n\1\2\1\0\f<c-s-w>\ttype\fcommand\1\0\0\6i\1\0\0\n<C-w>\1\2\1\0\f<c-s-w>\ttype\fcommand\n<Tab>\19toggle_preview\n<C-d>\27results_scrolling_down\n<C-u>\25results_scrolling_up\n<C-f>\27preview_scrolling_down\n<C-b>\25preview_scrolling_up\n<C-t>\15select_tab\n<C-v>\20select_vertical\n<C-s>\22select_horizontal\t<CR>\19select_default\n<C-c>\nclose\n<C-p>\28move_selection_previous\n<C-n>\1\0\0\24move_selection_next\fpreview\1\0\1\20hide_on_startup\2\18layout_config\rvertical\1\0\2\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\15horizontal\1\0\0\1\0\5\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\20prompt_position\btop\18preview_width\4≥ÊÃô\3≥Êåˇ\3\19preview_cutoff\3x\22vimgrep_arguments\1\t\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\v--trim\17path_display\1\3\0\0\nsmart\rtruncate\fset_env\1\0\1\14COLORTERM\14truecolor\1\0\a\20scroll_strategy\nlimit\21sorting_strategy\14ascending\20selection_caret\tÔÅ° \18prompt_prefix\nüî≠ \19color_devicons\2\18results_title\2\20layout_strategy\tflex\nsetup\14telescope\29telescope.actions.layout\22telescope.actions\frequire+PackerLoad telescope-file-browser.nvim)PackerLoad telescope-fzy-native.nvim\bcmd\bvim\vloaded\30telescope-fzy-native.nvim\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\nŒ\a\0\0\6\0,\00056\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0005\5\n\0=\5\6\4=\4\v\0035\4\f\0005\5\r\0=\5\6\4=\4\14\0035\4\15\0005\5\16\0=\5\6\4=\4\17\0035\4\18\0005\5\19\0=\5\6\4=\4\20\0035\4\21\0005\5\22\0=\5\6\4=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\26\3=\3\27\0025\3\29\0005\4\28\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\0035\4%\0=\4&\3=\3'\0025\3(\0005\4)\0=\4*\3=\3+\2B\0\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fcommand\arg\fpattern\21\\b(KEYWORDS)\\s*:\vcolors\fdefault\1\2\0\0\f#7C3AED\thint\1\2\0\0\f#10B981\tinfo\1\2\0\0\f#2563EB\fwarning\1\2\0\0\f#FBBF24\nerror\1\0\0\1\2\0\0\f#DC2626\14highlight\fexclude\1\0\6\17max_line_len\3ê\3\18comments_only\2\nafter\afg\fpattern\26.*<(KEYWORDS)\\s*:+\\s*\fkeyword\twide\vbefore\5\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\2\ticon\tÔôë \ncolor\fdefault\tWARN\1\6\0\0\fWARNING\bXXX\fwarning\bxxx\twarn\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\2\0\0\thack\1\0\2\ticon\tÔíê \ncolor\fwarning\tTODO\1\2\0\0\ttodo\1\0\2\ticon\tÔÄå \ncolor\tinfo\bFIX\1\0\0\balt\1\v\0\0\nFIXME\bBUG\nFIXIT\nISSUE\nERROR\nfixme\bbug\nfixit\nissue\nerror\1\0\2\ticon\tÔÜà \ncolor\nerror\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["venn.nvim"] = {
    commands = { "VBox", "VFill" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-easy-align"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-floaterm"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-helm"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-helm",
    url = "https://github.com/towolf/vim-helm"
  },
  ["vim-matchup"] = {
    after_files = { "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-solidity"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-solidity",
    url = "https://github.com/TovarishFin/vim-solidity"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-translator"] = {
    commands = { "TranslateW" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-translator",
    url = "https://github.com/voldikss/vim-translator"
  },
  ["vista.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\nN\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Z\0B\0\3\1K\0\1\0\19telescope.nvim\badd\16utils.defer\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: barbar.nvim
time([[Setup for barbar.nvim]], true)
try_loadstring("\27LJ\2\nx\0\0\4\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\5\0)\3Z\0B\0\3\1K\0\1\0\16barbar.nvim\badd\16utils.defer\vbarbar\22plugins.ui.config\frequire\0", "setup", "barbar.nvim")
time([[Setup for barbar.nvim]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Z\0B\0\3\1K\0\1\0\26indent-blankline.nvim\badd\16utils.defer\frequire\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: nvim-cmp
time([[Setup for nvim-cmp]], true)
try_loadstring("\27LJ\2\nV\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3ñ\0B\0\3\1K\0\1\0\rnvim-cmp\22packer_defer_load\16utils.defer\frequire\0", "setup", "nvim-cmp")
time([[Setup for nvim-cmp]], false)
-- Setup for: Comment.nvim
time([[Setup for Comment.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ë\3B\0\3\1K\0\1\0\17Comment.nvim\22packer_defer_load\16utils.defer\frequire\0", "setup", "Comment.nvim")
time([[Setup for Comment.nvim]], false)
-- Setup for: vim-easymotion
time([[Setup for vim-easymotion]], true)
try_loadstring("\27LJ\2\n\\\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ë\3B\0\3\1K\0\1\0\19vim-easymotion\22packer_defer_load\16utils.defer\frequire\0", "setup", "vim-easymotion")
time([[Setup for vim-easymotion]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
try_loadstring("\27LJ\2\nY\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ë\3B\0\3\1K\0\1\0\16vim-matchup\22packer_defer_load\16utils.defer\frequire\0", "setup", "vim-matchup")
time([[Setup for vim-matchup]], false)
-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\nÖ\2\0\0\2\0\n\0\0296\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1à#=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0K\0\1\0\20mkdp_auto_close\28mkdp_command_for_global\26mkdp_echo_preview_url\14mkdp_port\f0.0.0.0\17mkdp_open_ip\27mkdp_open_to_the_world\20mkdp_auto_start\6g\bvim\0", "setup", "markdown-preview.nvim")
time([[Setup for markdown-preview.nvim]], false)
-- Setup for: vim-easy-align
time([[Setup for vim-easy-align]], true)
try_loadstring("\27LJ\2\n\\\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ë\3B\0\3\1K\0\1\0\19vim-easy-align\22packer_defer_load\16utils.defer\frequire\0", "setup", "vim-easy-align")
time([[Setup for vim-easy-align]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Z\0B\0\3\1K\0\1\0\18gitsigns.nvim\badd\16utils.defer\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: todo-comments.nvim
time([[Setup for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\23todo-comments.nvim\22packer_defer_load\16utils.defer\frequire\0", "setup", "todo-comments.nvim")
time([[Setup for todo-comments.nvim]], false)
-- Setup for: nvim-treesitter
time([[Setup for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\20nvim-treesitter\22packer_defer_load\16utils.defer\frequire\0", "setup", "nvim-treesitter")
time([[Setup for nvim-treesitter]], false)
-- Setup for: nvim-autopairs
time([[Setup for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n\\\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ë\3B\0\3\1K\0\1\0\19nvim-autopairs\22packer_defer_load\16utils.defer\frequire\0", "setup", "nvim-autopairs")
time([[Setup for nvim-autopairs]], false)
-- Setup for: vim-floaterm
time([[Setup for vim-floaterm]], true)
try_loadstring("\27LJ\2\nå\1\0\0\4\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\5\0)\3Ë\3B\0\3\1K\0\1\0\17vim-floaterm\22packer_defer_load\16utils.defer\rfloaterm\25plugins.tools.config\frequire\0", "setup", "vim-floaterm")
time([[Setup for vim-floaterm]], false)
-- Setup for: lualine.nvim
time([[Setup for lualine.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\17lualine.nvim\22packer_defer_load\16utils.defer\frequire\0", "setup", "lualine.nvim")
time([[Setup for lualine.nvim]], false)
-- Setup for: vista.vim
time([[Setup for vista.vim]], true)
try_loadstring("\27LJ\2\nÜ\1\0\0\4\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0'\2\5\0)\3Ë\3B\0\3\1K\0\1\0\14vista.vim\22packer_defer_load\16utils.defer\nvista\25plugins.tools.config\frequire\0", "setup", "vista.vim")
time([[Setup for vista.vim]], false)
-- Setup for: neoscroll.nvim
time([[Setup for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\n\\\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ë\3B\0\3\1K\0\1\0\19neoscroll.nvim\22packer_defer_load\16utils.defer\frequire\0", "setup", "neoscroll.nvim")
time([[Setup for neoscroll.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VFill lua require("packer.load")({'venn.nvim'}, { cmd = "VFill", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TranslateW lua require("packer.load")({'vim-translator'}, { cmd = "TranslateW", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VBox lua require("packer.load")({'venn.nvim'}, { cmd = "VBox", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType helm ++once lua require("packer.load")({'vim-helm'}, { ft = "helm" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'nvim-colorizer.lua'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType solidity ++once lua require("packer.load")({'vim-solidity'}, { ft = "solidity" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], true)
vim.cmd [[source /Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]]
time([[Sourcing ftdetect script at: /Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], false)
time([[Sourcing ftdetect script at: /Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]], true)
vim.cmd [[source /Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]]
time([[Sourcing ftdetect script at: /Users/fanlizhou/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
