"~/.vimrc or /etc/vim/vimrc

set nocompatible                  " Must come first because it changes other options.

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/tagbar'
Plug 'vim-php/tagbar-phpctags.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'psf/black'
Plug 'wellle/context.vim'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'adelarsq/vim-matchit'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-repeat'

Plug 'godlygeek/tabular'
Plug 'vim-python/python-syntax'
Plug 'preservim/vim-markdown'
Plug 'fatih/vim-go'
Plug 'kchmck/vim-coffee-script'
Plug 'smancill/conky-syntax.vim'
Plug 'derekwyatt/vim-scala'
Plug 'rust-lang/rust.vim'
Plug 'ziglang/zig.vim'
Plug 'chrisbra/csv.vim'
Plug 'alexprengere/edifact.vim'
Plug 'cespare/vim-toml'

Plug 'Valloric/YouCompleteMe', { 'dir': '~/.vim/plugged/YouCompleteMe/', 'do': './install.py' }

"Putting the github/copilot.vim plugin here does not work, as it interferes with YCM.
"We load it manually from the pack/ directory instead, follow instructions from:
" https://github.com/github/copilot.vim

call plug#end()

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
"set cursorline                 "Active une barre horizontale pour indiquer le curseur
set belloff=all

" For WSL2
set ttymouse=sgr

set ttyfast                     "Améliore le rendu
set background=dark             "Couleurs claires pour fond de terminal foncé, change le theme
colorscheme slate               "Colorscheme qui roxx

set autoindent                  "Copy indent from current line when starting a new line
set smartindent                 "Also recognizes some C syntax to manage the indent

set hlsearch                    "Met en surbrillance les résultats d'une recherche
set incsearch                   "Active la recherche incrémentale
set ignorecase                  "Ignore la casse lors de la recherche
set smartcase                   "Sauf si la recherche est cassée

set shiftwidth=4                "Tabs should be converted to a group of 4 spaces.
set softtabstop=4               "Causes backspace to delete 4 spaces=converted <TAB>
set expandtab                   "Replaces a <TAB> with spaces
set smarttab                    "Uses shiftwidth instead of tabstop at start of lines

set wildmenu                                    "Autocompletion qui roxxe en mode commande (:)
set wildmode=list:longest,list:full             "Options qui vont bien
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz    "Patterns to ignore when completing files

set t_kb=    "fix weird backspace behaviour

" Make folding indent sensitive
set foldmethod=indent
set foldcolumn=0                "Barre à gauche de l'écran et gérer les folds avec
set foldlevel=100               "Ouvrir tous les folds à l'ouverture du fichier
                                "Surchargé par le plugin latex-suite pour les .tex

set splitkeep=cursor
set splitbelow

set signcolumn=yes              "Always show gutter, to avoid flickering with ALE linting
set completeopt-=preview        "Do not show autocomplete details in preview window

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

"Speed up markdown plugin
let g:vim_markdown_folding_disabled = 1

"Custom Python syntax highlighting
let g:python_highlight_all=1

"Tagbar options
let Tlist_Ctags_Cmd = '/usr/bin/ctags'  " Pour pouvoir utiliser le plugin taglist
"let g:tagbar_left = 1
let g:tagbar_sort = 0

"Ctrlp
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|build)|\v.egg-info|(\.(swp|swo|pyc|so|dll|exe|ico|git|svn))$'

"Custom YCM
"let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
"let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_disable_signature_help=1

"let g:ale_open_list = 1
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 1
let g:ale_linters = {'python': ['ruff']}
let g:ale_fixers = {'python': ['ruff_format']}

"vim-airline options
set laststatus=2
let g:airline_theme='fairyfloss'

let g:context_enabled = 1

"For a transparent background
hi Normal     guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi clear VertSplit

"hi Todo                     term=bold cterm=bold ctermfg=white     ctermbg=darkyellow guifg=white guibg=darkyellow
hi Error                     term=bold cterm=bold ctermfg=white     ctermbg=red        guifg=white guibg=red
hi Warning                   term=bold cterm=bold ctermfg=white     ctermbg=darkyellow guifg=white guibg=darkyellow
hi ALEVirtualTextError       term=bold cterm=bold ctermfg=red                          guifg=red
hi ALEVirtualTextWarning     term=bold cterm=bold ctermfg=darkyellow                   guifg=darkyellow
hi MatchParen                term=bold cterm=bold ctermfg=yellow    ctermbg=brown  guifg=lightyellow guibg=brown

"set cursor to be a blinking box in normal mode, fixes some issues with WSL
let &t_EI .= "\<Esc>[1 q"
autocmd BufEnter * execute 'silent !echo -ne "' . &t_EI . '"'
