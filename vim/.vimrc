" By May 2025, it has been 2 years since I began using VIM.
" this configuration has evolved through multiple iterations,
" reflecting on other's vimrc, workflow requirement, personal taste
" and pieces of legacy configs.

" References were taken from:
" - https://github.com/HaoZeke/Dotfiles/blob/master/dotfiles/common/.vimrc
" few mappings from : https://github.com/JJGO/dotfiles/blob/master/vim/.vimrc
" and many more

" Other reference for using vim
" - https://freshman.tech/vim-quickfix-and-location-list/
" - https://vi.stackexchange.com/questions/14820/shortcut-to-open-definition-of-variable-in-a-vertical-split
" - https://gist.github.com/mahemoff/8967b5de067cffc67cec174cb3a9f49d

" My most favourite plugins: tpope/vim-fugitive and scrooloose/nerdtree
" Favourite Themes: gruvbox, dracula and molokai
" Most used mappings:
" 1. jk mapped to <ESC>
" 2. ; mapped to :
" 3. Ctrl-N mapped to Nerdtree
" 4. <space> x mapped to buffer close

" ================ Plugins! ======================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

    " :PlugInstall is required. Along with a source %
    " Initialize List of plugins...
call plug#begin()
    " The basis."
    Plug 'tpope/vim-sensible'

  " YCM is not working for me
  "  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } | Plug 'l3nkz/ycmtex' 
  "  autocmd! User YouCompleteMe call youcompleteme#Enable()

    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    "Plug 'unkiwii/vim-nerdtree-sync'  " to sync the current file

    " Because everything must be tracked
    Plug 'wakatime/vim-wakatime'

    " Easy motions.
    Plug 'Lokaltog/vim-easymotion'

    " Super easy commenting, toggle comments etc
    Plug 'scrooloose/nerdcommenter'

    " Autoclose (, " etc
    Plug 'Townk/vim-autoclose'

    " Git wrapper inside Vim
    Plug 'tpope/vim-fugitive'

   "  " Handle surround chars like ''
    Plug 'tpope/vim-surround'

    " Align your = etc.
    " Plug 'vim-scripts/Align'

   "  " Better Minibuff Kinda Pointless?
    " Plug 'weynhamz/vim-plugin-minibufexpl'

    " Julia
    Plug 'JuliaLang/julia-vim'

   "  " Less
    " Plug 'groenewege/vim-less' 

    " Movement
    Plug 'matze/vim-move'
    
    " Git Stuff
    Plug 'airblade/vim-gitgutter'

    " Not that powerline isn't perfect... right?
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Undo tree
    " Plug 'vim-scripts/Gundo'
    " Plug 'mbbill/undotree' " Gundo not working


    " Why we theme
    " Plug 'tomasr/molokai'
    Plug 'flazz/vim-colorschemes'
    Plug 'dracula/vim', { 'as': 'dracula' }

    "File searching with faster matching
    " Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'FelikZ/ctrlp-py-matcher'

    " Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug '~/.fzf'

   "  " Respect Common Editorconfig stuff
   "  " Plug 'editorconfig/editorconfig-vim'
   "  
   "  " Markdown
   "  "Plug 'tpope/vim-markdown'
   "  "Plug 'godlygeek/tabular'
   "  "Plug 'plasticboy/vim-markdown'
   "   " Plug 'gabrielelana/vim-markdown'
   "  
   "  " Completion --> Obsoleted by YouCompleteMe
   " " Plug 'othree/vim-autocomplpop'
   " " Plug 'Shougo/neocomplete.vim'

   "  " Tmux Love
   "  Plug 'christoomey/vim-tmux-navigator'
   "  Plug 'benmills/vimux'
   "  " This in-case the status-bar gets too much..
   "  Plug 'edkolev/tmuxline.vim'

    " Pretty
    Plug 'ryanoasis/vim-devicons'

    " Codeium
    Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

    " Any Jump
    Plug 'pechorin/any-jump.vim'

    " Diff
    Plug 'will133/vim-dirdiff'

    " Hyperfocus
    Plug 'junegunn/limelight.vim'

    " Zoom
    Plug 'vim-scripts/ZoomWin'

