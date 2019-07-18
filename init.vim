function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

    call minpac#add('itchyny/lightline.vim')
    call minpac#add('scrooloose/nerdcommenter')

    "function! s:coc_plugins(hooktype, name) abort
    "    execute 'packadd ' . a:name
    "    call coc#util#install()
    "    " call coc#util#install_extension(g:coc_global_extensions)
    "endfunction

endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()


" neovim {
    set tabstop=4
    set signcolumn=yes
    set noshowmode
    set softtabstop=4
    set expandtab
    set shiftwidth=4
    set smarttab
    set colorcolumn=81
    set foldenable
    set foldmethod=syntax
    set foldcolumn=0
    setlocal foldlevel=1
    set foldlevelstart=99
    set termguicolors
    syntax enable
    colorscheme monokai-soda
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    " hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
    " hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff
" }

" lightline {
    let g:lightline = {
        \ 'colorscheme': 'one',
        \ }
" }

" coc.nvim {
    let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-snippets',
        \ 'coc-python',
        \ 'coc-pairs'
        \ ]

    " Snippets
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " To make <cr> select the first completion item and confirm completion when no item have selected:
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

    " Close preview window when completion is done.
    autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    
    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gt <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> grn <Plug>(coc-rename)
" }

" " look {
    " let g:ncm2_look_enabled = 0

    " function! Ncm2_look_trigger()
        " if !exists("g:ncm2_look_enabled")
            " let g:ncm2_look_enabled = 0
        " endif
        " if g:ncm2_look_enabled==0
            " let g:ncm2_look_enabled = 1
        " else
            " let g:ncm2_look_enabled = 0
        " endif
    " endfunction

    " nnoremap <leader>lo :call Ncm2_look_trigger()<CR>
" " }


" " ncm2-ultisnips {  
    " " inoremap <silent> <expr> <C-k> ncm2_ultisnips#expand_or("\<CR>", 'n')
    " inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

    " imap <C-k> <Plug>(ultisnips_expand)
    " let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
    " let g:UltiSnipsJumpForwardTrigger       = "<C-j>"
    " let g:UltiSnipsJumpBackwardTrigger      = "<C-k>"
    " let g:UltiSnipsRemoveSelectModeMappings = 0
    " " let g:snips_no_mappings = 1
    " " let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
" " }

" ncm2-go {
    " let g:ncm2_go#gocode_path = '/usr/local/bin/gocode'
" }

" " LSP {
    " set hidden
    " let g:LanguageClient_rootMarkers = {
        " \ 'go': ['.git', 'go.mod'],
        " \ }

    " let g:LanguageClient_serverCommands = {
        " \ 'python': ['pyls'],
        " \ 'go': ['gopls']
        " \ }


    " " let g:LanguageClient_completionPreferTextEdit = 0
    " " let g:LanguageClient_loggingFile = '/home/fanlz/lc.log'
    " " let g:LanguageClient_loggingLevel = 'DEBUG'
    " nnoremap <C-m> :call LanguageClient_contextMenu()<CR>
    " " Or map each action separately
    " nnoremap <silent> <leader>ho :call LanguageClient#textDocument_hover()<CR>
    " nnoremap <silent> <leader>gd :call LanguageClient#textDocument_definition()<CR>
    " nnoremap <silent> <leader>rn :call LanguageClient#textDocument_rename()<CR>
" " }


" " vim-airline {
    " let g:airline_powerline_fonts = 1
    " let g:airline_left_sep        = '>'
    " let g:airline_right_sep       = '<'
    " let g:airline_theme           = 'luna'
" " }


" " nerdcommenter {
    " let g:NERDSpaceDelims = 1
" " }


" " vim-header {
    " let g:header_auto_add_header = 0
    " let g:header_field_timestamp_format = '%Y-%m-%d'
    " let g:header_field_author = 'Fan Lizhou'
    " let g:header_field_author_email = 'cokie@foxmail.com'
    " map <F7> :AddHeader<CR>    
" " }


" " NerdTree {
        " nnoremap <silent> <F2> :NERDTree<CR>
" " }


" " align {
        " xmap ga <Plug>(EasyAlign)
        " nmap ga <Plug>(EasyAlign)
" " }

" " windows {
        " map <C-j> <C-w>j
        " map <C-k> <C-w>k
        " map <C-l> <C-w>l
        " map <C-h> <C-w>h
" " }

" " markdown {
        " nmap <silent> <F5> <Plug>MarkdownPreview
        " imap <silent> <F5> <Plug>MarkdownPreview
        " nmap <silent> <F6> <Plug>StopMarkdownPreview
        " imap <silent> <F6> <Plug>StopMarkdownPreview
" " }

" " pydocstring {
        " nmap <silent> <C-d> <Plug>(pydocstring)
" " }
