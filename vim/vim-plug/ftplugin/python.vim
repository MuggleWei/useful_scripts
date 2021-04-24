" Vim filetype plugin file
" Language: python

set tabstop=4     " size of tab width
set shiftwidth=4  " size of shift width
set expandtab

" python-mode
let g:pymode = 1
" let g:pymode_lint_ignore=["E501","W"]
let g:pymode_lint_ignore=["E501"]

" jedi-vim
let g:jedi#goto_definitions_command = "<F12>"

" " docstring
" map <c-s> :Pydocstring<CR>
