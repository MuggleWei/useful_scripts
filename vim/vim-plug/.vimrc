set nocompatible  " be iMproved, required
filetype off      " required

"""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

    " Make sure you use single quotes

    " ============== navigation ==============
    Plug 'scrooloose/nerdtree'
    Plug 'vim-scripts/taglist.vim'
    Plug 'majutsushi/tagbar'
    Plug 'kien/ctrlp.vim'
    
    " ============== color and theme ==============
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'altercation/vim-colors-solarized'
	Plug 'joshdick/onedark.vim'

    " ============== code format ==============
    Plug 'junegunn/vim-easy-align'

	" ============== complete ==============
	Plug 'valloric/youcompleteme', { 'branch': 'legacy-c++11' }

	" ============== golang ==============
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

	" ============== python ==============
	Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
	Plug 'davidhalter/jedi-vim'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""

filetype plugin indent on " required

"""""""""""""""""""""""""""""""""""""
" style configure

syntax on  " turns on syntax coloring

set number         " show line number
set relativenumber " show relative line number

set tabstop=4
set shiftwidth=4

set autoindent     " new lines are indented the same as the previous line
set cindent        " works for C-style programs, automatically indents your program according to a “standard” C style.

set incsearch      " increase search

set cursorline     " show cursor line

"""""""""""""""""""""""""""""""""""""
" hotkey

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""
" Plug config

" NERDTree
map <c-n> :NERDTreeToggle<CR>
map <F3>  :NERDTreeToggle<CR>
" don't use ctrl+m, it will trigger wield behavior
" Ctrl+I = Tab
" Ctrl+J = Newline
" Ctrl+M = Enter
" Ctrl+[ = Escape
" see: https://github.com/preservim/nerdtree/issues/761
" map <C-m> :NERDTreeFind<CR>
map <c-b> :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" taglist
map <F11> :Tlist<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1

" tagbar
map <F8> :TagbarToggle<CR>

" ctrlp
set wildignore+=build/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'find %s -type f'

" airline
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'
"let g:airline_detect_modified=1
"let g:airline_detect_paste=1
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tavline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
if !has('gui_running')
  set t_Co=256
endif

" colorscheme
syntax enable
if has('gui_running')
	set background=light
else
	set background=dark
	let g:solarized_termcolors=256
endif
colorscheme solarized

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
	let g:easy_align_delimiters = {}
endif

"""""""""""""""""""""""""""""""""""""
" other

" utf-8
set encoding=utf-8

" close error bells
set vb t_vb=

" make backspace work
set backspace=indent,eol,start

" close cursor line number underline
highlight CursorLineNr cterm=bold 

