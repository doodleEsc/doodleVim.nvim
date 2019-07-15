function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('ncm2/ncm2')
    call minpac#add('roxma/nvim-yarp')

    call minpac#add('filipekiss/ncm2-look.vim')
    call minpac#add('ncm2/ncm2-bufword')
    call minpac#add('ncm2/ncm2-path')
    call minpac#add('ncm2/ncm2-ultisnips')
    call minpac#add('SirVer/ultisnips')
    call minpac#add('honza/vim-snippets')
    call minpac#add('Shougo/echodoc.vim')
    call minpac#add('prabirshrestha/async.vim')
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('ncm2/ncm2-vim-lsp')
    call minpac#add('leafgarland/typescript-vim')

    call minpac#add('cinuor/vim-header')
    call minpac#add('jiangmiao/auto-pairs')
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')
    call minpac#add('scrooloose/nerdcommenter')
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('junegunn/vim-easy-align')
    call minpac#add('iamcco/mathjax-support-for-mkdp')
    call minpac#add('iamcco/markdown-preview.vim')
    call minpac#add('junegunn/fzf')
    call minpac#add('sebdah/vim-delve')
    call minpac#add('heavenshell/vim-pydocstring')
    call minpac#add('terryma/vim-multiple-cursors')
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" neovim {
    syntax enable
    set tabstop=4
    set signcolumn=no
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
    colorscheme monokai-soda
    nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    let g:python3_host_prog='/usr/local/bin/python3'
    " hi Pmenu ctermfg=black ctermbg=gray  guibg=#444444
    " hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff
" }


" ncm2 {
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    set completeopt=noinsert,menuone,noselect
    set shortmess+=c
    " Ctrl+C 退回到普通模式
    inoremap <C-c> <ESC>
    au TextChangedI * call ncm2#auto_trigger()

    " inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<CR>" : "\<CR>")

    " " Use <TAB> to select the popup menu:
    " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }


" look {
    let g:ncm2_look_enabled = 0

    function! Ncm2_look_trigger()
        if !exists("g:ncm2_look_enabled")
            let g:ncm2_look_enabled = 0
        endif
        if g:ncm2_look_enabled==0
            let g:ncm2_look_enabled = 1
        else
            let g:ncm2_look_enabled = 0
        endif
    endfunction

    nnoremap <leader>lo :call Ncm2_look_trigger()<CR>
" }
 
"{
    function! Close_signcolumn()
        if &signcolumn == "no"
            set signcolumn=yes
        else
            set signcolumn=no
        endif
    endfunction
    nnoremap <silent> <leader>sc :call Close_signcolumn()<CR>
"}
 
" ncm2-ultisnips {  
    " inoremap <silent> <expr> <C-k> ncm2_ultisnips#expand_or("\<CR>", 'n')
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

    " imap <C-k> <Plug>(ultisnips_expand)
    " let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger       = "<C-j>"
    let g:UltiSnipsJumpBackwardTrigger      = "<C-k>"
    " let g:UltiSnipsRemoveSelectModeMappings = 0
    " let g:snips_no_mappings = 1
    " let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
" }

" vim-lsp {

    let g:lsp_signs_enabled = 0
    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signs_error = {'text': 'x', 'icon': '~/.config/nvim/icon/error.svg'}
    let g:lsp_signs_warning = {'text': '!', 'icon': '~/.config/nvim/icon/warning.svg'}
    let g:lsp_signs_information = {'text': '@', 'icon': '~/.config/nvim/icon/info.svg'}
    let g:lsp_signs_hint = {'text': '$'}

    function! s:configure_lsp() abort
        setlocal omnifunc=lsp#complete
        nnoremap <buffer> gd :<C-u>LspDefinition<CR>
        nnoremap <buffer> gh :<C-u>LspHover<CR>
        nnoremap <buffer> gt :<C-u>LspTypeDefinition<CR>
        nnoremap <buffer> gr :<C-u>LspReferences<CR>
        nnoremap <buffer> grn :<C-u>LspRename<CR>

        nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
        nnoremap <buffer> gws :<C-u>LspWorkspaceSymbol<CR>

        nnoremap <buffer> gf :<C-u>LspDocumentFormat<CR>
        vnoremap <buffer> grf :LspDocumentRangeFormat<CR>
        nnoremap <buffer> gi :<C-u>LspImplementation<CR>
    endfunction 

    if executable('gopls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ })
        " autocmd FileType go setlocal omnifunc=lsp#complete
        autocmd FileType go call s:configure_lsp()
    endif

    if executable('pyls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
        autocmd FileType python call s:configure_lsp()
    endif
    
    if executable('rls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'rls',
            \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
            \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
            \ 'whitelist': ['rust'],
            \ })
    endif

    if executable('typescript-language-server')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'typescript.tsx'],
            \ })
        autocmd FileType typescript call s:configure_lsp()
    endif
" }

" " LSP {
    " set hidden
    " let g:LanguageClient_autoStart = 1
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

" echodoc {
    set noshowmode
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'signature'
" }

" vim-airline {
    let g:airline_powerline_fonts = 1
    let g:airline_left_sep        = '>'
    let g:airline_right_sep       = '<'
    let g:airline_theme           = 'luna'
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


" NerdTree {
        nnoremap <silent> <F2> :NERDTree<CR>
        let NERDTreeWinSize=18
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

" pydocstring {
        nmap <silent> <C-d> <Plug>(pydocstring)
" }

