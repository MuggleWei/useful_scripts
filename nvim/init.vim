" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

	" ============== LSP ==============
	Plug 'neovim/nvim-lspconfig'

	" ============== auto completion ==============
	Plug 'nvim-lua/completion-nvim'

	" ============== navigation ==============
	Plug 'preservim/nerdtree'
	Plug 'majutsushi/tagbar'

	" ============== search ==============
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" ============== code format ==============
	Plug 'junegunn/vim-easy-align'
	Plug 'scrooloose/nerdcommenter'
	Plug 'vim-scripts/DoxygenToolkit.vim'

	" ============== syntax check ==============
	" Plug 'scrooloose/syntastic'

	" ============== snippets ==============
	Plug 'sirver/ultisnips'
	Plug 'honza/vim-snippets'

	" ============== color and theme ==============
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'joshdick/onedark.vim'
	Plug 'sheerun/vim-polyglot'

	" ============== python ==============
	Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

	" ============== golang ==============
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()


"""""""""""""""""""""""""""""""""""""
" Plug config

""""""""""
" LSP & completion-nvim

lua << EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.gopls.setup{}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings. 
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- completion-nvim on_attach here
  require'completion'.on_attach(client, bufnr)

end


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "clangd", "pylsp", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
	flags = {
      debounce_text_changes = 150,
	}
  }
end
EOF

""""""""""
" completion-nvim

" don't config here, move to on_attach function
" lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}

autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_enable_auto_popup = 1

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'UltiSnips'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c


""""""""""
" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1


""""""""""
" tagbar
map <F8> :TagbarToggle<CR>

""""""""""
" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>

let g:fzf_history_dir = '~/.local/share/fzf-history'

""""""""""
" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
	let g:easy_align_delimiters = {}
endif

""""""""""
" nerdcommenter
nmap <C-/> <plug>NERDCommenterToggle
xmap <C-/> <plug>NERDCommenterToggle
" In my ubuntu term, set ctrl+/ not working, find same issue below
" See issue: https://github.com/vim/vim/issues/6191
" so use ctrl+_ replace of ctrl+/, and ctrl+/ working
nmap <C-_> <plug>NERDCommenterToggle
xmap <C-_> <plug>NERDCommenterToggle
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
  \ 'c':{'left': '// '},
  \ 'cpp':{'left': '// '}
  \ }

" DoxygenToolkit use default
" " DoxygenToolkit
" let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
" let g:DoxygenToolkit_paramTag_pre="@Param "
" let g:DoxygenToolkit_returnTag="@Returns   "
" let g:DoxygenToolkit_blockHeader="-------------------------------"
" let g:DoxygenToolkit_blockFooter="---------------------------------"
" let g:DoxygenToolkit_authorName="Mathias Lorente"
" let g:DoxygenToolkit_licenseTag="My own license" <-- !!! Does not end with "\<enter>"


" """"""""""
" " syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" ultisnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsEditSplit="vertical"

let g:ultisnips_python_style="sphinx"

""""""""""
" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'


"""""""""""""""""""""""""""""""""""""
" filetype

filetype plugin indent on

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

set scrolloff=10   " scroll screen when n lines aways from top/bottom

set nohlsearch     " close highlight search

"""""""""""""""""""""""""""""""""""""
" hotkey

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" vim ignore file patterns
" ctrlp, leaderf will use it
set wildignore+=build/*,*.so,*.swp,*.zip

" colorscheme
syntax enable
colorscheme onedark

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

