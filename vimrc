"~/.vimrc or /etc/vim/vimrc

set nocompatible                  " Must come first because it changes other options.

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'techlivezheng/tagbar-phpctags'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'ambv/black'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

Plug 'bling/vim-airline'
Plug 'jwhitley/vim-matchit'
Plug 'docunext/closetag.vim'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-abolish'
"Plug 'Lokaltog/vim-easymotion'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jnwhiteh/vim-golang'
Plug 'kchmck/vim-coffee-script'
Plug 'smancill/conky-syntax.vim'
Plug 'derekwyatt/vim-scala'
Plug 'rust-lang/rust.vim'
Plug 'ziglang/zig.vim'
Plug 'chrisbra/csv.vim'
Plug 'alexprengere/edifact.vim'
Plug 'cespare/vim-toml'

Plug 'Valloric/YouCompleteMe', { 'dir': '~/.vim/plugged/YouCompleteMe/', 'do': './install.py' }

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype indent plugin on       "Active les plugins de vim

set encoding=utf-8              "Encodage
set fileencoding=utf-8

syntax on                       "Active la coloration syntaxique
set title                       "Set the terminal window title
set ruler                       "Show lines and columns
set number                      "Active l'affichage des numéros
set mouse=a                     "Active la souris
set backspace=indent,eol,start  "Makes backspace key more powerful
set wrap                        "Retour à la ligne automatique, pas de scroll horizontal
set showcmd                     "Affiche les commandes dans le buffer en mode normal
set showmode                    "Affiche le mode dans le buffer
set showmatch                   "Affiche les délimiteurs fermants correspondants
set showfulltag                 "Get function usage help automatically
set cursorline                 "Active une barre horizontale pour indiquer le curseur
"set cursorcolumn               "Active une barre verticale
"set visualbell                 "Use visual bell instead of beeping
set belloff=all

" For WSL2
set ttymouse=sgr

set ttyfast                     "Améliore le rendu
set background=dark             "Couleurs claires pour fond de terminal foncé, change le theme
colorscheme koehler             "Colorscheme qui roxx

set autoindent                  "Copy indent from current line when starting a new line
set smartindent                 "Also recognizes some C syntax to manage the indent
"set cindent                    "More clever and is configurable to different indenting styles

set hlsearch                    "Met en surbrillance les résultats d'une recherche
set incsearch                   "Active la recherche incrémentale
set ignorecase                  "Ignore la casse lors de la recherche
set smartcase                   "Sauf si la recherche est cassée
"set gdefault                   "Add /g when using %s

set shiftwidth=4                "Tabs should be converted to a group of 4 spaces.
set softtabstop=4               "Causes backspace to delete 4 spaces=converted <TAB>
set expandtab                   "Replaces a <TAB> with spaces
set smarttab                    "Uses shiftwidth instead of tabstop at start of lines

set wildmenu                                    "Autocompletion qui roxxe en mode commande (:)
set wildmode=list:longest,list:full             "Options qui vont bien
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz    "Patterns to ignore when completing files

set t_kb=    "fix weird backspace behaviour

"set splitbelow                  "split horizontally at the bottom
"set splitright                  "split vertically on the right

set previewheight=20            "increase default height for preview window (used by autocomplete)
au BufEnter ?* call PreviewHeightWorkAround()
func! PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

" Make folding indent sensitive
set foldmethod=indent
set foldcolumn=0                "Barre à gauche de l'écran et gérer les folds avec
set foldlevel=100               "Ouvrir tous les folds à l'ouverture du fichier
                                "Surchargé par le plugin latex-suite pour les .tex

" highlight lines too long
augroup aspect
    autocmd BufRead * hi RedundantSpaces ctermbg=darkblue guibg=darkblue
    autocmd BufRead * 2match RedundantSpaces /\s\+$\| \+\ze\t/
augroup END

augroup aspect
    autocmd BufRead *.py hi OverLength ctermbg=darkmagenta guibg=darkmagenta
    autocmd BufRead *.py match OverLength /\%100v.*/
    autocmd BufRead *.py set list             "Affiche les marques invisibles
    autocmd BufRead *.py set listchars=tab:▶- "Convert tabs in nice symbols
