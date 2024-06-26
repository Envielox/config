" Modeline {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"}

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

" }

" Keys mapping {
    let mapleader = ',' " \ is terrible idea for a leader
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    nmap <silent> <leader>/ :noh<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    nnoremap K i<CR><Esc>

    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Goes to the other side of next selection (inclusive)
    nnoremap go gvo<ESC>
    " Goes to the end of the nearest selection (inclusive)
    nnoremap ge gn<ESC>
" }

" Plugins {

    " Setup Bundle Support {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype off
        set rtp+=$HOME/.vim/bundle/Vundle.vim
        call vundle#rc()
        " TODO maybe migrate to vim-plug
    " }

    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-surround' " Surrounding words with parentheses and stuff
    Plugin 'scrooloose/nerdtree'
    "Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'ctrlpvim/ctrlp.vim'
    "Plugin 'tacahiroy/ctrlp-funky'
    "Plugin 'rking/ag.vim'   " deprecated
    Plugin 'mileszs/ack.vim'   " deprecated
    "Plugin 'smeggingsmegger/ag.vim'
    "Plugin 'Shougo/unite.vim' " TODO ogarnąć to (zastępuje wszystko O.o)
    Plugin 'mbbill/undotree'
    Plugin 'osyo-manga/vim-over' " Hls durring writing substitues
    Plugin 'tpope/vim-abolish.git' " Conversions between camelCase, snake_case
    " Disabled for google
    "Plugin 'tpope/vim-fugitive' " Git stuff
    " TODO przeczytać manual do fugitive

    " Add/remove/changed markers on the side
    if has('nvim') || has('patch-8.0.902')
      Plugin 'mhinz/vim-signify'
    else
      Plugin 'mhinz/vim-signify', { 'branch': 'legacy' }
    endif


    Plugin 'nathanaelkane/vim-indent-guides' " Colors line indents
    Plugin 'vim-airline/vim-airline' " Cool status line
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'bling/vim-bufferline' " Buffers in status line

    Plugin 'b3niup/numbers.vim'

    "Plugin 'Lokaltog/vim-easymotion' " TODO też ogarnąć
    "Plugin 'unblevable/quick-scope' " Podświetla znaki do f-motion
    "Plugin 'vim-ctrlspace/vim-ctrlspace' "provides nice window with a list of
    "buffers

    "Plugin 'spf13/vim-autoclose' " -- old spf13 version

    Plugin 'jiangmiao/auto-pairs' " -- full features version

    "Plugin 'Townk/vim-autoclose' " -- lite version
    Plugin 'AndrewRadev/sideways.vim' " -- move elements sideways

    Plugin 'vim-scripts/restore_view.vim'
    Plugin 'vim-scripts/regreplop.vim'
    "Plugin 'vim-scripts/sessionman.vim'
    "Plugin 'godlygeek/csapprox' " Allows using gvim colorschemes in terminal
    "Plugin 'kana/vim-textobj-user'
    "Plugin 'kana/vim-textobj-indent'
    "Plugin 'Olical/vim-syntax-expand' " Maaaybe?

    Plugin 'kana/vim-textobj-user'
    Plugin 'sgur/vim-textobj-parameter' " a, for parameters
    Plugin 'Julian/vim-textobj-variable-segment' " av for snake_case_segments

    Plugin 'zenbro/mirror.vim'

    Plugin 'dahu/vim-fanfingtastic'     " F's can go to next line
    Plugin 'tpope/vim-repeat'           " . Works with compound commands
    Plugin 'tpope/vim-unimpaired'       " Some cool mappings
    Plugin 'tpope/vim-speeddating'      " <C-a> works for dates
    "Plugin 'google/vim-searchindex'     " Show search summary
    " Plugin 'ConradIrwin/vim-bracketed-paste'   " No need for set paste
    Plugin 'chrisbra/vim-diff-enhanced' " Better algorithm for diffing
    " Plugin 'kana/vim-smartword'       " Smarter word detection?
    " Plugin 'sk1418/QFGrep'            " Ag on quickfix window
    "


    " General Programming {
       Plugin 'scrooloose/syntastic' " Syntax checker
       Plugin 'A.vim'
       "Plugin 'mattn/webapi-vim' " Using webapi in vim?
       "Plugin 'mattn/gist-vim' " What are gists?
       Plugin 'scrooloose/nerdcommenter' " Commenting source code
       "Plugin 'tpope/vim-commentary' " Alternative to commenting
       Plugin 'godlygeek/tabular' " Aligning text
       if executable('ctags')
           Plugin 'majutsushi/tagbar' " Viewing functions and methods
       endif
       Plugin 'rust-lang/rust.vim'
    " }
    " Snippets & AutoComplete {
        "Plugin 'Shougo/neocomplete.vim'
        if !filereadable(expand('~/.at_google'))
          Plugin 'Valloric/YouCompleteMe'
        endif
        "Plugin 'SirVer/ultisnips'
        Plugin 'honza/vim-snippets'

    "   if count(g:spf13_bundle_groups, 'snipmate')
    "       Bundle 'garbas/vim-snipmate'
    "       Bundle 'honza/vim-snippets'
    "       " Source support_function.vim to support vim-snippets.
    "       if filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
    "           source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
    "       endif
    "   elseif count(g:spf13_bundle_groups, 'youcompleteme')
    "       Bundle 'Valloric/YouCompleteMe'
    "       Bundle 'SirVer/ultisnips'
    "       Bundle 'honza/vim-snippets'
    "   elseif count(g:spf13_bundle_groups, 'neocomplcache')
    "       Bundle 'Shougo/neocomplcache' " Discontinued in favor of deoplete
    "       Bundle 'Shougo/neosnippet'
    "       Bundle 'Shougo/neosnippet-snippets'
    "       Bundle 'honza/vim-snippets'
    "   elseif count(g:spf13_bundle_groups, 'neocomplete')
    "       Bundle 'Shougo/neocomplete.vim.git'
    "       Bundle 'Shougo/neosnippet'
    "       Bundle 'Shougo/neosnippet-snippets'
    "       Bundle 'honza/vim-snippets'
    "   endif
    " }
    " Python {
       "Plugin 'klen/python-mode' " Nice but slow..., need config
       "Plugin 'python-mode/python-mode'
       "Bundle 'python.vim'
    " }
    " JavaScript {
        Plugin 'pangloss/vim-javascript'
        Plugin 'othree/javascript-libraries-syntax.vim'
    " }
    " Yaml {
        Plugin 'stephpy/vim-yaml'
    " }
    " Garbage can {
    " Writing {
    "   Bundle 'reedes/vim-litecorrect'
    "   Bundle 'reedes/vim-textobj-sentence'
    "   Bundle 'reedes/vim-textobj-quote'
    "   Bundle 'reedes/vim-wordy'
    " }
    " Haskell {
        " TODO ogarnąć to
    "   NeoBundle 'dag/vim2hs'
    "   Bundle 'travitch/hasksyn'
    "   Bundle 'dag/vim2hs'
    "   Bundle 'Twinside/vim-haskellConceal'
    "   Bundle 'Twinside/vim-haskellFold'
    "   Bundle 'lukerandall/haskellmode-vim'
    "   Bundle 'eagletmt/neco-ghc'
    "   Bundle 'eagletmt/ghcmod-vim'
    "   Bundle 'Shougo/vimproc'
    "   Bundle 'adinapoli/cumino'
    "   Bundle 'bitc/vim-hdevtools'
    " }
    " HTML {
    "   Bundle 'amirh/HTML-AutoCloseTag'
        " TODO enable in autocommands?
    "   Bundle 'hail2u/vim-css3-syntax'
        "TODO enable later
    "   Bundle 'gorodinskiy/vim-coloresque' " Displays colors inline
    " }
    " }
    " Robot {
        Plugin 'mfukar/robotframework-vim'
    " }
    " Lisp {
        "Plugin 'luochen1990/rainbow'
    " }
    " Behave {
        Plugin 'quentindecock/vim-cucumber-align-pipes'
    " }
    " Golang {
        Plugin 'fatih/vim-go'
    " }

    call vundle#end()
