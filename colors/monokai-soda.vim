" Monokai Soda
" Copyright (c) 2016 Jimmy Zelinskie
"
" Permission is hereby granted, free of charge, to any person
" obtaining a copy of this software and associated documentation
" files (the "Software"), to deal in the Software without
" restriction, including without limitation the rights to use,
" copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the
" Software is furnished to do so, subject to the following
" conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
" OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
" HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
" WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
" FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
" OTHER DEALINGS IN THE SOFTWARE.

set background=dark

" start from default highlights
" I'm not sure why some need manual clearing.
highlight clear
hi clear SignColumn
hi clear CursorLine

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "monokai-soda"

let s:purple   = [135, "#AE81FF"]
let s:yellow   = [228, "#E6DB74"]
let s:pink     = [197, "#f92a72"]
let s:white    = [252, "#cfcfc2"]
let s:gray     = [244, "#75715e"]
let s:darkgray = [238, "#444444"]
let s:black    = ["NONE", "#222222"]
let s:blue     = [81, "#66d9ef"]
let s:green    = [118, "#a6e22e"]
let s:orange   = [208, "#fd971f"]

let s:none       = ["NONE", ""]

function! <SID>set_hi(name, fg, bg, style)
  " Takes a highlight group name, a foreground color, a background color, a
  " style and applies it to both the gui and terminal vim color variables.
  " This function was lifted from Sonja Peterson's 1989 theme.
  execute "hi " . a:name . " ctermfg=" . a:fg[0] . " ctermbg=" . a:bg[0] " cterm=" . a:style
  if a:fg[1] != ""
    execute "hi " . a:name . " guifg=" . a:fg[1]
  endif
  if a:bg[1] != ""
    execute "hi " . a:name . " guibg=" . a:bg[1]
  endif
  execute "hi " . a:name . " gui=" . a:style
endfun

" syntax groups
" help *group-name*
call <SID>set_hi("Comment", s:gray, s:none, "NONE")
call <SID>set_hi("Constant", s:purple, s:none, "bold")
call <SID>set_hi("String", s:yellow, s:none, "NONE")
call <SID>set_hi("Character", s:yellow, s:none, "NONE")
call <SID>set_hi("Number", s:purple, s:none, "NONE")
call <SID>set_hi("Boolean", s:purple, s:none, "NONE")
call <SID>set_hi("Float", s:purple, s:none, "NONE")
call <SID>set_hi("Identifier", s:orange, s:none, "NONE")
call <SID>set_hi("Function", s:green, s:none, "NONE")
call <SID>set_hi("Statement", s:pink, s:none, "bold")
call <SID>set_hi("Conditional", s:pink, s:none, "bold")
call <SID>set_hi("Repeat", s:pink, s:none, "bold")
call <SID>set_hi("Label", s:yellow, s:none, "bold")
call <SID>set_hi("Operator", s:pink, s:none, "NONE")
call <SID>set_hi("Keyword", s:pink, s:none, "bold")
call <SID>set_hi("Exception", s:green, s:none, "bold")
call <SID>set_hi("PreProc", s:green, s:none, "NONE")
call <SID>set_hi("Include", s:green, s:none, "NONE")
call <SID>set_hi("Define", s:blue, s:none, "NONE")
call <SID>set_hi("Macro", s:white, s:none, "italic")
call <SID>set_hi("PreCondit", s:green, s:none, "bold")
call <SID>set_hi("Type", s:blue, s:none, "NONE")
call <SID>set_hi("StorageClass", s:orange, s:none, "italic")
call <SID>set_hi("Structure", s:blue, s:none, "NONE")
call <SID>set_hi("Typedef", s:blue, s:none, "NONE")
call <SID>set_hi("Special", s:blue, s:none, "italic")
call <SID>set_hi("SpecialChar", s:pink, s:none, "bold")
call <SID>set_hi("Tag", s:pink, s:none, "italic")
call <SID>set_hi("Delimiter", s:gray, s:none, "NONE")
call <SID>set_hi("SpecialComment", s:gray, s:none, "bold")
call <SID>set_hi("Debug", s:white, s:none, "bold")
call <SID>set_hi("Underlined", s:gray, s:none, "underline")
call <SID>set_hi("Ignore", s:gray, s:none, "NONE")
call <SID>set_hi("Error", s:black, s:pink, "NONE")
call <SID>set_hi("Todo", s:black, s:yellow, "bold")

