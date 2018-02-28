
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Name:           kalisi
" Author:         Arthur Jaron
" EMail:          hifreeo@gmail.com
" Version:        0.8.0
" Last Change:    2015.09.27
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Settings
if !exists('g:kalisi_recolor_quickfixsigns')
  let g:kalisi_recolor_quickfixsigns = 1
endif

hi clear
let g:colors_name = "kalisi"




" HTML Closing tags </...> 
" Vim variables
" HTML Starting tags <...>

" operator cpp: sizeof()
"html: special keywords in jscript: window log


" vim: lots of links
" c: int char void
" html: class href id
hi Type             guifg=#5d8fbe gui=none ctermfg=67
" c: struct
" py:  self __name__ Error Exception   and is not
" cpp: static cast

hi SpecialKey          guifg=#767676 guibg=#3a3a3a ctermbg=243 ctermfg=237
hi StatusLine       guifg=#b5b5b5 guibg=#222222 gui=none term=NONE cterm=NONE

hi markdownUrl guifg=#0087ff gui=underline ctermfg=33 cterm=underline

" mail
hi mailSubject         ctermfg=226    guifg=#ffff00
hi mailQuoted1        ctermfg=189    guifg=#d7d7ff
hi mailQuoted2        ctermfg=194 guifg=#d7ffd7
hi mailQuoted3        ctermfg=105 guifg=#8787ff
hi mailQuoted4        ctermfg=120    guifg=#87ff87
hi mailQuoted5        ctermfg=62    guifg=#5f5fd7
hi mailQuoted6        ctermfg=77    guifg=#5fd75f

" https://github.com/scrooloose/nerdtree
hi NERDTreeDir      guifg=#5d8fbe ctermfg=67
hi NERDTreeClosable guifg=#66b600 guibg=#385038 gui=bold ctermfg=70 ctermbg=22 cterm=bold
hi NERDTreePart     guifg=#707070 ctermfg=243
hi NERDTreePartFile guifg=#FFFFFF gui=bold ctermfg=231 cterm=bold
hi NERDTreeLinkFile guifg=#ffaf00 ctermfg=214
hi NERDTreeLinkDir  guifg=#ffaf00 ctermfg=214

" https://github.com/majutsushi/tagbar
hi TagbarScope      guifg=#0087d7 gui=bold ctermfg=32 cterm=bold
hi TagbarType       guifg=#66b600 gui=bold ctermfg=70 cterm=bold
hi TagbarKind       guifg=#7ad6ff ctermfg=117

" https://github.com/justinmk/vim-sneak
hi SneakPluginTarget guibg=#ff5f00 guifg=#ffff00 ctermbg=202 ctermfg=226

" https://github.com/rhysd/clever-f.vim
hi CleverFDefaultLabel guibg=#5fd700 guifg=#404040 gui=bold ctermbg=76 ctermfg=238 cterm=bold

" https://github.com/mhinz/vim-startify
hi StartifyBracket  guifg=#0087d7 guibg=#303030 gui=bold ctermfg=32 ctermbg=236 cterm=bold
hi StartifyFile     guifg=#00afff ctermfg=39
hi StartifyHeader   guifg=#00afff ctermfg=39
hi StartifyNumber   ctermfg=215 guifg=#00d700 guibg=#303030 gui=bold ctermfg=40 ctermbg=236 cterm=bold
hi StartifyPath     guifg=#949494 ctermfg=246
hi StartifySlash    guifg=#dadada ctermfg=253
hi StartifySpecial  guifg=#b2b2b2 guibg=#606060 ctermfg=249 ctermbg=241

" https://github.com/davidhalter/jedi-vim
hi jediFunction     guibg=#303030 guifg=#767676 ctermbg=236 ctermfg=243
hi  jediFat         guibg=#303030  guifg=#afd700 gui=bold ctermbg=236 ctermfg=148 cterm=bold

" https://github.com/tomtom/quickfixsigns_vim
if g:kalisi_recolor_quickfixsigns == 1
 hi QFSignsMark       guifg=#ffc63f guibg=#202020 gui=bold ctermfg=220 ctermbg=234 cterm=bold
 hi QFSignsDiffAdd    guifg=#108f4f guibg=#324832 ctermfg=35 ctermbg=22
 hi QFSignsDiffChange guifg=#336fdf guibg=#20385f ctermfg=27 ctermbg=17
 hi QFSignsDiffDelete guifg=#d75f5f guibg=#872222 ctermfg=167 ctermbg=88
 let g:quickfixsigns#marks#texthl = "QFSignsMark"
 let g:quickfixsigns#vcsdiff#highlight = {'DEL': 'QFSignsDiffDelete', 'ADD': 'QFSignsDiffAdd', 'CHANGE': 'QFSignsDiffChange'}
