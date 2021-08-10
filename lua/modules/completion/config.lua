local config = {}

function config.nvim_lsp()
  require('modules.completion.lspconfig')
end

function config.nvim_compe()
	require'compe'.setup {
		enabled = true;
		debug = false;
		min_length = 1;
		preselect = 'always';
		allow_prefix_unmatch = false;
		documentation = {
			border = { '┌', '─' ,'┐', '│', '┘', '─', '└', '│' }, -- the border option is the same as `|help nvim_open_win|`
			max_width = 120,
			min_width = 60,
			max_height = math.floor(vim.o.lines * 0.4),
			min_height = 1,
		};
		source = {
			path = true;
			buffer = true;
			calc = true;
			vsnip = true;
			nvim_lsp = true;
			nvim_lua = true;
			spell = true;
			tags = true;
			snippets_nvim = false;
			tabnine = {
			    priority = 100;
			};
		};
	}
end

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
end

function config.telescope()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
    vim.cmd [[packadd popup.nvim]]
    vim.cmd [[packadd telescope-fzy-native.nvim]]
  end
  require('telescope').setup {
    defaults = {
      prompt_prefix = '🔭 ',
      selection_caret = " ",
      sorting_strategy = 'ascending',
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
  }
  require('telescope').load_extension('fzy_native')
  -- require'telescope'.load_extension('dotfiles')
  -- require'telescope'.load_extension('gosource')
end

function config.vim_sonictemplate()
  vim.g.sonictemplate_postfix_key = '<C-,>'
  vim.g.sonictemplate_vim_template_dir = os.getenv("HOME").. '/.config/nvim/template'
end

function config.smart_input()
  require('smartinput').setup {
    ['go'] = { ';',':=',';' }
  }
end

return config