" }

" Plugins Config {

    " NerdTree {
        map <leader>e :NERDTreeFind<CR>
    " }

    " ctrlp {
        let g:ctrlp_working_path_mode = 'ra'
        "nnoremap <silent> <D-t> :CtrlP<CR>
        "nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        " On Windows use "dir" as fallback command.
        if WINDOWS()
            let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
        elseif executable('ag')
            let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
        elseif executable('ack-grep')
            let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
        elseif executable('ack')
            let s:ctrlp_fallback = 'ack %s --nocolor -f'
        else
            let s:ctrlp_fallback = 'find %s -type f'
        endif
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
        \ }

        " CtrlP extensions
        "let g:ctrlp_extensions = ['funky']

        "funky
        "nnoremap <Leader>fu :CtrlPFunky<Cr>
    "}

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        let g:undotree_SetFocusWhenToggle=1
    " }

    " VimOver {
        " Risky stuff for using OverCommandLine
        " Works slovly
        "nnoremap : :OverCommandLine<CR>
        nnoremap <Leader>: :OverCommandLine<CR>
    " }

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    "}

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs<CR>
        vmap <Leader>a,, :Tabularize /,\zs<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }

    " TagBar {
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
        let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
                \ 'p:package',
                \ 'i:imports:1',
                \ 'c:constants',
                \ 'v:variables',
                \ 't:types',
                \ 'n:interfaces',
                \ 'w:fields',
                \ 'e:embedded',
                \ 'm:methods',
                \ 'r:constructor',
                \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
                \ 't' : 'ctype',
                \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
                \ 'ctype' : 't',
                \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
        \ }
    " }

    " indent_guides {
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

    " vim-airline {
        let g:airline_powerline_fonts=1
        let g:airline#extensions#whitespace#symbol = '!'
        let g:airline_theme = 'sol'
    " }

    " A.vim {
        nnoremap <Leader>h :A<CR>
    " }

    " Vim Session {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        "nmap <leader>sl :SessionList<CR>
        "nmap <leader>ss :SessionSave<CR>
        "nmap <leader>sc :SessionClose<CR>
    " }

    " Rainbow {
        let g:rainbow_active = 0
        let g:rainbow_conf = {
        \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
        \   'operators': '_,_',
        \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \   'separately': {
        \       '*': {},
        \       'tex': {
        \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
        \       },
        \       'lisp': {
        \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
        \       },
        \       'vim': {
        \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
        \       },
        \       'html': {
        \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
        \       },
        \       'css': 0,
        \   }
        \}
    " }

    " Vim-Javascript {
        let g:javascript_conceal_function       = "ƒ"
        let g:javascript_conceal_null           = "ø"
        let g:javascript_conceal_this           = "@"
        let g:javascript_conceal_return         = "⇚"
        let g:javascript_conceal_undefined      = "¿"
        let g:javascript_conceal_NaN            = "ℕ"
        let g:javascript_conceal_prototype      = "¶"
        "let g:javascript_conceal_static         = "•"
        let g:javascript_conceal_super          = "Ω"
        let g:javascript_conceal_arrow_function = "⇒"

        let g:used_javascript_libs = 'underscore'
    " }

    " Auto-Pairs {
        "let g:AutoPairsShortcutToggle = '<M-p>'
        let g:AutoPairsShortcutFastWrap = '<C-L>'
        "let g:AutoPairsShortcutJump = '<M-n>'
        "let g:AutoPairsShortcutBackInsert = '<M-b>'
    " }

    " Syntastic {
        let g:syntastic_always_populate_loc_list = 0
        let g:syntastic_auto_loc_list = 0
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0

        " Python
        " let g:syntastic_python_checker_args='--ignore=E501'
        let g:syntastic_python_flake8_post_args='--ignore=E501'
        " long lines, line under indented, missing whitespace around operator
        "let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'
        let g:syntastic_cpp_compiler_options='-std=c++11'
    " }

    " EnhancedDiff {
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
        "set diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
    " }

    " YouCompleteMe {
        let g:ycm_confirm_extra_conf=0  " Don't ask about loading ycm_conf
    " }

    " Ultisnips {
        " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        let g:UltiSnipsExpandTrigger="<c-j>"
        "let g:UltiSnipsListSnippets=""
        let g:UltiSnipsJumpForwardTrigger="<c-j>"
        let g:UltiSnipsJumpBackwardTrigger="<c-k>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

    " }

    " RegReplOp {
        nmap s <Plug>ReplaceMotion
        nmap S <Plug>ReplaceLine
        vmap s <Plug>ReplaceVisual
    " }

    " Ack {
    cnoreabbrev ag Ack
    cnoreabbrev aG Ack
    cnoreabbrev Ag Ack
    cnoreabbrev AG Ack
    if executable('ag')
      let g:ackprg = 'ag --vimgrep --smart-case'
    endif
    " }
  
    " Sideways {
      nnoremap <C-j> :SidewaysLeft<CR>
      nnoremap <C-k> :SidewaysRight<CR>
  
    " }