call plug#end()
call plug#helptags()
if !has('g:syntax_on')|syntax enable|endif
filetype plugin on
filetype indent on
" Behold paste indenting!
set pastetoggle=<F2>
" set showmode
set mouse+=a
syntax on
" setlocal spell spelllang=en_us
set grepprg=grep\ -nH\ $*
set showcmd        " display incomplete commands
"set autoread       " reload files (no local changes only)
set laststatus=2    " Always display the statusline in all windows
set showtabline=2   " Always display the tabline, even if there is only one tab
set noshowmode      " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256                 " force vim to use 256 colors
set number                  "Show line numbers              
set hidden                  "Buffers can exist in the background without being in a window.
"set nobackup       "no backup files
"set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
" Too much ?
"autocmd TextChanged,TextChangedI <buffer> silent write
" set backupdir=~/.vim/VimExtras/VimBackups//,/tmp
" set directory=~/.vim/VimExtras/VimSwap//,/tmp
set showmatch      "automatically highlight matching braces/brackets/etc.
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
" autocmd GUIEnter * set visualbell t_vb=
set visualbell           " don't beep
set t_vb=
set noerrorbells         " don't beep
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"
set whichwrap=<,>,h,l     " Cursor Movement in Vim when hit the end of line ref: https://vim.works/2019/03/03/cursor-movement-in-vim/
set splitbelow          " This will cause all splits to happen below (including terminal).
set splitright
set tags+=~/.vim/tags/ucrt_tags
set tags+=~/.vim/tags/vector_tags
set tags+=/d/PROJECTS/mpbu/third_party/raylib/tags
set rtp+=~/.fzf

" " ================ Mappings ======================
" " Probably NOT a good idea
" "nnoremap <F2> :set invpaste paste?<CR>
nnoremap ; :
" "Spacemacs Esc
inoremap jk <ESC>
inoremap kk <ESC>

" SET LEADER
let mapleader=" "
" let maplocalleader = "\\"
map <leader>n :new<cr>
map <leader>i I
"map <leader><c-p> :CtrlPBookmarkDir<CR>
"map <c-b> :CtrlPBuffer<CR>
"map <c-s> :CtrlPMRUFiles<CR>

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
" nnoremap <C-]> :vert winc ]<CR>

" For some reason enter is mapped to comment so undoing it.
" default behavior of enter (<CR>) is same as + (Move down one line, to first non-blank character)
" nnoremap <CR> +

" ================ Indentation ======================

" set autoindent "Set in vim-sensible
set smartindent       "Smart autoindenting on new line
set nowrap                      " don't wrap lines
set smarttab          "Respect space/tab settings
"set softtabstop=2
set tabstop=2
set backspace=indent,eol,start     "allow backspacing everything in insert mode, also in vim-sensible
set textwidth=70
set formatoptions+=t 
set tabstop=4 softtabstop=4 " 1 tab == 4 spaces
set shiftwidth=4 " 1 tab == 4 spaces
set expandtab " Use spaces instead of tabs
" ================ Folds ============================

set foldmethod=syntax   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
set foldlevelstart=10   " fold very nested folds by default
set foldnestmax=10      " allow up to 10 nested folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"================== Vim Theme =========================== 
colorscheme gruvbox
" other good ones: gruvbox, default, moonshine, emacs, materialbox, space-vim, molokai, dracula
set background=dark
let g:limelight_conceal_ctermfg = 'LightGray'

" ================ Searches ============================
set incsearch      " do incremental searching
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)
" Removed it as it did not allow searching for * and #

nnoremap <silent> <ESC> :noh<CR> " remove highlighing after search

"" Fuzzy File Searc using in build feature no plugin
"" use `:find filename`
set path+=**        " search into subdirectores, provide tab
set wildmenu        " display all matching files when tab completes

