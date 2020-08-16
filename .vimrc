"Set UTF-8 file encoding
set encoding=utf-8
set fileencoding=utf-8

"Enable syntax highlighting
syntax enable

"Set colour scheme
colorscheme koehler

"Enable HYBRID numbering (relative numbering + normal numbers on active line)
set number relativenumber

"Automatically turn hybrid/relative numbering off when in Insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"Highlight ALL search terms found
set hlsearch

"Enable auto indentation
set autoindent

"Show a big line under the cursor
set cursorline
"Highlight matching parenthesis when closing
set showmatch

""Highlight bad whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
"match ExtraWhitespace /\s\+$/
" Show trailing whitespace and spaces before a tab:
"match ExtraWhitespace /\s\+$\| \+\ze\t/
" Show tabs that are not at the start of a line:
"match ExtraWhitespace /[^\t]\zs\t\+/
" Show spaces used for indenting (so you use only tabs for indenting).
"match ExtraWhitespace /^\t*\zs \+/
" Show trailing whitespace, except when typing at the end of a line
match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * redraw!

""""""PYTHON SPECIFIC SETTINGS
"Expand all tabs into spaces
set expandtab
"Set tab width to 4 spaces
set ts=4
"Set shift width to 4 spaces (when using :>> or :<<)
set shiftwidth=4
"Enable Python syntax highlighting properly or something
"Using https://github.com/hdima/python-syntax
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
"Macro to run current python3 script
"autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>
autocmd BufWinEnter *.py nnoremap <F9> :w<CR>:!python3 '%'<CR>
autocmd BufWinEnter *.tcl nnoremap <F10> :w<CR>:!ns '%'<CR>
