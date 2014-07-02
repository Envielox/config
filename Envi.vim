" Vim color file
" Maintainer:	Envielox Araconix
" Last Change:	2012 Nov 21

hi clear
"modified from Delek
set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "Envi"

" Normal should come first
hi Normal     guifg=Black  guibg=White
hi Cursor     guifg=bg     guibg=fg

" Note: we never set 'term' because the defaults for B&W terminals are OK
hi DiffAdd    ctermbg=LightBlue    guibg=LightBlue
hi DiffChange ctermbg=LightMagenta guibg=LightMagenta
hi DiffDelete ctermfg=Blue	   ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi DiffText   ctermbg=Red	   guibg=Red
hi Directory  ctermfg=DarkBlue	   guifg=Blue
hi ErrorMsg   ctermfg=White	   ctermbg=DarkRed  guibg=Red	    guifg=White
hi FoldColumn ctermfg=DarkBlue	   ctermbg=Grey     guibg=Grey	    guifg=DarkBlue
hi Folded     ctermbg=Grey	   ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi IncSearch  cterm=reverse	   gui=reverse
hi LineNr     ctermfg=Blue	   guifg=Blue
hi CursorLineNr ctermfg=Blue       guifg=Blue
hi MatchPaern ctermfg=Cyan         guifg=Cyan
hi ModeMsg    cterm=bold	   gui=bold
hi MoreMsg    ctermfg=DarkGreen    gui=bold guifg=SeaGreen
hi NonText    ctermfg=Gray	   gui=bold guifg=gray 
hi Pmenu      guibg=LightBlue
hi PmenuSel   ctermfg=White	   ctermbg=DarkBlue  guifg=White  guibg=DarkBlue
hi Question   ctermfg=DarkGreen    gui=bold guifg=SeaGreen
hi Search     ctermfg=Black	   ctermbg=Yellow guibg=Yellow guifg=Black
hi SpecialKey ctermfg=DarkBlue	   guifg=Blue
hi StatusLine cterm=NONE	   ctermbg=White ctermfg=Black guibg=White guifg=Black
hi StatusLineNC	cterm=NONE         ctermbg=LightGray  ctermfg=Black guibg=LightGray guifg=Black
hi Title      ctermfg=DarkMagenta  gui=bold guifg=Magenta
hi VertSplit  cterm=reverse	   gui=reverse
hi Visual     ctermbg=NONE	   cterm=reverse gui=reverse guifg=Grey guibg=fg
hi VisualNOS  cterm=underline,bold gui=underline,bold
hi WarningMsg ctermfg=DarkRed	   guifg=Red
hi WildMenu   ctermfg=Black	   ctermbg=Yellow   guibg=Yellow guifg=Black

" syntax highlighting
hi Comment    cterm=NONE ctermfg=DarkRed     gui=NONE guifg=red2
hi Constant   cterm=NONE ctermfg=DarkGreen   gui=NONE guifg=green3 guibg=#e0ffe0
hi Identifier cterm=NONE ctermfg=DarkCyan    gui=NONE guifg=cyan4
hi Statement  cterm=NONE ctermfg=DarkBlue    gui=underline guifg=DarkBlue 
" TODO sprawdzić czy wygląda to jakkolwiek sensownie w terminalu
hi PreProc    cterm=NONE ctermfg=DarkMagenta gui=NONE guifg=magenta3
hi Type	      cterm=NONE ctermfg=Blue        gui=NONE guifg=blue
hi Special    cterm=NONE ctermfg=LightRed    gui=NONE guifg=#ff1493 guibg=#ffe4e1
"hi Underlined
"hi Ignore		
"hi Error		
"hi Todo		

" vim: sw=2


"kewordy mogą dostać podkreślenie
"stringi mogą mieć background (np lekko różowy)
"komentarze też
"tło nie białe tylko szarawe ?
