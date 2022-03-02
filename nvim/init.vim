" ----------------------------------------- "
" Plugin install                "
" ----------------------------------------- "
call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" ==================== Nord Theme  ====================
set noshowmode
colorscheme nord

" ==================== Lightline ====================
let g:lightline = {
  \   'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'readonly': 'LightlineReadonly',
    \   'gitbranch': 'LightlineFugitive'
    \ },
  \ }
let g:lightline.separator = {
    \   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
    \   'left': '', 'right': ''
  \}

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

" ==================== Fugitive ====================
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
vnoremap <leader>gb :Gblame<CR>

" ==================== Better Whitespace  ====================

let g:better_whitespace_filetypes_blacklist=['rst', 'diff', 'gitcommit', 'unite', 'qf', 'help']

highlight ExtraWhitespace ctermbg=red guibg=#E06C75

" ----------------------------------------- "
" General configuration             "
" ----------------------------------------- "
set showcmd                     " Show me what I'm typing

set noswapfile          " Don't use swapfile
set nobackup            " Don't create annoying backup files
set nowritebackup

set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters

let g:mapleader = ","

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" speed up syntax highlighting
set nocursorcolumn
set nocursorline

" Tab settings
set tabstop=2
set shiftwidth=2
set expandtab

" Remove search highlight
nnoremap <leader><space> :nohl<CR>

" Navigate between buffer
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Keep standard block cursor for all modes
set guicursor=

" ----------------------------------------- "
" File Type settings                        "
" ----------------------------------------- "
au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
" Markdown Settings
autocmd BufNewFile,BufReadPost *.md setl ts=4 sw=4 sts=4 expandtab
" lua settings
autocmd BufNewFile,BufRead *.lua setlocal noet ts=4 sw=4 sts=4
" Dockerfile settings
autocmd FileType dockerfile set noexpandtab
" shell/config/systemd settings
autocmd FileType gitconfig,sh set noexpandtab

" ----------------------------------------- "
" Graphical settings                        "
" ----------------------------------------- "

" Use 24-bit (true-color) mode
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
