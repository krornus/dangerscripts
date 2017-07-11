" Reset Highlighting
hi clear
if exists("syntax_on")
  syntax reset
endif

" General settings
set background=dark
let g:colors_name="ponyo"

" Editor settings
hi Normal        cterm=none      ctermbg=233  ctermfg=167  gui=none
hi CursorLine    cterm=bold      ctermbg=233  ctermfg=168 gui=bold
hi Cursor        cterm=none      ctermbg=1  ctermfg=0  gui=none
hi LineNr        cterm=none      ctermbg=234  ctermfg=167  gui=none
hi CursorLineNR  cterm=none      ctermbg=235  ctermfg=167 gui=none

" Number column
hi CursorColumn  cterm=none      ctermbg=1  ctermfg=233  gui=none
hi FoldColumn    cterm=none      ctermbg=233  ctermfg=188  gui=none
hi Folded        cterm=none      ctermbg=233  ctermfg=188  gui=none

" Window / Tab delimiters
hi TabLine       cterm=none      ctermbg=233  ctermfg=73  gui=none
hi TabLineFill   cterm=none      ctermbg=233  ctermfg=73  gui=none
hi TabLineSel    cterm=none      ctermbg=233  ctermfg=73  gui=none
hi OverLength    cterm=none      ctermbg=233  ctermfg=1  gui=none

" File navigation / Searching
hi Directory     cterm=none      ctermbg=233  ctermfg=179  gui=none
hi Search        cterm=none      ctermbg=6  ctermfg=168 gui=none
hi IncSearch     cterm=none      ctermbg=73  ctermfg=173  gui=none

" Prompt / Status
hi StatusLine    cterm=none      ctermbg=173  ctermfg=168 gui=none
hi StatusLineNC  cterm=none      ctermbg=168 ctermfg=173  gui=none
hi Title         cterm=none      ctermbg=233  ctermfg=179  gui=none
hi ModeMsg       cterm=bold      ctermbg=233  ctermfg=167 gui=bold

" Visual aid
hi MatchParen    cterm=bold      ctermbg=233  ctermfg=168 gui=none
hi Visual        cterm=none      ctermbg=173  ctermfg=168 gui=none
hi NonText       cterm=none      ctermbg=233  ctermfg=233  gui=none
hi Error         cterm=none      ctermbg=1  ctermfg=167  gui=bold
hi ErrorMsg      cterm=none      ctermbg=1  ctermfg=167  gui=bold
hi Todo          cterm=none      ctermbg=1  ctermfg=73  gui=bold
hi Repeat        cterm=bold      ctermbg=233  ctermfg=1  gui=bold

" Completion menu
hi Pmenu         cterm=none      ctermbg=173  ctermfg=167  gui=none
hi PmenuSel      cterm=none      ctermbg=179  ctermfg=168 gui=none
hi PmenuSbar     cterm=none      ctermbg=179  ctermfg=168 gui=none

" Spelling
hi SpellBad      cterm=underline ctermbg=233  ctermfg=167  gui=none
hi SpellCap      cterm=underline ctermbg=233  ctermfg=167  gui=none
hi SpellRare     cterm=underline ctermbg=233  ctermfg=167  gui=none
hi SpellLocal    cterm=underline ctermbg=233  ctermfg=167  gui=none

" Diff
hi DiffAdd       cterm=none      ctermbg=188  ctermfg=167 gui=none
hi DiffChange    cterm=none      ctermbg=179  ctermfg=173 gui=none
hi DiffDelete    cterm=none      ctermbg=1  ctermfg=167  gui=none
hi DiffText      cterm=none      ctermbg=73  ctermfg=188 gui=none

" General language constructs
hi Statement     cterm=none      ctermbg=233  ctermfg=179  gui=none
hi Keyword       cterm=none      ctermbg=233  ctermfg=179  gui=none
hi Comment       cterm=none      ctermbg=233  ctermfg=188  gui=italic
hi Special       cterm=none      ctermbg=233  ctermfg=179  gui=none
hi Delimiter     cterm=none      ctermbg=233  ctermfg=179  gui=none

" C syntax highlighting
hi PreProc       cterm=none     ctermbg=233  ctermfg=67   gui=none
hi Include       cterm=none     ctermbg=233  ctermfg=67   gui=none
hi Define        cterm=none     ctermbg=233  ctermfg=67   gui=none
hi Macro         cterm=none     ctermbg=233  ctermfg=67   gui=none
hi PreCondit     cterm=none     ctermbg=233  ctermfg=67   gui=none
hi Type          cterm=none     ctermbg=233  ctermfg=179   gui=none
hi String        cterm=none     ctermbg=233  ctermfg=73   gui=none
hi Method        cterm=none     ctermbg=233  ctermfg=188  gui=none
hi Function      cterm=none     ctermbg=233  ctermfg=188  gui=none
hi Symbol        cterm=none     ctermbg=233  ctermfg=179   gui=none
hi Structure     cterm=none     ctermbg=233  ctermfg=179   gui=none
hi StorageClass  cterm=none     ctermbg=233  ctermfg=179   gui=none
hi Typedef       cterm=none     ctermbg=233  ctermfg=179   gui=none
hi Identifier    cterm=none     ctermbg=233  ctermfg=179   gui=none
hi Constant      cterm=none     ctermbg=233  ctermfg=179   gui=none
hi Number        cterm=none     ctermbg=233  ctermfg=188   gui=none
