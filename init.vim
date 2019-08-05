function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

    " snipet
    call minpac#add('SirVer/ultisnips')
    call minpac#add('honza/vim-snippets')

    " statusline
    call minpac#add('itchyny/lightline.vim')

    " tools
    call minpac#add('scrooloose/nerdcommenter')
    call minpac#add('scrooloose/nerdtree')
endfunction

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-ultisnips',
    \ 'coc-python',
    \ ]

function! CocBuildUpdate()
    call coc#util#install()
    call coc#util#install_extension(g:coc_global_extensions)
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
command! ExtensionUpdate call CocBuildUpdate()

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

" NerdTree {
    nnoremap <silent> <F2> :NERDTree<CR>
    let NERDTreeWinSize=18
" }

" coc.nvim {
    " Snippets
    let g:coc_snippet_next = '<c-j>'
    let g:coc_snippet_prev = '<c-k>'


    "inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<C-n>"
    "inoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<C-p>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gt <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Remap keys for rename
    nmap <silent> rn <Plug>(coc-rename)

    " Remap keys for diagnostic
    nmap <silent> dn <Plug>(coc-diagnostic-next)
    nmap <silent> dp <Plug>(coc-diagnostic-prev)
    nmap <silent> dne <Plug>(coc-diagnostic-next-error)
    nmap <silent> dnp <Plug>(coc-diagnostic-prev-error) 

    " Remap keys for format
    nmap <silent> fm <Plug>(coc-format)
    vmap <silent> fm <Plug>(coc-format-selected)
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

 " windows {
         map <C-j> <C-w>j
         map <C-k> <C-w>k
         map <C-l> <C-w>l
         map <C-h> <C-w>h
 " }

" " markdown {
        " nmap <silent> <F5> <Plug>MarkdownPreview
        " imap <silent> <F5> <Plug>MarkdownPreview
        " nmap <silent> <F6> <Plug>StopMarkdownPreview
        " imap <silent> <F6> <Plug>StopMarkdownPreview
" " }

" " pydocstring {
        " nmap <silent> <C-d> <Plug>(pydocstring)
" " }
