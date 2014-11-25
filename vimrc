"~/.vimrc ou /etc/vim/vimrc
"Fichier de configuration principal de vim 7
"Révision -- 4 septembre 2009

set nocompatible                  " Must come first because it changes other options.
filetype off                      " Necessary on some Linux distros for pathogen to properly load bundles

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()
let g:vundle_default_git_proto='git'

Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'techlivezheng/tagbar-phpctags'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'

Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'Valloric/YouCompleteMe'
"Bundle 'ervandew/supertab'

Bundle 'jwhitley/vim-matchit'
Bundle 'docunext/closetag.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-abolish'
Bundle 'Lokaltog/vim-easymotion'

Bundle 'jnwhiteh/vim-golang'
Bundle 'plasticboy/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'chrisbra/csv.vim'

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
set list                        "Affiche les marques invisibles
set listchars=tab:▶-            "Convert tabs in nice symbols
set cursorline                 "Active une barre horizontale pour indiquer le curseur
"set cursorcolumn               "Active une barre verticale
"set visualbell                 "Use visual bell instead of beeping

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

set shiftwidth=4                "Tabs should be converted to a group of 8 spaces.
set tabstop=4                   "Avec << et >>
set softtabstop=4               "Causes backspace to delete 8 spaces=converted <TAB>
set expandtab                   "Replaces a <TAB> with spaces
set smarttab                    "Uses shiftwidth instead of tabstop at start of lines

set wildmenu                                    "Autocompletion qui roxxe en mode commande (:)
set wildmode=list:longest,list:full             "Options qui vont bien
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz    "Patterns to ignore when completing files

set t_kb=    "fix weird backspace behaviour

set splitbelow                  "split horizontally at the bottom
set splitright                  "split vertically on the right

set previewheight=20            "increase default height for preview window (used by autocomplete)
au BufEnter ?* call PreviewHeightWorkAround()
func! PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

"Code folding za-zR-zM
"function! MyFoldFunction()                      "Definition personnelle d'une fonction de fold
"        let line = getline(v:foldstart)
"        let sub = substitute(line,'/\*\|\*/\|^\s+', '', 'g')
"        let lines = v:foldend - v:foldstart + 1
"        return v:folddashes.sub.'...'.lines.' lines...'.getline(v:foldend)
"endfunction
"set foldmethod=syntax                   "Fold par syntaxe
"set foldtext=MyFoldFunction()           "Fold avec MyFoldFunction
set foldlevel=100                       "Ouvrir tous les folds à l'ouverture du fichier
                                        "Surchargé par le plugin latex-suite pour les .tex
set foldcolumn=0                       "Barre à gauche de l'écran et gérer les folds avec
" Make folding indent sensitive
set foldmethod=indent

" Highlight lines too long
augroup aspect
    autocmd BufRead * highlight RedundantSpaces ctermbg=darkblue guibg=darkblue
    autocmd BufRead * 2match RedundantSpaces /\s\+$\| \+\ze\t/
augroup END

augroup aspect
    autocmd BufRead *.py highlight OverLength ctermbg=darkgray guibg=darkgray
    autocmd BufRead *.py match OverLength /\%80v.*/
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
autocmd BufRead  *.md set ft=markdown
autocmd BufRead  *.html,*.htm set ft=html
autocmd BufRead  *.php,*.php3 set ft=php
autocmd BufRead  *.c,*.h set ft=c
autocmd BufRead  .followup,.article*,.letter,/tmp/mutt*,*.txt set ft=mail
autocmd BufRead  *.sh set ft=sh
autocmd BufRead  *.pl set ft=perl
"autocmd BufRead *.tex set ft=tex               "Documents latex, surchargé par le plugin latex-suite
augroup filetypedetect
        autocmd BufNewFile,BufRead *.tex setlocal spelllang=en,fr
augroup END

autocmd FileType c,cpp,slang set cindent
autocmd FileType make set noexpandtab shiftwidth=8

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
nmap <F5> :lprevious       <cr>
map  <F5> :lprevious       <cr>
imap <F5> <esc> :lprevious <cr>
nmap <F6> :lnext       <cr>
map  <F6> :lnext       <cr>
imap <F6> <esc> :lnext <cr>
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
noremap <leader>g :GundoToggle          <cr>

"Tagbar options
let Tlist_Ctags_Cmd = '/usr/bin/ctags'  " Pour pouvoir utiliser le plugin taglist
"let g:tagbar_left = 1                   " Pour placer le panneau a gauche

