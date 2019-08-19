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
    call minpac#add('iamcco/mathjax-support-for-mkdp')
    call minpac#add('iamcco/markdown-preview.vim')
    call minpac#add('terryma/vim-multiple-cursors')
    call minpac#add('itchyny/calendar.vim')
    call minpac#add('cinuor/vim-header')
endfunction

let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-yaml',
    \ 'coc-highlight',
    \ 'coc-ultisnips',
    \ 'coc-rls',
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
    " nnoremap <space> za
" }


" coc-snippets {
    " Snippets
    let g:coc_snippet_next = '<c-j>'
    let g:coc_snippet_prev = '<c-k>'


    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
    nmap <silent> fm <Plug>(coc-format)
    vmap <silent> fm <Plug>(coc-format-selected)
    
    " Show all diagnostics
    nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
    " " Search workspace symbols
    " nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
    " " Do default action for next item.
    " nnoremap <silent> <leader>lj  :<C-u>CocNext<CR>
    " " Do default action for previous item.
    " nnoremap <silent> <leader>lk  :<C-u>CocPrev<CR>
" }

" coc-word {
    " nnoremap <Plug>(coc-word) :<C-u>call coc#config('coc.source.word.enable', 1)<CR>
    function! ToggleCocWord():
        echo "1"
    endfunction
    nmap <silent> <leader>wd :<C-u>call ToggleCocWord()<CR>
" }

 " nerdcommenter {
     let g:NERDSpaceDelims = 1
 " }


 " vim-header {
     let g:header_auto_add_header = 0
     let g:header_field_timestamp_format = '%Y-%m-%d'
     let g:header_field_author = 'Fan Lizhou'
     let g:header_field_author_email = 'cokie@foxmail.com'
     map <F7> :AddHeader<CR>    
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
         nmap <silent> <F5> <Plug>MarkdownPreview
         imap <silent> <F5> <Plug>MarkdownPreview
         nmap <silent> <F6> <Plug>StopMarkdownPreview
         imap <silent> <F6> <Plug>StopMarkdownPreview
 " }

" lightline {
    set laststatus=2
    let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'active': {
        \   'left':[    ['mode', 'paste'],
        \               ['readonly', 'filename', 'modified', 'cocstatus']],
        \   'right':[   ['lineinfo'],
        \               ['percent'],
        \               [ 'fileformat', 'fileencoding', 'filetype']]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ }
        \}
" }

" NerdTree {
    nnoremap <silent> <F2> :NERDTree<CR>
    let NERDTreeWinSize=18
" }
