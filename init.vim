function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" language server protocol
	call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

	" debug adapter protocol
	call minpac#add('puremourning/vimspector')

	" snipet
	call minpac#add('honza/vim-snippets')

	" statusline
	call minpac#add('itchyny/lightline.vim')

	" tools
	call minpac#add('preservim/nerdcommenter')
	call minpac#add('preservim/nerdtree')
	call minpac#add('junegunn/vim-easy-align')
	call minpac#add('iamcco/markdown-preview.nvim', {'do': 'packloadall! | call mkdp#util#install()'})
	call minpac#add('itchyny/calendar.vim')
	call minpac#add('cinuor/vim-header')
	call minpac#add('voldikss/vim-floaterm')
	call minpac#add('sheerun/vim-polyglot')
	call minpac#add('easymotion/vim-easymotion')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-fugitive')
endfunction

let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-yaml',
	\ 'coc-yank',
	\ 'coc-pairs',
	\ 'coc-yaml',
	\ 'coc-tabnine',
	\ 'coc-snippets',
	\ 'coc-pyright',
	\ 'coc-rls',
	\ 'coc-go',
	\ 'coc-translator'
	\ ]

function! CocBuildUpdate()
	call coc#util#install()
	call coc#util#install_extension(g:coc_global_extensions)
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean	call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
command! ExtensionUpdate call CocBuildUpdate()

" neovim {
	set encoding=utf-8
	set hidden
	set nobackup
	set nowritebackup
	set updatetime=300
	set shortmess+=c
	set signcolumn=yes
	set clipboard+=unnamed
	set nocompatible
	set ts=4
	set sw=4
	set noexpandtab
	set noshowmode
	set colorcolumn=81
	set foldenable
	set foldmethod=syntax
	set foldcolumn=0
	setlocal foldlevel=1
	set foldlevelstart=99
	set termguicolors
	syntax enable
	colorscheme monokai-soda
	let mapleader=","

	let g:python_host_skip_check=1
	let g:python_host_prog = '/usr/local/bin/python'
	let g:python3_host_skip_check=1
	let g:python3_host_prog = '/usr/local/opt/python@3.9/bin/python3'
" }
	
" coc.nvim {
	" code navigation {
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gt <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)
	" }

	" code format or rename {
		function! s:show_documentation()
		  if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		  elseif (coc#rpc#ready())
			call CocActionAsync('doHover')
		  else
			execute '!' . &keywordprg . " " . expand('<cword>')
		  endif
		endfunction

		nmap <silent> gh :call <SID>show_documentation()<CR>
		nmap <silent> gn <Plug>(coc-rename)
		nmap <silent> gf <Plug>(coc-format)
		vmap <silent> gf <Plug>(coc-format-selected)
	" }

	" current code diagnostic {
		nmap <silent> <Leader>nw <Plug>(coc-diagnostic-next)
		nmap <silent> <Leader>pw <Plug>(coc-diagnostic-prev)
		nmap <silent> <Leader>ne <Plug>(coc-diagnostic-next-error)
		nmap <silent> <Leader>pe <Plug>(coc-diagnostic-prev-error) 
	" }
	
	" CocList Mappings {
		" Show all diagnostics
		nnoremap <silent><nowait> <Leader>ld :<C-u>CocList diagnostics<CR>

		" Manage extensions
		nnoremap <silent><nowait> <Leader>le :<C-u>CocList extensions<CR>

		" Show commands
		nnoremap <silent><nowait> <Leader>lc  :<C-u>CocList commands<CR>

		" Find symbol of current document
		nnoremap <silent><nowait> <Leader>lo  :<C-u>CocList outline<CR>

		" Search workspace symbols.
		nnoremap <silent><nowait> <Leader>ls  :<C-u>CocList -I symbols<CR>

	" }
	
	" autocmd {
		augroup mygroup
		  " Autoformat json file
		  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

		  " Update signature help on jump placeholder.
		  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

		  " Highlight the symbol and its references when holding the cursor.
		  autocmd CursorHold * :call CocActionAsync('highlight')

		  " generate go test unit
		  autocmd FileType go nmap tu :<C-u>CocCommand go.test.generate.function<CR>
	    augroup end
	" }
	
	" floatwindow scroll {
		nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
		nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
		inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
		inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
		vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
		vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
	" }
" }

" coc-snippets {
	imap <C-l> <Plug>(coc-snippets-expand)
	inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" } 

" coc-word {
	let g:coc_word_enabled = 0

	function! CocWordTrigger()
		if !exists("g:coc_word_enabled")
			let g:coc_word_enabled = 0
		endif
		if g:coc_word_enabled==0
			let g:coc_word_enabled = 1
			call coc#config('coc.source.word.enable', 1)
		else
			let g:coc_word_enabled = 0
			call coc#config('coc.source.word.enable', 0)
		endif
	endfunction

	function! CocWordStatus()
		return g:coc_word_enabled ? "10K" : ""
	endfunction

	nnoremap <silent> <Leader>w :<C-u>call CocWordTrigger()<CR>
" }

" coc-yank {
	nnoremap <silent> <Leader>yl :<C-u>CocList -A --normal yank<CR>
	nnoremap <Leader>yc :<C-u>CocCommand yank.clean<CR>
" }

" nerdcommenter {
    let g:NERDSpaceDelims = 1
" }


" vim-header {
    let g:header_auto_add_header = 0
    let g:header_field_timestamp_format = '%Y-%m-%d %H:%M:%S'
    let g:header_field_author = 'Fan Lizhou'
    let g:header_field_author_email = 'cokie@foxmail.com'
    nnoremap <silent> <F7> :AddHeader<CR>
" }


" vim-easy-align {
   	 xmap ga <Plug>(EasyAlign)
   	 nmap ga <Plug>(EasyAlign)
" }

" windows {
   	 map <C-j> <C-w>j
   	 map <C-k> <C-w>k
   	 map <C-l> <C-w>l
   	 map <C-h> <C-w>h
" }

" markdown-preview {
   let g:mkdp_open_to_the_world = 1
   let g:mkdp_open_ip = '0.0.0.0'
   let g:mkdp_port = '8214'
   let g:mkdp_echo_preview_url = 1
   let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }
   nmap mp <Plug>MarkdownPreviewToggle
