" BEHAVIOUR {{{
    set nocompatible    " Don't behave like Vi
    set encoding=utf-8  " Use UTF-8 as internal encoding
" }}}

" FORMATTING {{{
    set tabstop=4       " Width of the tab character
    set softtabstop=4   " How many columns the tab key inserts
    set shiftwidth=4    " Width of 1 indentation level
    set expandtab       " Expand tabs into spaces
    set smartindent     " Smart C-like autoindenting
    
    " More powerful backspacing
    set backspace=indent,eol,start

    " Determine indentation rules by filetype
    filetype plugin indent on
" }}}

" INTERFACE {{{
    set number          " Show line numbers
    set showmatch       " When inserting brackets, highlight the matching one
    set hlsearch        " Highlight search results
    set incsearch       " Highlight search results as the search is typed
    set ruler           " Show line and cursor position
    set splitbelow      " Horizontal split editor to bottom
    set splitright      " Vertical split editor to right
    syntax on           " Enable syntax highlighting


    " Use the respective invisible characters
    set listchars=tab:▸\ ,eol:¬,trail:·,extends:»,precedes:«

    " Intialise powerline status bar
    let g:powerline_pycmd='py3'
    set rtp+=$HOME/Library/Python/3.11/lib/python/site-packages/powerline/bindings/vim
    set laststatus=2    " Always show status bar
" }}}

" PLUGINS (VUNDLE) {{{
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
    Plugin 'ayu-theme/ayu-vim'
    Plugin 'scrooloose/nerdtree'
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
" }}}

" KEYMAPS {{{
    " Split navigations
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
" }}}

" Colours and GUI {{{
    if has('gui_running')
        set termguicolors       " enable true colors support
        let ayucolor="dark"     " for dark version of theme
        colorscheme ayu
    else
        colorscheme ayu
    endif
" }}}
