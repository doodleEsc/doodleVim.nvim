local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function autocmd.load_autocmds()
  local definitions = {
    packer = {
      {"BufWritePost","*.lua","lua require('doodleVim.core.pack').auto_compile()"};
    },
    wins = {
      -- Highlight current line only on focused window
      -- {"WinEnter,BufEnter,InsertLeave", "*", [[if ! &cursorline && &filetype =~# '^alpha' && ! &pvw | setlocal cursorline | endif]]};
      -- {"WinLeave,BufLeave,InsertEnter", "*", [[if &cursorline && &filetype !~# '^\(alpha\|clap_\)' && ! &pvw | setlocal nocursorline | endif]]};
      -- Equalize window dimensions when resizing vim window
      {"VimResized", "*", [[tabdo wincmd =]]};
      -- Force write shada on leaving nvim
      -- {"VimLeave", "*", [[if has('nvim') | wshada! | else | wviminfo! | endif]]};
      -- Check if file changed when its window is focus, more eager than 'autoread'
      -- {"FocusGained", "* checktime"};
    },

    ft = {
      {"BufReadPost,BufNewFile","*.sol"," setf solidity"},
      {"FileType", "Outline", " setlocal signcolumn=no"},
      {"FileType", "python", " setlocal colorcolumn=80"}
    },

    yank = {
      {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]};
    },

    action = {
      -- {"CursorHold,CursorHoldI", "*", "lua require'lightbulb'.check()"};
	},
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
