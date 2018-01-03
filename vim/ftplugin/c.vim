" Vim filetype plugin file
" Language: C/C++ (cause /usr/share/vim/vim74/ftplugin/cpp.vim Behaves just like C )



" YCM hotkey
nnoremap gd :YcmCompleter GoToDeclaration<CR>
map <F12> :YcmCompleter GoToDefinition<CR>

" YCM config
" the statement below will bad for -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
