" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

"Set UTF-8 file encoding
set encoding=utf-8
set fileencoding=utf-8

"""""""""""""""vim-plug
call plug#begin('~/.vim/plugged')

"Statusline
Plug 'itchyny/lightline.vim'
"LaTeX Integration
Plug 'lervag/vimtex'
" Language/Syntax Packs
Plug 'sheerun/vim-polyglot'
Plug 'psf/black', { 'branch': 'stable' }
" Directory Tree
Plug 'preservim/nerdtree'
" Git Tools
Plug 'airblade/vim-gitgutter'
" Colour Schemes
Plug 'liuchengxu/space-vim-theme'
Plug 'joshdick/onedark.vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'bignimbus/pop-punk.vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'arzg/vim-colors-xcode'

call plug#end()

"Enable syntax highlighting
syntax enable

"Set colour scheme
colorscheme onedark

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
"
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

" Setup lightline
set laststatus=2
set noshowmode

" Setup lightline
let g:lightline = {
            \ 'colorscheme': 'molokai',
            \ 'active': {
            \ 'left'  : [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ],
            \ 'right' : [ [ 'lineinfo' ],
            \             [ 'percent' ],
            \             [ 'charvalue' ],
            \             [ 'fullpath', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component': {
            \ 'fullpath' : '%F',
            \ 'charvalue' : '<|%b:0x%B|>',
            \ 'bytenumber' : '<|%o:0x%O|>'
            \ },
            \ }

" Setup NERDTree
map <F5> :NERDTreeToggle<CR>
set updatetime=100
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


" Point YouCompleteMe at system Python to fix YCM usage with Poetry Python
" shell environments
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Set Black to run on save of .py files
autocmd BufWritePre *.py execute ':Black'
