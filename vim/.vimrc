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

    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree'

    " Not that powerline isn't perfect... right?
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Why we theme
    " Plug 'tomasr/molokai'
    Plug 'morhetz/gruvbox'
    Plug 'flazz/vim-colorschemes'

    " Git wrapper inside Vim
    Plug 'tpope/vim-fugitive'

    " Fuzzy Finder
    Plug 'junegunn/fzf.vim'
    Plug '~/.fzf'

    " Any Jump
    " Plug 'pechorin/any-jump.vim'
    Plug 'ABD-01/any-jump.vim'

    " Multi cursor
    Plug 'mg979/vim-visual-multi'

    " Movement
    Plug 'matze/vim-move'

    " Super easy commenting, toggle comments etc
    Plug 'scrooloose/nerdcommenter'

    " Autoclose (, " etc
    Plug 'Townk/vim-autoclose'
    
    " Handle surround chars like ''
    Plug 'tpope/vim-surround'

    " Language Support
    Plug 'uarun/vim-protobuf'
    Plug 'rust-lang/rust.vim'

    " Diff
    Plug 'will133/vim-dirdiff'

    " LSP
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'mattn/vim-lsp-settings'

call plug#end()
call plug#helptags()

" ================ Settings ======================
" Behold paste indenting!
set pastetoggle=<F2>
set mouse+=a
set number                  "Show line numbers              
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

set visualbell           " don't beep
set t_vb=
set noerrorbells         " don't beep

set showcmd        " display incomplete commands
set laststatus=2    " Always display the statusline in all windows
set showtabline=2   " Always display the tabline, even if there is only one tab
set t_Co=256                 " force vim to use 256 colors
set hidden                  "Buffers can exist in the background without being in a window.
set noswapfile     "no swap files

set switchbuf=vsplit    " To open buffer from quickfix list in vsplit (sideeffects are not testes)
                        " ref: https://stackoverflow.com/a/71592986

" augroup QuickfixSplit
"   autocmd!
"   autocmd FileType qf nnoremap <buffer> <leader><CR> <C-w><Enter><C-w>L
" augroup END

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
inoremap kk <ESC>

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

" copy file name
nmap <Leader>fn :let @* = expand("%")<CR>
nmap <Leader>fp :let @* = expand("%:p")<CR>

" Terminal Shortcuts
tmap <C-h> <C-w>h
tmap <C-j> <C-w>j
tmap <C-k> <C-w>k
"tmap <C-l> <C-w>l
tnoremap jk <C-W>N

" for vim-move
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
vmap <C-h> <Plug>MoveBlockLeft
vmap <C-l> <Plug>MoveBlockRight

" Open tag in vsplit for leader + C-]
nnoremap <leader><C-]> <C-w>v<C-]>


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
"set softtabstop=2
set tabstop=2
set backspace=indent,eol,start     "allow backspacing everything in insert mode, also in vim-sensible
set textwidth=70
set formatoptions+=t 
set tabstop=4 softtabstop=4 " 1 tab == 4 spaces
set shiftwidth=4 " 1 tab == 4 spaces
set expandtab " Use spaces instead of tabs
" ================ Folds ============================

set foldmethod=manual   "fold based on indent
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
hi Normal guibg=NONE ctermbg=NONE

" ================ Searches ============================
set incsearch      " do incremental searching
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

nnoremap <silent> <ESC> :noh<CR> " remove highlighing after search

"" Fuzzy File Searc using in build feature no plugin
"" use `:find filename`
set path+=**        " search into subdirectores, provide tab
set wildmenu        " display all matching files when tab completes


" Fcuk Ctrl-P (it is slow) I use fzf
map <C-f> :Files<CR>
map <C-b> :Buffers<CR>
map <C-p> :History<CR>
nnoremap <silent> <Leader>v :call fzf#run({'right': winwidth('.') / 2,'sink':  'vertical botright split' })<CR>
nnoremap <silent> <Leader>s :call fzf#run({'down': '40%','sink': 'botright split' })<CR>

