local extensions = {
	'coc-json',
	'coc-yaml',
	'coc-yank',
	'coc-pairs',
	'coc-yaml',
	'coc-tabnine',
	'coc-snippets',
	'coc-pyright',
	'coc-rls',
	'coc-go'
}

local function set_extensions()
	vim.g.coc_global_extensions = extensions
	vim.cmd [[command! ExtensionUpdate call coc#util#install_extension(g:coc_global_extensions)]]
end

set_extensions()
