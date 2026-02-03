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

    " Protobuf support
    Plug 'uarun/vim-protobuf'

    " Multi cursor
    Plug 'mg979/vim-visual-multi'

    " Rust
    Plug 'rust-lang/rust.vim'

    " LSP
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'mattn/vim-lsp-settings'

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

" ================ Multi Cursor ============================
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-x>'   " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-x>'   " replace visual C-n

" ================ Multi Cursor ============================


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