" ================ Nerd Tree ============================
let g:NERDTreeMinimalUI  = 1
let g:NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['^node_modules$', '\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" anyjump
let g:any_jump_search_prefered_engine = 'rg'

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

"Git Gutter
highlight GitGutterAdd    guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red

" ================ Multi Cursor ============================
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-x>'   " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-x>'   " replace visual C-n

" ================ LSP ============================

" Path to clangd
let g:clangd = 'C:/Program Files (x86)/Microsoft Visual Studio/2022/BuildTools/VC/Tools/Llvm/x64/bin/clangd.exe'

" Register clangd if executable exists
if filereadable(g:clangd)
  augroup lsp_clangd
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {-> [g:clangd, '--background-index']},
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })

        " Set omnifunc for LSP completion
        autocmd FileType c,cpp,objc,objcpp setlocal omnifunc=lsp#complete
    augroup END
endif

" Register rust-analyzer
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ 'initialization_options': {
        \   'cargo': {
        \     'allFeatures': v:true,
        \   },
        \   'check': {
        \     'command': 'clippy',
        \   },
        \ },
        \ })
endif

" Buffer-local mappings and settings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    " Navigation
    nnoremap <buffer> gd <plug>(lsp-definition)
    nnoremap <buffer> gD <plug>(lsp-declaration)
    nnoremap <buffer> gi <plug>(lsp-implementation)
    nnoremap <buffer> gr <plug>(lsp-references)
    nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nnoremap <buffer> gs <plug>(lsp-document-symbol-search)

    " Actions
    nnoremap <buffer> <leader>fm :LspDocumentFormat<CR>
    nnoremap <buffer> <leader>rn <plug>(lsp-rename)
    nnoremap <buffer> <leader>ca <plug>(lsp-code-action)
    nnoremap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <leader>e <plug>(lsp-document-diagnostics)
    nnoremap <buffer> [d <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> ]d <plug>(lsp-next-diagnostic)

    " Scroll hover info
    nnoremap <buffer> <expr> <leader>j lsp#scroll(+4)
    nnoremap <buffer> <expr> <leader>k lsp#scroll(-4)

    " Formatting on save (adjust filetypes as needed)
    " let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.c,*.cpp call execute('LspDocumentFormatSync')
endfunction

" Attach mappings when buffer gets an LSP server
augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:asyncomplete_auto_popup = 1

" Disable vim-lsp-settings auto-suggest/install prompts
let g:lsp_settings_enable_suggestions = 0

" =============== LSP UI Settings ===================
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 0

" Show diagnostics in virtual text
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
" let g:lsp_diagnostics_virtual_text_enabled = 1

" Diagnostic signs
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '⚠'}
let g:lsp_diagnostics_signs_hint = {'text': '➤'}
let g:lsp_diagnostics_signs_information = {'text': 'ℹ'}

" Enable hover preview window
let g:lsp_hover_ui = 'float'
let g:lsp_preview_float = 1

" Enable code lens
let g:lsp_code_action_ui = 'float'


" ================ Airline Stuff ============================
" Use the airline thing anyway.
let g:airline#extensions#branch#enabled = 0   " do not print branch name in airline
let g:airline#extensions#hunks#enabled = 0
" let g:miniBufExplAutoStart = 0
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tmuxline#enabled = 0 " Don't interefere with tmuxline
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:tmuxline_theme = 'powerline'
" set laststatus=2 		"Show statusbar always.
let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_hard' " others: dark, term, base16_monokai, base16_twilight
"let g:airline_theme='base16_nord'
let g:airline#extensions#tabline#buffer_nr_show = 0   " configure whether buffer numbers should be shown.
" let g:airline#extensions#tabline#show_tab_nr = 1      " enable/disable displaying tab number in tabs mode. 
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
let g:airline_section_y = '' " disable the unix or dos file type
let g:airline_section_z = '𝓛𝓷 %l/%L 𝓒𝓸𝓵%c'


" Automatically load .vimrc source when saved
autocmd BufWritePost .vimrc source ~/.vimrc
