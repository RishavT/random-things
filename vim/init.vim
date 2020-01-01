set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
set nocompatible               " be improved, required
filetype off                   " required
" set the runtime path to include Vundle and initialize 
set rtp+=~/.config/nvim/bundle/Vundle.vim
" call vundle#begin()            " required
source ~/.vimrc