augroup END

"Modification de l'autocompletion automatique pour faire apparaitre les sha-bangs
iab #i #include
iab #d #define
iab #b #!/bin/bash
iab #s #!/bin/sh
iab #r #!/usr/bin/ruby
iab #y #!/usr/bin/python
iab #l #!/usr/bin/perl

"Modification du comportement de vim en fonction du type de langage rencontré
autocmd BufNewFile,BufRead  *.md set ft=markdown
autocmd BufNewFile,BufRead  *.html,*.htm set ft=html
autocmd BufNewFile,BufRead  *.php,*.php3 set ft=php
autocmd BufNewFile,BufRead  *.c,*.h set ft=c
autocmd BufNewFile,BufRead  *.pyi,*.pxi set ft=python
autocmd BufNewFile,BufRead  .followup,.article*,.letter,/tmp/mutt*,*.txt set ft=mail
autocmd BufNewFile,BufRead  *.sh set ft=sh
autocmd BufNewFile,BufRead  *.pl set ft=perl
autocmd BufNewFile,BufRead *.edifact,*.edi,*.EDIFACT,*.EDI set ft=edifact
"autocmd BufNewFile,BufRead *.tex set ft=tex               "Documents latex, surchargé par le plugin latex-suite
augroup filetypedetect
    autocmd BufNewFile,BufRead *.tex setlocal spelllang=en,fr
augroup END

autocmd FileType c,cpp,slang set cindent
autocmd FileType make set noexpandtab shiftwidth=8
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"Vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Reglage de la correction orthographique (z= pour afficher les propositions)
set spelllang=en,fr     "Dictionnaires par défaut
set spellsuggest=7      "Nombre de propositions par défaut
"set spell              "Désactivé à l'ouverture du document

"Remappage des touches classiques -- help/recherche/orthographe/numeros/viewports
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
nmap <F3> :set hlsearch!<cr> :set hlsearch?<cr>
map  <F3> :set hlsearch!<cr> :set hlsearch?<cr>
imap <F3> <esc> :set hlsearch!<cr> :set hlsearch?<cr>
nmap <F6> :ALEToggle<CR>
nmap <F7> :set spell!   <cr> :set spell?   <cr>
map  <F7> :set spell!   <cr> :set spell?   <cr>
imap <F7> <esc> :set spell!   <cr> :set spell?   <cr>
nmap <F8> :set nu!      <cr> :set nu?      <cr>
map  <F8> :set nu!      <cr> :set nu?      <cr>
imap <F8> <esc> :set nu!      <cr> :set nu?      <cr>
nmap <F9> <c-w>w
map  <F9> <c-w>w
imap <F9> <esc><c-w>w

"Buffers
map  <c-b> :bnext    <cr>
map  <c-n> :bprevious<cr>

"Remappage pour les plugins taglist et Nerdtree
let mapleader = ","
noremap <leader>b :CtrlPBuffer          <cr>
noremap <leader>l :TagbarToggle         <cr>
noremap <leader>t :NERDTreeToggle       <cr>
noremap <leader>g :UndotreeToggle       <cr>

"Tagbar options
let Tlist_Ctags_Cmd = '/usr/bin/ctags'  " Pour pouvoir utiliser le plugin taglist
"let g:tagbar_left = 1                   " Pour placer le panneau a gauche
let g:tagbar_sort = 0

"Ctrlp
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|build)|\v.egg-info|(\.(swp|swo|pyc|so|dll|exe|ico|git|svn))$'

"Custom snipMate trigger key
imap <c-e> <Plug>snipMateNextOrTrigger
smap <c-e> <Plug>snipMateNextOrTrigger

"Custom YCM
"let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

"let g:ale_open_list = 1
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 0
let g:ale_linters = {'pyopencl': ['flake8'], 'python': ['flake8']}

"vim-airline options
set laststatus=2

