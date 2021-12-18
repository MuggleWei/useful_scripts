" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

	" ============== LSP ==============
	Plug 'neovim/nvim-lspconfig'

	" ============== auto completion ==============
	Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
	Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp

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
	Plug 'jiangmiao/auto-pairs'

	" ============== snippets ==============
	" Plug 'honza/vim-snippets'
	" Plug 'sirver/ultisnips'
	" Plug 'saadparwaiz1/cmp_luasnip'
	" Plug 'L3MON4D3/LuaSnip'

	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'rafamadriz/friendly-snippets'

	" ============== color and theme ==============
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    Plug 'altercation/vim-colors-solarized'
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
" LSP & completion

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
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('i', '<C-space>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'pyright', 'gopls' }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities
	}
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		-- ['<C-p>'] = cmp.mapping.select_prev_item(),
		-- ['<C-n>'] = cmp.mapping.select_next_item(),
		-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		-- ['<C-e>'] = cmp.mapping.close(),
		-- ['<CR>'] = cmp.mapping.confirm {
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = true,
		-- },
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expand_or_jumpable() then
			-- 	luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			-- 	luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' },  -- For luasnip users.
	},
}

EOF

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

""""""""""
" auto-pairs
let g:AutoPairsShortcutToggle = ''
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''", "`":"`"}

" " ultisnips
" let g:UltiSnipsExpandTrigger="<c-e>"
" let g:UltiSnipsJumpForwardTrigger="<c-e>"
" let g:UltiSnipsEditSplit="vertical"
" 
" let g:ultisnips_python_style="sphinx"

" vim-snip
imap <expr> <c-e>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-e>'
smap <expr> <c-e>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-e>'

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

" save
nmap <C-s> :w!<CR>
imap <C-s> <Esc>:w!<CR>

" vim ignore file patterns
" ctrlp, leaderf will use it
set wildignore+=build/*,*.so,*.swp,*.zip

" colorscheme
syntax enable
"colorscheme onedark
if has('gui_running')
	set background=light
else
	set background=dark
	let g:solarized_termcolors=256
endif
colorscheme solarized

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

