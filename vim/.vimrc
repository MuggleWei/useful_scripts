set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" " The following are examples of different formats supported.
	" " Keep Plugin commands between vundle#begin/end.
	" " plugin on GitHub repo
	" Plugin 'tpope/vim-fugitive'
	" " plugin from http://vim-scripts.org/vim/scripts.html
	" Plugin 'L9'
	" " Git plugin not hosted on GitHub
	" Plugin 'git://git.wincent.com/command-t.git'
	" " git repos on your local machine (i.e. when working on your own plugin)
	" Plugin 'file:///home/gmarik/path/to/plugin'
	" " The sparkup vim script is in a subdirectory of this repo called vim.
	" " Pass the path to set the runtimepath properly.
	" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
	" " Install L9 and avoid a Naming conflict if you've already installed a
	" " different version somewhere else.
	" Plugin 'ascenator/L9', {'name': 'newL9'}
	
	" ============== navigation ==============
	Plugin 'scrooloose/nerdTree'
	Plugin 'taglist.vim'
	Plugin 'majutsushi/tagbar'
	Plugin 'kien/ctrlp.vim'

	" ============== color and theme ==============
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'altercation/vim-colors-solarized'

	" ============== code format ==============
	Plugin 'junegunn/vim-easy-align'

	" ============== complete ==============
	" Plugin 'file:///home/weidaizi/vim_plugins/YouCompleteMe'
	Plugin 'Valloric/YouCompleteMe'

	" ============== golang ==============
	Plugin 'fatih/vim-go'

	" ============== python ==============
	Plugin 'python-mode/python-mode'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line


" my own vim configure
set tabstop=4
set shiftwidth=4
set number
set autoindent
set cindent
set incsearch
set cursorline

" utf-8
set encoding=utf-8

" close error bells
set vb t_vb=

" relative line number
set relativenumber

" hotkey

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" NERDTree hotkey
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

" taglist hotkey
map <F11> :Tlist<CR>

" easy-align hotkey
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" tagbar hotkey
nmap <F8> :TagbarToggle<CR>

" plugin configure

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

syntax enable
if has('gui_running')
	set background=light
else
	set background=dark
	let g:solarized_termcolors=256
endif
colorscheme solarized

" taglist config
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1

" easy-align
if !exists('g:easy_align_delimiters')
	let g:easy_align_delimiters = {}
endif