"Change csv colors
hi CSVColumnEven      term=bold ctermbg=darkred guibg=darkred ctermfg=grey guifg=grey
hi CSVColumnHeader    term=bold ctermbg=darkred guibg=darkred ctermfg=grey guifg=grey
hi CSVColumnOdd       term=bold ctermbg=blue guibg=blue ctermfg=yellow guifg=yellow
hi CSVColumnHeaderOdd term=bold ctermbg=blue guibg=blue ctermfg=yellow guifg=yellow

"Change highlight line style
hi CursorLine   term=none cterm=none ctermbg=black guibg=black
hi CursorColumn term=none cterm=none ctermbg=black guibg=black

"Modification des couleurs du theme
"Effacement des anciennes configurations
hi clear WhitespaceEOL
hi clear Folded
hi clear FoldColumn
hi clear Search
hi clear Comment
hi clear Statusline
hi clear StatusLineNC
hi clear VertSplit
hi clear wildmenu
hi clear spellbad
hi clear spelllocal
hi clear spellcap
hi clear spellrare
hi clear TabLineSel
hi clear TabLine
hi clear TabLineFill
hi clear Pmenu
hi clear PmenuSel
hi clear SignColumn
"hi clear Todo
hi clear Error

hi LineNr     term=none cterm=none ctermfg=cyan gui=none guifg=cyan

"Gestion des folds -- fold replié + foldcolumn dans la marge de gauche
hi Folded        term=bold cterm=bold ctermfg=brown gui=bold guifg=brown
hi FoldColumn    term=bold cterm=bold ctermfg=white gui=bold guifg=white

"highlight des recherches
hi Search        term=bold cterm=bold ctermfg=white ctermbg=darkgreen guifg=white guibg=darkgreen

"Commentaires
hi Comment       term=none cterm=none ctermfg=darkgrey guifg=darkgrey

"Statusline courante et non-courante, highlight du wildmenu
hi StatusLine    term=bold cterm=bold ctermfg=white    ctermbg=darkgrey gui=bold guifg=white    guibg=darkgrey
hi StatusLineNC  term=bold cterm=bold ctermfg=grey     ctermbg=darkgrey gui=bold guifg=grey     guibg=darkgrey
hi Vertsplit     term=bold cterm=bold ctermfg=white                     gui=bold guifg=white
hi wildmenu      term=bold cterm=bold ctermfg=white    ctermbg=darkblue gui=bold guifg=white    guibg=darkblue

"Correction orthographique
"spellbad word not recognized
"spelllocal wrong spelling for selected region (en_au, en_ca, ...)
"spellcap word not capitalised
"spellrare rare words
hi spellbad      term=bold cterm=bold ctermfg=white ctermbg=darkred     gui=bold guifg=white guibg=darkred
hi spelllocal    term=bold cterm=bold ctermfg=white ctermbg=brown       gui=bold guifg=white guibg=brown
hi spellcap      term=bold cterm=bold ctermfg=white ctermbg=darkmagenta gui=bold guifg=white guibg=darkmagenta
hi spellrare     term=bold cterm=bold ctermfg=white ctermbg=darkblue    gui=bold guifg=white guibg=darkblue

"Barre de tabulation -- sélectionné/autres onglets/barre de fond
hi TabLineSel    term=bold cterm=bold ctermfg=white                  gui=bold guifg=white
hi TabLine       term=bold cterm=bold ctermfg=darkblue ctermbg=white gui=bold guifg=darkblue guibg=white
hi TabLineFill   term=bold cterm=bold                  ctermbg=white gui=bold                guibg=white

"Completion
hi Pmenu        term=bold cterm=bold ctermfg=white ctermbg=darkblue   guifg=white guibg=darkblue
hi PmenuSel     term=bold cterm=bold ctermfg=black ctermbg=yellow     guifg=black guibg=yellow

"Signs column
hi SignColumn   term=bold cterm=bold ctermbg=darkgrey                     guifg=red   guibg=darkgrey
"hi Todo         term=bold cterm=bold ctermfg=white     ctermbg=darkyellow guifg=white guibg=darkyellow
hi Error        term=bold cterm=bold ctermfg=white     ctermbg=red        guifg=white guibg=red