endif

" 256 Color Terminal (dark) ##################################################
if &t_Co > 255
hi Normal ctermbg=233 ctermfg=252
hi CursorLine ctermbg=239 term=none cterm=none
hi CursorColumn ctermbg=239
hi NonText ctermbg=237 ctermfg=102
hi Conceal ctermbg=237 ctermfg=230
hi Comment ctermfg=245
hi CommentURL cterm=underline ctermfg=68
hi CommentEmail cterm=underline ctermfg=68
hi Constant cterm=bold ctermfg=214
hi String ctermfg=220
hi Character ctermfg=171
hi Number ctermfg=214
hi Boolean ctermfg=149
hi Float ctermfg=227
hi Identifier ctermfg=37 cterm=none
hi Function ctermfg=117
hi Statement cterm=bold ctermfg=149
hi Conditional cterm=bold ctermfg=110
hi Repeat cterm=bold ctermfg=110
hi Label cterm=bold ctermfg=35
hi Operator ctermfg=67
hi Keyword ctermfg=158
hi Exception cterm=bold ctermfg=32
hi PreProc cterm=bold ctermfg=33
hi Include cterm=bold ctermfg=33
hi Define cterm=bold ctermfg=33
hi Macro ctermfg=140
hi PreCondit ctermfg=110
hi Type ctermfg=67
hi StorageClass ctermfg=71 cterm=none
hi Structure ctermfg=67
hi Typedef ctermfg=72
hi Special ctermfg=194 cterm=none
hi SpecialChar ctermfg=69 cterm=none
hi Tag cterm=bold ctermfg=39
hi Delimiter ctermfg=104
hi SpecialComment cterm=bold ctermfg=67
hi Debug cterm=bold ctermfg=184
hi Underlined cterm=underline ctermfg=249
hi Todo cterm=bold ctermbg=94 ctermfg=227
hi Directory cterm=bold ctermfg=252
hi DiffAdd ctermbg=22
hi DiffChange ctermbg=239
hi DiffText cterm=bold ctermbg=18 ctermfg=254
hi DiffDelete cterm=none ctermbg=237 ctermfg=238
hi SpellBad cterm=undercurl ctermfg=203 ctermbg=none
hi SpellCap cterm=undercurl ctermfg=33 ctermbg=none
hi SpellLocal cterm=undercurl ctermfg=51 ctermbg=none
hi SpellRare cterm=undercurl ctermfg=205 ctermbg=none
hi Search cterm=bold ctermbg=148 ctermfg=16
hi IncSearch cterm=reverse ctermbg=16 ctermfg=220
hi Error cterm=underline ctermbg=52 ctermfg=217
hi ErrorMsg cterm=bold ctermbg=88 ctermfg=224
hi WarningMsg ctermfg=221
hi WildMenu ctermbg=148 ctermfg=16
hi Question ctermbg=148 ctermfg=16
hi MoreMsg ctermbg=148 ctermfg=16
hi ModeMsg cterm=bold ctermbg=148 ctermfg=16
hi Cursor ctermbg=0 ctermfg=1 cterm=none
hi CursorLineNr cterm=bold ctermbg=234 ctermfg=252
hi MatchParen ctermbg=None ctermfg=227 cterm=bold
hi Visual ctermbg=24
hi VisualNOS ctermbg=239
hi Pmenu ctermbg=236 ctermfg=249
hi PmenuSel ctermbg=148 ctermfg=235
hi PmenuSbar ctermbg=247
hi PmenuThumb ctermbg=240
hi SignColumn ctermbg=236 ctermfg=148
hi FoldColumn cterm=bold ctermbg=236 ctermfg=145
hi Folded ctermbg=236 ctermfg=243
hi LineNr ctermbg=236 ctermfg=244
hi StatusLine ctermbg=235 ctermfg=230 term=NONE cterm=NONE
hi StatusLineNC ctermbg=236 ctermfg=244 term=NONE cterm=NONE
hi VertSplit ctermbg=235 ctermfg=234
hi Title cterm=bold ctermfg=252
hi TabLine ctermbg=22 ctermfg=148 cterm=none
hi TabLineSel ctermbg=148 ctermfg=22 cterm=none
hi TabLineFill ctermbg=247 ctermfg=236 cterm=none
hi PythonOperator ctermfg=110
hi pythonDocstring ctermfg=67
hi pythonDoctest ctermfg=97
hi javaScript ctermfg=151
hi DjangoBlock ctermfg=35 cterm=none
hi CtrlPMatch ctermbg=220 ctermfg=16
" for the reason behind this, see
" https://github.com/tomasr/molokai/issues/22
set background=dark
endif
