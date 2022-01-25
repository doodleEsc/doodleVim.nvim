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
local package_path_str = "/home/fanlz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/fanlz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/fanlz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/fanlz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/fanlz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\fpadding\2\vsticky\2\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["barbar.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n«\2\0\0\4\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\2B\0\2\1K\0\1\0&current_line_blame_formatter_opts\1\0\1\18relative_time\1\28current_line_blame_opts\1\0\4\ndelay\3è\a\18virt_text_pos\beol\14virt_text\2\22ignore_whitespace\1\17watch_gitdir\1\0\2\rinterval\3Ð\15\17follow_files\2\fkeymaps\1\0\1\23current_line_blame\1\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/gruvbox.nvim",
    url = "https://github.com/cinuor/gruvbox.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\21show_end_of_line\2\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nZ\0\0\4\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0B\1\2\1K\0\1\0\1\0\1\21code_action_icon\tðŸ’¡\18init_lsp_saga\flspsaga\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.ui.lualine\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\nÕ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rmappings\1\0\5\22respect_scrolloff\1\24use_local_scrolloff\1\rstop_eof\2\16hide_cursor\1\25cursor_scrolls_alone\2\1\n\0\0\n<C-u>\n<C-d>\n<C-b>\n<C-f>\n<C-y>\n<C-e>\azt\azz\azb\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nt\0\0\b\0\a\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0009\4\3\0009\4\4\0044\6\3\0005\a\5\0>\a\1\6B\4\2\2=\4\4\3B\1\2\1K\0\1\0\1\0\0\1\0\1\tname\rnvim_lsp\fsources\vconfig\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui", "nvim-dap-virtual-text" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.debug.dapconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\nÇ\4\0\0\6\0\27\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\0025\3\14\0004\4\5\0005\5\n\0>\5\1\0045\5\v\0>\5\2\0045\5\f\0>\5\3\0045\5\r\0>\5\4\4=\4\15\3=\3\16\0025\3\18\0005\4\17\0=\4\15\3=\3\19\0025\3\20\0005\4\22\0005\5\21\0=\5\23\4=\4\t\3=\3\24\0025\3\25\0=\3\26\2B\0\2\1K\0\1\0\fwindows\1\0\1\vindent\3\1\rfloating\nclose\1\0\0\1\3\0\0\6q\n<Esc>\1\0\3\vborder\vsingle\14max_width\4š³æÌ\t™³æþ\3\15max_height\4š³æÌ\t™³æþ\3\ttray\1\0\2\rposition\vbottom\tsize\3\n\1\2\0\0\trepl\fsidebar\relements\1\0\2\rposition\tleft\tsize\3(\1\0\2\aid\fwatches\tsize\4\0€€Àþ\3\1\0\2\aid\vstacks\tsize\4\0€€Àþ\3\1\0\2\aid\16breakpoints\tsize\4\0€€Àþ\3\1\0\2\aid\vscopes\tsize\4\0€€Àþ\3\rmappings\vexpand\1\0\4\trepl\6r\tedit\6e\vremove\6d\topen\6o\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\2\14collapsed\bâ–¸\rexpanded\bâ–¾\nsetup\ndapui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\21dap_virtual_text\6g\bvim\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\n?\0\1\6\1\3\0\b5\1\0\0-\2\0\0=\2\1\1\18\4\0\0009\2\2\0\18\5\1\0B\2\3\1K\0\1\0\0€\nsetup\17capabilities\1\0\0±\2\1\0\5\0\15\0\0296\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4€6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\6\0009\0\a\0009\0\b\0B\0\1\0026\1\t\0'\3\n\0B\1\2\0029\1\v\1\18\3\0\0B\1\2\2\18\0\1\0006\1\t\0'\3\f\0B\1\2\0029\2\r\0013\4\14\0B\2\2\0012\0\0€K\0\1\0\0\20on_server_ready\23nvim-lsp-installer\24update_capabilities\17cmp_nvim_lsp\frequire\29make_client_capabilities\rprotocol\blsp\28PackerLoad cmp-nvim-lsp\bcmd\bvim\vloaded\17cmp-nvim-lsp\19packer_plugins\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "lspsaga.nvim", "nvim-lsp-installer" },
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.completion.lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nÙ\3\0\0\6\0\20\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0005\4\6\0=\4\a\3=\3\b\0025\3\t\0004\4\0\0=\4\n\3=\3\v\0025\3\f\0004\4\0\0=\4\r\3=\3\14\0025\3\15\0005\4\16\0004\5\0\0=\5\17\4=\4\18\3=\3\19\2B\0\2\1K\0\1\0\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\3\16auto_resize\1\tside\tleft\nwidth\3\31\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\venable\2\15update_cwd\1\16diagnostics\nicons\1\0\4\fwarning\bï±\thint\bïª\nerror\bï—\tinfo\bïš\1\0\1\venable\2\23ignore_ft_on_setup\1\0\a\18hijack_cursor\2\16open_on_tab\1\15auto_close\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\15update_cwd\1\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\n¯\5\0\0\6\0\24\0$6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\4€6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\6\0009\0\a\0'\2\b\0B\0\2\0016\0\3\0009\0\6\0009\0\a\0'\2\t\0B\0\2\0016\0\n\0'\2\v\0B\0\2\0029\0\f\0005\2\14\0005\3\r\0=\3\15\0025\3\16\0=\3\17\0025\3\21\0005\4\18\0005\5\19\0=\5\20\4=\4\22\3=\3\23\2B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\fkeymaps\1\0\v\aah\16@call.outer\ail\16@loop.inner\aac\17@class.outer\aih\16@call.inner\aaf\20@function.outer\aal\16@loop.outer\aif\20@function.inner\aas\21@statement.outer\aib\17@block.inner\aic\17@class.inner\aab\17@block.outer\1\0\2\venable\2\14lookahead\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\0\1\2\0\0\vpython\nsetup\28nvim-treesitter.configs\frequire,set foldexpr=nvim_treesitter#foldexpr()\24set foldmethod=expr\17nvim_command\bapi+PackerLoad nvim-treesitter-textobjects\bcmd\bvim\vloaded nvim-treesitter-textobjects\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-coc.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/telescope-coc.nvim",
    url = "https://github.com/fannheyward/telescope-coc.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-file-browser.nvim", "telescope-fzy-native.nvim", "telescope-coc.nvim" },
    config = { "\27LJ\2\n‡\a\0\0\a\0#\0N6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\f€6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\4\0'\2\6\0B\0\2\0016\0\3\0009\0\4\0'\2\a\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0\n\0005\2\24\0005\3\v\0006\4\b\0'\6\f\0B\4\2\0029\4\r\0049\4\14\4=\4\15\0036\4\b\0'\6\f\0B\4\2\0029\4\16\0049\4\14\4=\4\17\0036\4\b\0'\6\f\0B\4\2\0029\4\18\0049\4\14\4=\4\19\0035\4\21\0005\5\20\0=\5\22\4=\4\23\3=\3\25\0025\3\27\0005\4\26\0=\4\28\0035\4\29\0=\4\30\3=\3\31\2B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0 \0'\2\28\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0 \0'\2\30\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0 \0'\2!\0B\0\2\0016\0\b\0'\2\t\0B\0\2\0029\0 \0'\2\"\0B\0\2\1K\0\1\0\18todo-comments\bcoc\19load_extension\15extensions\17file_browser\1\0\1\ntheme\bivy\15fzy_native\1\0\0\1\0\2\25override_file_sorter\2\28override_generic_sorter\2\rdefaults\1\0\0\18layout_config\rvertical\1\0\0\1\0\2\vheight\4š³æÌ\t™³¦ÿ\3\nwidth\4Í™³æ\fÌ™³ÿ\3\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\25telescope.previewers\1\0\3\20selection_caret\tï¡ \18prompt_prefix\nðŸ”­ \21sorting_strategy\14ascending\nsetup\14telescope\frequire\"PackerLoad telescope-coc.nvim+PackerLoad telescope-file-browser.nvim)PackerLoad telescope-fzy-native.nvim\bcmd\bvim\vloaded\23telescope-coc.nvim\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\nò\6\0\0\6\0*\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0005\5\14\0=\5\6\4=\4\15\0035\4\16\0005\5\17\0=\5\6\4=\4\18\0035\4\19\0005\5\20\0=\5\6\4=\4\21\3=\3\22\0025\3\23\0004\4\0\0=\4\24\3=\3\25\0025\3\27\0005\4\26\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\3=\3%\0025\3&\0005\4'\0=\4(\3=\3)\2B\0\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\vcolors\fdefault\1\2\0\0\f#7C3AED\thint\1\2\0\0\f#10B981\tinfo\1\2\0\0\f#2563EB\fwarning\1\2\0\0\f#FBBF24\nerror\1\0\0\1\2\0\0\f#DC2626\14highlight\fexclude\1\0\6\fpattern\22.*<(KEYWORDS)\\s*:\nafter\afg\fkeyword\twide\vbefore\5\17max_line_len\3\3\18comments_only\2\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tï¡§ \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\2\ticon\tï™‘ \ncolor\fdefault\tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tï± \ncolor\fwarning\tHACK\1\0\2\ncolor\fwarning\ticon\tï’ \tTODO\1\0\2\ncolor\tinfo\ticon\tï€Œ \bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ticon\tï†ˆ \ncolor\nerror\1\0\3\18sign_priority\3\b\19merge_keywords\2\nsigns\2\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["venn.nvim"] = {
    commands = { "VBox", "VFill" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-easy-align"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-floaterm"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-helm"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-helm",
    url = "https://github.com/towolf/vim-helm"
  },
  ["vim-matchup"] = {
    after_files = { "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-solidity"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-solidity",
    url = "https://github.com/TovarishFin/vim-solidity"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-translator"] = {
    commands = { "TranslateW" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-translator",
    url = "https://github.com/voldikss/vim-translator"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/fanlz/.local/share/nvim/site/pack/packer/opt/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\n…\2\0\0\2\0\n\0\0296\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1ˆ#=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0K\0\1\0\20mkdp_auto_close\28mkdp_command_for_global\26mkdp_echo_preview_url\14mkdp_port\f0.0.0.0\17mkdp_open_ip\27mkdp_open_to_the_world\20mkdp_auto_start\6g\bvim\0", "setup", "markdown-preview.nvim")
time([[Setup for markdown-preview.nvim]], false)
-- Setup for: barbar.nvim
time([[Setup for barbar.nvim]], true)
try_loadstring("\27LJ\2\næ\3\0\0\4\0\n\0\0166\0\0\0009\0\1\0005\1\3\0004\2\0\0=\2\4\0014\2\0\0=\2\5\1=\1\2\0006\0\6\0'\2\a\0B\0\2\0029\0\b\0'\2\t\0)\3 \3B\0\3\1K\0\1\0\16barbar.nvim\22packer_defer_load\nutils\frequire\17exclude_name\15exclude_ft\1\0\17\14animation\2\14auto_hide\2\19maximum_length\3\30\21semantic_letters\2\16icon_pinned\bï¤‚\fletters:asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP\28icon_close_tab_modified\bâ—\19icon_close_tab\bï™•\28icon_separator_inactive\bâ”‚\26icon_separator_active\bâ”‚\23icon_custom_colors\1\nicons\2\14clickable\2\rclosable\2\rtabpages\2\20maximum_padding\3\1\18insert_at_end\1\15bufferline\6g\bvim\0", "setup", "barbar.nvim")
time([[Setup for barbar.nvim]], false)
-- Setup for: nvim-lspconfig
time([[Setup for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nV\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\19nvim-lspconfig\22packer_defer_load\nutils\frequire\0", "setup", "nvim-lspconfig")
time([[Setup for nvim-lspconfig]], false)
-- Setup for: Comment.nvim
time([[Setup for Comment.nvim]], true)
try_loadstring("\27LJ\2\nT\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\17Comment.nvim\22packer_defer_load\nutils\frequire\0", "setup", "Comment.nvim")
time([[Setup for Comment.nvim]], false)
-- Setup for: nvim-treesitter
time([[Setup for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nW\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\20nvim-treesitter\22packer_defer_load\nutils\frequire\0", "setup", "nvim-treesitter")
time([[Setup for nvim-treesitter]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\nV\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3è\3B\0\3\1K\0\1\0\19telescope.nvim\22packer_defer_load\nutils\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3è\3B\0\3\1K\0\1\0\18gitsigns.nvim\22packer_defer_load\nutils\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: vim-floaterm
time([[Setup for vim-floaterm]], true)
try_loadstring("\27LJ\2\n†\2\0\0\4\0\f\1\0246\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\0\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\b\0'\2\t\0B\0\2\0029\0\n\0'\2\v\0)\3è\3B\0\3\1K\0\1\0\17vim-floaterm\22packer_defer_load\nutils\frequire\tedit\20floaterm_opener\29â”€â”‚â”€â”‚â•­â•®â•¯â•°\25floaterm_borderchars\20floaterm_height\19floaterm_width\6g\bvim›³æÌ\25Ì™³ÿ\3\0", "setup", "vim-floaterm")
time([[Setup for vim-floaterm]], false)
-- Setup for: vista.vim
time([[Setup for vista.vim]], true)
try_loadstring("\27LJ\2\n™\4\0\0\2\0\17\0)6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0005\1\r\0=\1\f\0006\0\0\0009\0\1\0005\1\15\0=\1\14\0006\0\0\0009\0\1\0)\1(\0=\1\16\0K\0\1\0\24vista_sidebar_width\1\3\0\0\15â•°â”€â–¸ \15â”œâ”€â–¸ \22vista_icon_indent\1\0\5\15typescript\bcoc\rmarkdown\btoc\vpandoc\rmarkdown\fvimwiki\rmarkdown\20typescriptreact\bcoc\24vista_executive_for\rmarkdown\28vista_vimwiki_executive\17floating_win\31vista_echo_cursor_strategy\bcoc\28vista_default_executive\29vista_disable_statusline\23vista_stay_on_open\24vista_close_on_jump\31vista#renderer#enable_icon\6g\bvim\0", "setup", "vista.vim")
time([[Setup for vista.vim]], false)
-- Setup for: vim-easymotion
time([[Setup for vim-easymotion]], true)
try_loadstring("\27LJ\2\nV\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ü\5B\0\3\1K\0\1\0\19vim-easymotion\22packer_defer_load\nutils\frequire\0", "setup", "vim-easymotion")
time([[Setup for vim-easymotion]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
try_loadstring("\27LJ\2\nT\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\17Comment.nvim\22packer_defer_load\nutils\frequire\0", "setup", "vim-matchup")
time([[Setup for vim-matchup]], false)
-- Setup for: vim-easy-align
time([[Setup for vim-easy-align]], true)
try_loadstring("\27LJ\2\nV\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3Ü\5B\0\3\1K\0\1\0\19vim-easy-align\22packer_defer_load\nutils\frequire\0", "setup", "vim-easy-align")
time([[Setup for vim-easy-align]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\26indent-blankline.nvim\22packer_defer_load\nutils\frequire\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: neoscroll.nvim
time([[Setup for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\nV\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0)\3d\0B\0\3\1K\0\1\0\19neoscroll.nvim\22packer_defer_load\nutils\frequire\0", "setup", "neoscroll.nvim")
time([[Setup for neoscroll.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nt\0\0\b\0\a\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0009\4\3\0009\4\4\0044\6\3\0005\a\5\0>\a\1\6B\4\2\2=\4\4\3B\1\2\1K\0\1\0\1\0\0\1\0\1\tname\rnvim_lsp\fsources\vconfig\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TranslateW lua require("packer.load")({'vim-translator'}, { cmd = "TranslateW", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Vista lua require("packer.load")({'vista.vim'}, { cmd = "Vista", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VBox lua require("packer.load")({'venn.nvim'}, { cmd = "VBox", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VFill lua require("packer.load")({'venn.nvim'}, { cmd = "VFill", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType solidity ++once lua require("packer.load")({'vim-solidity'}, { ft = "solidity" }, _G.packer_plugins)]]
vim.cmd [[au FileType helm ++once lua require("packer.load")({'vim-helm'}, { ft = "helm" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'nvim-colorizer.lua'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au UIEnter * ++once lua require("packer.load")({'lualine.nvim'}, { event = "UIEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'todo-comments.nvim'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], true)
vim.cmd [[source /home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]]
time([[Sourcing ftdetect script at: /home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], false)
time([[Sourcing ftdetect script at: /home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]], true)
vim.cmd [[source /home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]]
time([[Sourcing ftdetect script at: /home/fanlz/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