"Syntastic options
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=2 "Set to 1 to automatically open :Errors
let g:syntastic_python_checker_args = '--rcfile=~/.pylintrc'
let g:syntastic_javascript_jsl_conf='-conf ~/.jsl.conf'

"Ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|build)|\v.egg-info|(\.(swp|swo|pyc|so|dll|exe|ico|git|svn))$'

"Custom snipMate trigger key
imap <c-e> <Plug>snipMateNextOrTrigger
smap <c-e> <Plug>snipMateNextOrTrigger

"Custom YCM
"let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

"Supertab options
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview

" Markdown options
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

"Change highlight line style
highlight CursorLine   cterm=bold ctermbg=darkgray guibg=darkgray
highlight CursorColumn cterm=bold ctermbg=darkgray guibg=darkgray

"Modification des couleurs du theme
"Effacement des anciennes configurations
highlight clear WhitespaceEOL
highlight clear Folded
highlight clear FoldColumn
highlight clear Search
highlight clear Comment
highlight clear Statusline
highlight clear StatusLineNC
highlight clear VertSplit
highlight clear wildmenu
highlight clear spellbad
highlight clear spelllocal
highlight clear spellcap
highlight clear spellrare
highlight clear TabLineSel
highlight clear TabLine
highlight clear TabLineFill
highlight clear Pmenu
highlight clear PmenuSel
highlight clear SignColumn
"highlight clear Todo
highlight clear Error

"Affiche en rouge les espaces et tabulations de fin de ligne
"highlight WhitespaceEOL ctermbg=blue
"match     WhitespaceEOL /\s\+$/

"Gestion des folds -- fold replié + foldcolumn dans la marge de gauche
highlight Folded        term=bold cterm=bold ctermfg=brown gui=bold guifg=brown
highlight FoldColumn    term=bold cterm=bold ctermfg=white gui=bold guifg=white

"Highlight des recherches
highlight Search        term=bold cterm=bold ctermfg=white ctermbg=darkgreen guifg=white guibg=darkgreen

"Commentaires
highlight Comment       term=bold cterm=bold ctermfg=darkgrey guifg=darkgrey

"Statusline courante et non-courante, highlight du wildmenu
highlight StatusLine    term=bold cterm=bold ctermfg=white    ctermbg=darkgrey gui=bold guifg=white    guibg=darkgrey
highlight StatusLineNC  term=bold cterm=bold ctermfg=grey     ctermbg=darkgrey gui=bold guifg=grey     guibg=darkgrey
highlight Vertsplit     term=bold cterm=bold ctermfg=white                     gui=bold guifg=white
highlight wildmenu      term=bold cterm=bold ctermfg=white    ctermbg=darkblue gui=bold guifg=white    guibg=darkblue

"Correction orthographique
"spellbad word not recognized
"spelllocal wrong spelling for selected region (en_au, en_ca, ...)
"spellcap word not capitalised
"spellrare rare words
highlight spellbad      term=bold cterm=bold ctermfg=white ctermbg=darkred     gui=bold guifg=white guibg=darkred
highlight spelllocal    term=bold cterm=bold ctermfg=white ctermbg=brown       gui=bold guifg=white guibg=brown
highlight spellcap      term=bold cterm=bold ctermfg=white ctermbg=darkmagenta gui=bold guifg=white guibg=darkmagenta
highlight spellrare     term=bold cterm=bold ctermfg=white ctermbg=darkblue    gui=bold guifg=white guibg=darkblue

"Barre de tabulation -- sélectionné/autres onglets/barre de fond
highlight TabLineSel    term=bold cterm=bold ctermfg=white                  gui=bold guifg=white
highlight TabLine       term=bold cterm=bold ctermfg=darkblue ctermbg=white gui=bold guifg=darkblue guibg=white
highlight TabLineFill   term=bold cterm=bold                  ctermbg=white gui=bold                guibg=white

"Completion
highlight Pmenu        term=bold cterm=bold ctermfg=white ctermbg=darkblue   guifg=white guibg=darkblue
highlight PmenuSel     term=bold cterm=bold ctermfg=black ctermbg=darkyellow guifg=black guibg=darkyellow

"Signs column
highlight SignColumn   term=bold cterm=bold ctermbg=darkgrey                     guifg=red   guibg=darkgrey
"highlight Todo         term=bold cterm=bold ctermfg=white     ctermbg=darkyellow guifg=white guibg=darkyellow
highlight Error        term=bold cterm=bold ctermfg=white     ctermbg=red        guifg=white guibg=red

