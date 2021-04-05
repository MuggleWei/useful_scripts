" Vim filetype plugin file
" Language: C/C++ (cause /usr/share/vim/vim74/ftplugin/cpp.vim Behaves just like C )

set tabstop=4     " size of tab width
set shiftwidth=4  " size of shift width
set noexpandtab

" YCM hotkey
nnoremap gd :YcmCompleter GoToDeclaration<CR>
map <F12> :YcmCompleter GoToDefinition<CR>

" YCM config
" the statement below will bad for -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" easy-align, Aligning C-style variable definition
let g:easy_align_delimiters['d'] = {
  \ 'pattern': ' \ze\S\+\s*[;=]',
  \ 'left_margin': 0, 'right_margin': 0
  \ }


" clangd
" NOTE:
" I put this setting in .vimrc, lead "ValueError: No semantic completer exists for filetypes: ['cpp']"
" then I put in this, everything work well
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