" highlight groups
" help *highlight-groups*
call <SID>set_hi("ColorColumn", s:none, s:darkgray, "NONE")
call <SID>set_hi("Conceal", s:white, s:none, "NONE")
call <SID>set_hi("Cursor", s:black, s:white, "NONE")
call <SID>set_hi("CursorIM", s:black, s:white, "NONE")
call <SID>set_hi("CursorColumn", s:none, s:darkgray, "NONE")
call <SID>set_hi("CursorLine", s:none, s:none, "NONE")
call <SID>set_hi("CursorLineNr", s:orange, s:none, "NONE")
call <SID>set_hi("Directory", s:green, s:none, "bold")
call <SID>set_hi("DiffAdd", s:none, s:darkgray, "NONE")
call <SID>set_hi("DiffChange", s:gray, s:black, "NONE")
call <SID>set_hi("DiffDelete", s:pink, s:black, "NONE")
call <SID>set_hi("DiffText", s:none, s:darkgray, "italic,bold")
call <SID>set_hi("ErrorMsg", s:pink, s:black, "bold")
call <SID>set_hi("VertSplit", s:gray, s:black, "bold")
call <SID>set_hi("Folded", s:gray, s:black, "NONE")
call <SID>set_hi("FoldColumn", s:gray, s:black, "NONE")
call <SID>set_hi("SignColumn", s:green, s:none, "NONE")
call <SID>set_hi("IncSearch", s:black, s:yellow, "NONE")
call <SID>set_hi("LineNr", s:gray, s:none, "NONE")
call <SID>set_hi("MatchParen", s:black, s:orange, "bold")
call <SID>set_hi("ModeMsg", s:yellow, s:none, "NONE")
call <SID>set_hi("MoreMsg", s:yellow, s:none, "NONE")
call <SID>set_hi("NonText", s:gray, s:none, "NONE")
call <SID>set_hi("Normal", s:white, s:none, "NONE")
call <SID>set_hi("Pmenu", s:none, s:darkgray, "NONE")
call <SID>set_hi("PmenuSel", s:orange, s:darkgray, "NONE")
call <SID>set_hi("PmenuSbar", s:orange, s:darkgray, "NONE")
call <SID>set_hi("PmenuThumb", s:none, s:none, "NONE")
call <SID>set_hi("Question", s:blue, s:none, "NONE")
call <SID>set_hi("Search", s:black, s:yellow, "NONE")
call <SID>set_hi("SpecialKey", s:gray, s:none, "NONE")
call <SID>set_hi("SpellBad", s:none, s:pink, "NONE")
call <SID>set_hi("SpellCap", s:none, s:purple, "NONE")
call <SID>set_hi("SpellLocal", s:none, s:purple, "NONE")
call <SID>set_hi("SpellRare", s:none, s:none, "NONE")
call <SID>set_hi("StatusLine", s:white, s:darkgray, "NONE")
call <SID>set_hi("StatusLineNC", s:gray, s:black, "NONE")
call <SID>set_hi("TabLine", s:black, s:gray, "NONE")
call <SID>set_hi("TabLineFill", s:black, s:black, "NONE")
call <SID>set_hi("TabLineSel", s:black, s:gray, "NONE")
call <SID>set_hi("Title", s:pink, s:none, "NONE")
call <SID>set_hi("Visual", s:none, s:darkgray, "NONE")
call <SID>set_hi("VisualNOS", s:none, s:darkgray, "NONE")
call <SID>set_hi("WarningMsg", s:white, s:darkgray, "bold")
call <SID>set_hi("WildMenu", s:blue, s:black, "NONE")

" syntastic/neomake signs
call <SID>set_hi("SyntasticErrorSign", s:pink, s:none, "NONE")
call <SID>set_hi("SyntasticWarningSign", s:yellow, s:none, "NONE")
call <SID>set_hi("NeomakeErrorSign", s:pink, s:none, "NONE")
call <SID>set_hi("NeomakeInfoSign", s:blue, s:none, "NONE")
call <SID>set_hi("NeomakeWarningSign", s:yellow, s:none, "NONE")
call <SID>set_hi("ALEErrorSign", s:pink, s:none, "NONE")
call <SID>set_hi("ALEWarningSign", s:yellow, s:none, "NONE")

call <SID>set_hi("LspInformationText", s:gray, s:none, "NONE")
