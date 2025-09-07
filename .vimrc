set nocompatible
set encoding=utf-8

set number
set relativenumber
set cursorline
set showcmd
set showmode
set ruler

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent

syntax enable
syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
    function! InstallPlug()
        let plug_dir = expand('~/.vim/autoload')
        call mkdir(plug_dir, 'p')
        
        let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        let plug_path = plug_dir . '/plug.vim'
        
        echo "Installing vim-plug..."
        execute 'silent !wget -q -O ' . shellescape(plug_path) . ' ' . shellescape(plug_url)
        
        if filereadable(plug_path)
            echo "vim-plug installed successfully!"
            source $MYVIMRC
        else
            echo "Error: Failed to install vim-plug"
        endif
    endfunction

    call InstallPlug()
    echo "Please restart Vim and run :PlugInstall to install plugins"
else
    call plug#begin('~/.vim/plugged')
        Plug 'preservim/nerdtree'
    call plug#end()
endif