" }

" General {
    set background=light
    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    " Moved to the very end of file
    "filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set conceallevel=1          " Conceal some words
    set concealcursor=          " Don't conceal on line with cursor
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    set encoding=utf-8
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=cursor,folds,options,slash,unix
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=5000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    "set diffopt+=internal,algorithm:patience " Use better diff algorithm

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Setting up the backups {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " Add exclusions to mkview and loadview
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]
    " }


" }

" Vim UI {
    colo Envi
    set tabpagemax=15
    set showmode
    set cursorline
    set lazyredraw                   " Don't redraw while running macros
    set completeopt-=preview         " Don't open scratch window on completion

    " TODO ogarnąć to sobie
    "highlight clear SignColumn      " SignColumn should match background
    "highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    "set matchpairs+=<:>
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set formatoptions+=j            " Removes comment leader when joining lines

    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

    set spelllang=en,pl
    set guioptions=
    if WINDOWS()
        set guifont=Sauce_Code_Powerline:h11:cEASTEUROPE:qDRAFT
    else
        set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
    endif
" }

" Formatting {
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

" }

" Autocmds {
    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    " Haskell {
    autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell setlocal nospell
    " }

    " Lisp {
    autocmd FileType lisp let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
    " }

    " Python {
    "autocmd FileType python set sw=4 ts=4 expandtab
    " }

    " GoLang {
    autocmd FileType go set sw=4 ts=4 noexpandtab
    " }

    autocmd FileType c,cpp,java,javascript,python,rust autocmd BufWritePre <buffer> call StripTrailingWhitespace()
" }

" Functions {

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME . '/.vim'
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

" }

source ~/.vimrc.local

let did_meta_escape = 1
filetype plugin indent on   " Automatically detect file types.
