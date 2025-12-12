" ================ Plugins! ======================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

    " :PlugInstall is required. Along with a source %
    " Initialize List of plugins...
call plug#begin()

    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree'

    " Why we theme
    Plug 'flazz/vim-colorschemes'
    Plug 'morhetz/gruvbox'

    " Fuzzy Finder
    Plug '~/.fzf'

    " Any Jump
    Plug 'ABD-01/any-jump.vim'

    " Super easy commenting, toggle comments etc
    Plug 'scrooloose/nerdcommenter'

    " Git wrapper inside Vim
    Plug 'tpope/vim-fugitive'

call plug#end()

" ================ Settings ======================
set mouse=a
set noswapfile     "no swap files
set t_vb=
set number         "Show line numbers              
syntax on

set showmatch      "automatically highlight matching braces/brackets/etc.
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"
set splitbelow          " This will cause all splits to happen below (including terminal).
set splitright
set scrolloff=8
set whichwrap=<,>,h,l     " Cursor Movement in Vim when hit the end of line ref: https://vim.works/2019/03/03/cursor-movement-in-vim/

set switchbuf=vsplit    " To open buffer from quickfix list in vsplit (sideeffects are not testes)
                        " ref: https://stackoverflow.com/a/71592986

augroup QuickfixSplit
  autocmd!
  autocmd FileType qf nnoremap <buffer> <leader><CR> <C-w><Enter><C-w>L
augroup END

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
set rtp+=~/.fzf

" ================ Mappings ======================
" " Probably NOT a good idea
" "nnoremap <F2> :set invpaste paste?<CR>
nnoremap ; :
" "Spacemacs Esc
inoremap jk <ESC>

" SET LEADER
let mapleader=" "
" let maplocalleader = "\\"
map <leader>n :new<cr>
map <leader>i I

" toggle relative numbering
nnoremap <leader>rn :set rnu!<CR>

" (Shift)Tab (de)indents code
vnoremap <Tab> >
vnoremap <S-Tab> <

"  w wq q   --  Quick Save
" nmap <Leader>w :w<CR>
nmap <C-s> :w<CR>
" nmap <Leader>q :q<CR>
nmap <leader>x :bd<CR>
" nmap <Leader>wq :wq<CR>
nmap <Leader>Q :q!<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" NERDtree Key bound to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" Terminal Shortcuts
tmap <C-h> <C-w>h
tmap <C-j> <C-w>j
tmap <C-k> <C-w>k
"tmap <C-l> <C-w>l
tnoremap jk <C-W>N

" copy file name
nmap <Leader>fn :let @* = expand("%")<CR>
nmap <Leader>fp :let @* = expand("%:p")<CR>

" Open tag in vsplit
nnoremap <Leader><C-]> :vert winc ]<CR>

" For some reason enter is mapped to comment so undoing it.
" default behavior of enter (<CR>) is same as + (Move down one line, to first non-blank character)
" nnoremap <CR> +


" More Stuff
" Vim jump to the last position when reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
endif

" ================ Indentation ======================

" set autoindent "Set in vim-sensible
set smartindent       "Smart autoindenting on new line
set nowrap                      " don't wrap lines
set smarttab          "Respect space/tab settings
" set softtabstop=2
set tabstop=2
set backspace=indent,eol,start     "allow backspacing everything in insert mode, also in vim-sensible
set textwidth=70
set formatoptions+=t 
set tabstop=4 softtabstop=4 " 1 tab == 4 spaces
set shiftwidth=4 " 1 tab == 4 spaces
set expandtab " Use spaces instead of tabs
"
"================== Vim Theme =========================== 
colorscheme gruvbox
" other good ones: gruvbox, default, moonshine, emacs, materialbox, space-vim, molokai, dracula
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" ================ Searches ============================
set incsearch      " do incremental searching
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital


" anyjump
let g:any_jump_search_prefered_engine = 'rg'

" Commenting
let g:NERDCreateDefaultMappings = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '// ','right': '' } }
