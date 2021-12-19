" Vim filetype plugin file
" Language: python

set tabstop=4     " size of tab width
set shiftwidth=4  " size of shift width
set expandtab
set colorcolumn=120

" python-mode
let g:pymode = 1
" let g:pymode_lint_ignore=["E501","W"]
let g:pymode_lint_ignore=["E501"]

" auto format
nmap <s-f> :PymodeLintAuto<CR>
