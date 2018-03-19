set nu
set magic
set incsearch
set smartcase
set ignorecase
set showmatch
"" Show trailing whitespace
"set list
"" But only interesting whitespace
"if &listchars ==# 'eol:$'
  "set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
"endif
set ruler
set rtp+=~/.local/share/merlin/vim
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set breakindent
set breakindentopt=shift:0
set showbreak=⌙\ 
set autoindent
set copyindent
"set nocompatible
set hidden
set clipboard+=unnamedplus 
set wrap
set linebreak
set nolist  " list disables linebreaket showtabline=0

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins

call plug#begin('~/.local/share/nvim/plugged')
Plug 'davidhalter/jedi-vim'
Plug 'slashmili/alchemist.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'nixos/nix'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'dag/vim2hs'
Plug 'alx741/vim-hindent'
Plug 'dylanaraps/wal.vim'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'hauleth/blame.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'lervag/vimtex'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'jreybert/vimagit'
Plug 'LnL7/vim-nix'
Plug 'vim-syntastic/syntastic'
Plug 'chrisbra/csv.vim'
Plug 'majutsushi/tagbar'
Plug 'kevinw/pyflakes-vim'
Plug 'vim-airline/vim-airline'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:nord_italic_comments = 1
let g:nord_uniform_status_lines = 1
let g:nord_comment_brightness = 15
let g:nord_uniform_diff_background = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1


autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
let g:asyncomplete_auto_popup = 1

let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete//force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:pyflakes_prefer_python_version = 3
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
set termguicolors
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p
set background=dark
let g:airline_theme='nord'
colorscheme nord 

set rtp+=/nix/store/r1njanpdpmzpvm3grqmlq324x04m904n-merlin-3.0.5/share/ocamlmerlin/vim


if !exists('g:merlin') | let g:merlin = {} | endif | let s:c = g:merlin
let g:merlin_ignore_warnings = "false"

let s:c.merlin_home = expand('<sfile>:h:h:h:h')

" Highlight the expression which type is given
hi def link EnclosingExpr IncSearch
map <C-a> V%y <cr>
let g:syntastic_ocaml_checkers = ['merlin']
map <F3> :noh <cr> 
map <\-g> :MerlinLocate <cr>
set rtp^="/nix/store/xn038jznvbpplsd7a7vghflypc253dxj-ocp-indent-1.6.1/share/ocp-indent/vim"

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords


