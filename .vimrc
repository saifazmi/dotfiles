"""""""""""""
" BEHAVIOUR "
"""""""""""""
set nocompatible    " Don't behave like Vi
set encoding=utf-8  " Use UTF-8 as internal encoding


""""""""""""""
" FORMATTING "
""""""""""""""
set tabstop=4       " Width of the tab character
set softtabstop=4   " How many columns the tab key inserts
set shiftwidth=4    " Width of 1 indentation level
set expandtab       " Expand tabs into spaces
set smartindent     " Smart C-like autoindenting

" Determine indentation rules by filetype
filetype plugin indent on


"""""""""""""
" INTERFACE "
"""""""""""""
set number          " Show line numbers
set showmatch       " When inserting brackets, highlight the matching one
set hlsearch        " Highlight search results
set incsearch       " Highlight search results as the search is typed
set ruler           " Show line and cursor position
"set colorcolumn=80,120  " Highlight the 80th and 120th column
set listchars=tab:▸\ ,eol:¬ "Use the respective invisible characters

syntax on           " Enable syntax highlighting


"""""""""""""""""""
" PLUGINS (VUNDLE) "
""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)


" All of your Plugins must be added before the following line
call vundle#end()            " required


""""""""""""""
" KEYMAPPING "
""""""""""""""


"""""""""""""""""""
" Colours and GUI "
"""""""""""""""""""
set background=dark"
