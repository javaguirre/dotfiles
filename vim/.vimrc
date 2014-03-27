"vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'nanotech/jellybeans.vim'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'javaguirre/UltiSnips'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/syntastic'
Bundle 'kana/vim-smartinput'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-surround'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'nvie/vim-flake8'
Bundle 'airblade/vim-gitgutter'
Bundle 'Rykka/colorv.vim'
Bundle 'tpope/vim-commentary'
Bundle 'taikoa/vimwiki'
Bundle 'yshh/htmljinja.vim'
Bundle 'stephpy/vim-php-cs-fixer'
Bundle 'pangloss/vim-javascript'
Bundle 'wavded/vim-stylus'
Bundle 'digitaltoad/vim-jade'
Bundle 'rainux/vim-vala'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'hsanson/vim-android'
Bundle 'ekalinin/Dockerfile.vim'

filetype plugin on
filetype plugin indent on

scriptencoding utf-8
set encoding=utf-8
set novisualbell
set autoread
" set ttyfast
" set textwidth=80

set smartindent
set ruler
set showcmd
set number
set cursorline
set cursorcolumn

" Search
set smartcase
set incsearch
set hlsearch
set ignorecase
" END Search

" History
set history=1000
" END History

" Wildmenu
set wildmenu " Command line autocomplete
set wildmode=list:longest,full " Show a list with all the options

set wildignore+=.hg,.git,.svn " Version control
set wildignore+=*.sw? " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~ " Backup files
set wildignore+=*.luac " Lua byte code
set wildignore+=*.jar " java archives
set wildignore+=*.pyc " Python byte code
set wildignore+=*.stats " Pylint stats
" END Wildmenu

set gfn=FantasqueSansMono\ 11
syntax on

colorscheme jellybeans
" colorscheme solarized
" set bg=dark

"Python"
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

"encoding
set encoding=utf-8
set laststatus=2
set t_Co=256
set sts=4

"White spaces"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

"Keys"
nmap <F3> :TlistToggle<CR>
imap <F3> :TlistToggle<CR>
nmap <Leader>P :set paste!<CR>
nmap <Leader>c :%s/\s\+$<CR>
nmap <Leader>b :b#<CR>
nmap <Leader>t "=strftime("%Y-%m-%d %H:%M")<CR>P
nmap <Leader>d "=strftime("%Y-%m-%d")<CR>p
map <Leader>h :nohlsearch<CR>
nmap <Leader>; :CtrlPBuffer<CR>
inoremap jk <esc>
inoremap <esc> <nop>

" Themes Bright and Dark
nmap <Leader>td :colorscheme jellybeans<CR>
nmap <Leader>tl :colorscheme solarized<CR>:set bg=dark<CR>
nmap <Leader>T :TagbarToggle<CR>
nmap <Leader>e $v0y:!<C-r>0<CR>  " Executes current line


" Save as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Custom options per filetype
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.md set cc=80
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile *.twig set syntax=htmljinja
au BufRead,BufNewFile *.tpl set syntax=html
au BufRead,BufNewFile *.jsm set syntax=javascript
au BufRead,BufNewFile *.rb set tabstop=2
au BufRead,BufNewFile *.rb set shiftwidth=2
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
au BufRead,BufNewFile *.email set filetype=htmldjango

" Abbr
ab @@p javi@javaguirre.net
ab @@t javaguirre@taikoa.net

" PLUGINS

" CtrlP
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" ColorV
let g:colorv_cache_file=$HOME.'/.vim/tmp/vim_colorv_cache'
let g:colorv_cache_fav=$HOME.'/.vim/tmp/vim_colorv_cache_fav'

" Commentary
nmap <C-c> <Plug>CommentaryLine
xmap <C-c> <Plug>Commentary

autocmd FileType python set commentstring=#\ %s
autocmd FileType go set commentstring=//\ %s
autocmd FileType php set commentstring=//\ %s

" Vimwiki
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_hl_headers=1
nmap <Leader>wd <Plug>VimwikiDiaryIndex
nmap <Leader>wdg <Plug>VimwikiDiaryGenerateLinks

" Vim Android
let g:android_sdk_path = $HOME.'/apps/android-sdk-linux'

" GUI
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