" }

" lightline {
	set laststatus=2
	let g:lightline = {
		\ 'colorscheme': 'one',
		\ 'active': {
		\	'left':[	['mode', 'paste'],
		\				['readonly', 'filename', 'modified', 'cocstatus', 'cocword']],
		\	'right':[	['lineinfo'],
		\				['percent'],
		\				[ 'fileformat', 'fileencoding', 'filetype']]
		\ },
		\ 'component_function': {
		\	'cocstatus': 'coc#status',
		\	'cocword': 'CocWordStatus'
		\ }
		\}
" }

" NerdTree {
	nnoremap <silent> <F2> :NERDTree<CR>
	let NERDTreeWinSize=18
" }

" vim-floaterm {
	hi FloatermNF guibg=#333333
	let g:floaterm_position      = 'right'
	let g:floaterm_width         = 0.4
	let g:floaterm_height        = 1.0
	let g:floaterm_keymap_new    = '<Leader>ft'
	let g:floaterm_keymap_prev   = '<Leader>fp'
	let g:floaterm_keymap_next   = '<Leader>fn'
	let g:floaterm_keymap_toggle = '<Leader>ff'
	let g:floaterm_keymap_kill   = '<Leader>fd'
" }

" coc-translator {
	nmap <Leader>t <Plug>(coc-translator-p)
	vmap <Leader>t <Plug>(coc-translator-pv)
	" echo
	nmap <Leader>e <Plug>(coc-translator-e)
	vmap <Leader>e <Plug>(coc-translator-ev)
	" replace
	nmap <Leader>r <Plug>(coc-translator-r)
	vmap <Leader>r <Plug>(coc-translator-rv)
" }

" vimspector {
	let g:vimspector_enable_mappings='HUMAN'
	nnoremap <silent> tt :VimspectorReset<CR>
" }

" vim-easymotion {
	let g:EasyMotion_do_mapping = 0 " Disable default mappings

	" Jump to anywhere you want with minimal keystrokes, with just one key binding.
	" `s{char}{label}`
	nmap ff <Plug>(easymotion-overwin-f)
	" or
	" `s{char}{char}{label}`
	" Need one more keystroke, but on average, it may be more comfortable.
	nmap ff <Plug>(easymotion-overwin-f2)

	" Turn on case-insensitive feature
	let g:EasyMotion_smartcase = 1

	" JK motions: Line motions
	map <Leader>j <Plug>(easymotion-j)
	map <Leader>k <Plug>(easymotion-k)
" }

" vim-surround {
	" markdown {
		" color
		xmap mr <Plug>VSurround<font color="red">
		xmap my <Plug>VSurround<font color="#ffa500">
		xmap mb <Plug>VSurround<font color="blue">
		xmap mg <Plug>VSurround<font color="green">
	" }
" }
