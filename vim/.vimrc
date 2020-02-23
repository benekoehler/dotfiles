" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType json syntax match Comment +\/\/.\+$+
  
  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Add optional packages.
if empty(glob('~/dotfiles/vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/dotfiles/vim/plugged')

Plug 'cespare/vim-toml'
" Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-surround', {'autoload': {'filetypes': ['clojure','rst','python']} }
Plug 'tpope/vim-repeat', {'autoload': {'filetypes': ['clojure', 'rst', 'python']} }
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'othree/yajs.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

let g:coc_node_path = "/Users/benekohler/.nvm/versions/node/v12.13.0/bin/node"
source ~/dotfiles/vim/.coc

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set hidden
set number
set tabstop=2 shiftwidth=2 expandtab
set textwidth=120
set cc=120
set redrawtime=10000
set whichwrap+=<,>,h,l
set backupdir=~/dotfiles/vim/tmp//,.
set directory=~/dotfiles/vim/tmp//,.
" colorscheme spacecamp_lite
colorscheme gruvbox

if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=2\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" highlight ColorColumn ctermbg=0 guibg=lightgrey
" custom keymaps

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

nnoremap <C-n> :NERDTreeToggle %<CR>

nnoremap <C-p> :FZF<CR>

nnoremap <C-t><up> :tabr<cr>
nnoremap <C-t><down> :tabl<cr>
nnoremap <C-t><left> :tabp<cr>
nnoremap <C-t><right> :tabn<cr>
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <C-f> :CocCommand prettier.formatFile<CR> :w<CR>
" nnoremap <Space> i<Space><Right><ESC>
