" Vim filetype plugin file
" Language: C/C++ (cause /usr/share/vim/vim74/ftplugin/cpp.vim Behaves just like C )

set tabstop=4     " size of tab width
set shiftwidth=4  " size of shift width
set noexpandtab

" easy-align, Aligning C-style variable definition
let g:easy_align_delimiters['d'] = {
  \ 'pattern': ' \ze\S\+\s*[;=]',
  \ 'left_margin': 0, 'right_margin': 0
  \ }

" DoxygenToolkit, docstring
map <c-s> :Dox<CR>
