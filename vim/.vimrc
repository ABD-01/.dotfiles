" Reference: https://github.com/HaoZeke/Dotfiles/blob/master/dotfiles/common/.vimrc
" Also few mappings from : https://github.com/JJGO/dotfiles/blob/master/vim/.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
"set nocompatible

" ================ Plugins! ======================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" function
" function! BuildYCM(info)
"   " info is a dictionary with 3 fields
"   " - name:   name of the plugin
"   " - status: 'installed', 'updated', or 'unchanged'
"   " - force:  set on PlugInstall! or PlugUpdate!
"   if a:info.status == 'installed' || a:info.force
"     !python2 ./install.py
"   endif
" endfunction
    " :PlugInstall is required. Along with a source %
    " Initialize List of plugins...
call plug#begin()
    " The basis."
    Plug 'tpope/vim-sensible'

    " Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    "{ 'for': 'cpp' } WASTE. Python2 ONLY
  "  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } | Plug 'l3nkz/ycmtex' 
  "  autocmd! User YouCompleteMe call youcompleteme#Enable()

    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'unkiwii/vim-nerdtree-sync'  " to sync the current file

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

    " Python
    " Plug 'klen/python-mode'
    " Plug 'jmcantrell/vim-virtualenv'  " This should fix the virtualenvs.

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

    " File searching with faster matching
    Plug 'ctrlpvim/ctrlp.vim'
    " Plug 'FelikZ/ctrlp-py-matcher'
    
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

call plug#end()
call plug#helptags()
if !has('g:syntax_on')|syntax enable|endif
filetype plugin indent on
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


" " ================ Mappings ======================
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
map <leader><c-p> :CtrlPBookmarkDir<CR>
map <c-b> :CtrlPBuffer<CR>
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

" Ctrl P Stuff
"let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
let g:ctrlp_map = '<C-f>'
let g:ctrlp_cmd = 'CtrlP'
map <C-f> :CtrlP<CR>
map <leader><c-p> :CtrlPBookmarkDir<CR>
map <C-b> :CtrlPBuffer<CR>
map <C-p> :CtrlPMRUFiles<CR>
"let g:ctrlp_root_markers = ['.ctrlp','.latexmain','.agignore']
"let g:ctrlp_working_path_mode = 0 
let g:ctrlp_use_caching = 1

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|cache|)$',
\ 'file': '\v\.(exe|so|dll|dll|log|lof|swp|out)$',
\ 'link': 'some_bad_symbolic_links',
\ }


" Easy Motion
" keep cursor colum JK motion
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


" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" COmmenting
vmap <C-m> <plug>NERDCommenterToggle
nmap <C-m> <plug>NERDCommenterToggle
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

" " Promptline Stuff
" " sections (a, b, c, x, y, z, warn) are optional
" let g:promptline_preset = {
"         \'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
"         \'b' : [ promptline#slices#user(), promptline#slices#python_virtualenv() ],
"         \'c' : [ promptline#slices#cwd() ],
"         \'y' : [ promptline#slices#vcs_branch() ],
"         \'warn' : [ promptline#slices#last_exit_code() ]}
"
" " available slices:
" "
" " promptline#slices#cwd() - current dir, truncated to 3 dirs. To configure: promptline#slices#cwd({ 'dir_limit': 4 })
" " promptline#slices#vcs_branch() - branch name only. By default, only git branch is enabled. Use promptline#slices#vcs_branch({ 'hg': 1, 'svn': 1, 'fossil': 1}) to enable check for svn, mercurial and fossil branches. Note that always checking if inside a branch slows down the prompt
" " promptline#slices#last_exit_code() - display exit code of last command if not zero
" " promptline#slices#jobs() - display number of shell jobs if more than zero
" " promptline#slices#battery() - display battery percentage (on OSX and linux) only if below 10%. Configure the threshold with promptline#slices#battery({ 'threshold': 25 })
" " promptline#slices#host() - current hostname.  To hide the hostname unless connected via SSH, use promptline#slices#host({ 'only_if_ssh': 1 })
" " promptline#slices#user()
" " promptline#slices#python_virtualenv() - display which virtual env is active (empty is none)
" " promptline#slices#git_status() - count of commits ahead/behind upstream, count of modified/added/unmerged files, symbol for clean branch and symbol for existing untraced files
" "
" " any command can be used in a slice, for example to print the output of whoami in section 'b':
" "       \'b' : [ '$(whoami)'],
" "
" " more than one slice can be placed in a section, e.g. print both host and user in section 'a':
" "       \'a': [ promptline#slices#host(), promptline#slices#user() ],
" "
" " to disable powerline symbols
" " `let g:promptline_powerline_symbols = 0`
"
"
" Automatically load .vimrc source when saved
autocmd BufWritePost .vimrc source ~/.vimrc


" More Stuff
" Vim jump to the last position when reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
endif

" " Alternative to statusline: Ruler
" set ruler
" let &rulerformat = '%50(b%n %{&ff} %{&ft}' .
"             \ '%( %{len(getqflist()) ? ("q" . len(getqflist())) : ""}%)' .
"             \ '%( %{search("\\s$", "cnw", 0, 200) ? "∙$" : ""}%)' .
"             \ '%( %{exists("b:stl_fn") ? call(b:stl_fn) : ""}%)' .
"             \ '%= L%l,%c%V %P %*%)'


" " nnoremap <C-S-u>  :GundoToggle<CR>
" nnoremap <C-S-u>  :UndotreeToggle<CR>

" Syntastic Defaults
 "set statusline+=%#warningmsg#
 "set statusline+=%{SyntasticStatuslineFlag()}
 "set statusline+=%*

 "let g:syntastic_always_populate_loc_list = 1
 "let g:syntastic_auto_loc_list = 1
 "let g:syntastic_check_on_open = 1
 "let g:syntastic_check_on_wq = 0
 "let g:syntastic_tex_chktex_showmsgs = 0
 "let g:syntastic_tex_checkers=['chktex'] 

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
