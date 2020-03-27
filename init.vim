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
    call minpac#add('junegunn/vim-easy-align')
    call minpac#add('iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } })
    call minpac#add('terryma/vim-multiple-cursors')
    call minpac#add('itchyny/calendar.vim')
    call minpac#add('cinuor/vim-header')
    call minpac#add('voldikss/vim-floaterm')
endfunction

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-yaml',
    \ 'coc-highlight',
    \ 'coc-ultisnips',
    \ 'coc-rls',
    \ 'coc-tabnine',
    \ 'coc-floaterm',
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
    set nocompatible
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
    let mapleader=","

    let g:python_host_skip_check=1
    let g:python_host_prog = '/usr/local/bin/python'
    let g:python3_host_skip_check=1
    let g:python3_host_prog = '/usr/local/bin/python3'
    " nnoremap <space> za
" }

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.

" If you want :UltiSnipsEdit to split your window.

" ultisnips {
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
    let g:UltiSnipsEditSplit="vertical"
    
    " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" } 
    
" coc.nvim {
    " Define some functions that not in coc.nvim
    nnoremap <Plug>(coc-hover) :<C-u>call CocAction("doHover")<CR>

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gt <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> gh <Plug>(coc-hover)

    " Remap keys for rename
    nmap <silent> <leader>rn <Plug>(coc-rename)

    " Remap keys for diagnostic
    nmap <silent> <leader>nw <Plug>(coc-diagnostic-next)
    nmap <silent> <leader>pw <Plug>(coc-diagnostic-prev)
    nmap <silent> <leader>ne <Plug>(coc-diagnostic-next-error)
    nmap <silent> <leader>pe <Plug>(coc-diagnostic-prev-error) 

    " Remap keys for format
    nmap <silent> gf <Plug>(coc-format)
    vmap <silent> gf <Plug>(coc-format-selected)
    
    " Show all diagnostics
    nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
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

    nnoremap <silent> <leader>w :<C-u>call CocWordTrigger()<CR>
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


 " align {
         xmap ga <Plug>(EasyAlign)
         nmap ga <Plug>(EasyAlign)
 " }

 " windows {
         map <C-j> <C-w>j
         map <C-k> <C-w>k
         map <C-l> <C-w>l
         map <C-h> <C-w>h
 " }

 " markdown {
    let g:mkdp_open_to_the_world = 1
    let g:mkdp_open_ip = '0.0.0.0'
    let g:mkdp_port = '8214'
    let g:mkdp_echo_preview_url = 1
    nmap <F5> <Plug>MarkdownPreview
    nmap <F6> <Plug>MarkdownPreviewStop
    " nmap <C-p> <Plug>MarkdownPreviewToggle
 " }

" lightline {
    set laststatus=2
    let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'active': {
        \   'left':[    ['mode', 'paste'],
        \               ['readonly', 'filename', 'modified', 'cocstatus', 'cocword']],
        \   'right':[   ['lineinfo'],
        \               ['percent'],
        \               [ 'fileformat', 'fileencoding', 'filetype']]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status',
        \   'cocword': 'CocWordStatus'
        \ }
        \}
" }

" NerdTree {
    nnoremap <silent> <F2> :NERDTree<CR>
    let NERDTreeWinSize=18
" }

" vim-floaterm {
    hi FloatermNF guibg=#333333
    let g:floaterm_position      = 'center'
    let g:floaterm_keymap_new    = '<leader>ft'
    let g:floaterm_keymap_prev   = '<leader>fp'
    let g:floaterm_keymap_next   = '<leader>fn'
    let g:floaterm_keymap_toggle = '<leader>ff'
" }