" " Ctrl P Stuff
" "let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
" let g:ctrlp_map = '<C-f>'
" let g:ctrlp_cmd = 'CtrlP'
" map <C-f> :CtrlP<CR>
" map <leader><c-p> :CtrlPBookmarkDir<CR>
" map <C-b> :CtrlPBuffer<CR>
" map <C-p> :CtrlPMRUFiles<CR>
"  "let g:ctrlp_root_markers = ['.ctrlp','.latexmain','.agignore']
"  "let g:ctrlp_working_path_mode = 0 
" let g:ctrlp_use_caching = 1
" 
" let g:ctrlp_custom_ignore = {
" \ 'dir':  '\v[\/]\.(git|hg|svn|cache|)$',
" \ 'file': '\v\.(exe|so|dll|dll|log|lof|swp|out)$',
" \ 'link': 'some_bad_symbolic_links',
" \ }

" Fcuk Ctrl-P (it is slow) I use fzf
map <C-f> :Files<CR>
map <C-b> :Buffers<CR>
map <C-p> :History<CR>

if filereadable(expand("~/.dotfiles/vim/fzf-keybinds.vim"))
    source ~/.dotfiles/vim/fzf-keybinds.vim
endif


" Easy Motion
 "keep cursor colum JK motion
let g:EasyMotion_startofline = 0 
map <Leader>J <Plug>(easymotion-sol-j)
map <Leader>K <Plug>(easymotion-sol-k)

" Vim Move

"" GIT Stuff without plugin
" Fugitive is nice but https://sharats.me/posts/automating-the-vim-workplace/ says it makes vim slow on windows
" which is problem I am also facing, hence:
nnoremap <Leader>g :ter git --no-pager<Space>
nnoremap <Leader>g :ter <C-r>=&buftype == 'terminal'
            \ && job_info(term_getjob('%')).cmd[0] ==? 'git' ? '++curwin ' : ''
            \ <CR>git --no-pager<Space>

" Commenting
let g:NERDCreateDefaultMappings = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '// ','right': '' } }

" " Vim Airline Stuff
" " Use the airline thing anyway.
" let g:miniBufExplAutoStart = 0
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tmuxline#enabled = 0 " Don't interefere with tmuxline
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:tmuxline_theme = 'powerline'
" set laststatus=2 		"Show statusbar always.
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_hard' " others: dark, term, base16_monokai, base16_twilight
let g:airline#extensions#tabline#buffer_nr_show = 0   " configure whether buffer numbers should be shown.
let g:airline#extensions#tabline#show_tab_nr = 1      " enable/disable displaying tab number in tabs mode. 
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" "TABLINE:                                                                                                                                 
" " Ref: https://www.reddit.com/r/vim/comments/crs61u/best_airline_settings/                                                                                                                     
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 2    " dont show tab numbers on the right is less than 2 tabs                                                           
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
" let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
let g:airline#extensions#nerdtree_statusline = 1       " disables separate statusline for NerdTree
let g:airline#extensions#tabline#show_tabs = 1         " enable/disable displaying tabs, regardless of number. (c)          
let g:airline#extensions#whitespace#enabled = 0          " disable message regarding whitespaces:
" let g:airline_section_y = ''


" Automatically load .vimrc source when saved
autocmd BufWritePost .vimrc source ~/.vimrc


" More Stuff
" Vim jump to the last position when reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
endif

" NERDtree Key bound to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

" NERDtree FileType Highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
   exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" For the NERDtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
 \ "Modified"  : "✹",
 \ "Staged"    : "✚",
 \ "Untracked" : "✭",
 \ "Renamed"   : "➜",
 \ "Unmerged"  : "═",
 \ "Deleted"   : "✖",
 \ "Dirty"     : "✗",
 \ "Clean"     : "✔︎",
 \ "Unknown"   : "?"
 \ }

let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0
let NERDTreeIgnore=['^node_modules$', '\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


"Git Gutter
highlight GitGutterAdd    guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

" This allows the sensible settings to be overriden.
 runtime! plugin/sensible.vim

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif
