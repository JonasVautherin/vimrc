set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Let Vundle manage Vundle (required)
Plugin 'gmarik/Vundle.vim'

Bundle 'kien/ctrlp.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/ag.vim'

syntax on
filetype plugin on
filetype indent on

" For clang_complete
let g:clang_library_path='/usr/lib/llvm-3.4/lib/'
let g:clang_set_library=1 " Allows to cache includes in memory and makes the completion much faster

" Doxygen syntax
let g:load_doxygen_syntax=1

" Enable smartcase. \c or \C in the search pattern allow to override this.
set ignorecase
set smartcase

" Line numbers
set number

" Keep more line of context
set scrolloff=3

" Tab management
nmap H gT
nmap L gt

" Line too long guide
set colorcolumn=+1
set textwidth=120

" Whitespace management
highlight ExtraTabs ctermbg=236 guibg=236
highlight ExtraWhiteSpace ctermbg=red guibg=red

autocmd BufWinEnter * syntax match ExtraTabs /^\t\+/
autocmd BufWinEnter * syntax match ExtraWhiteSpace /^ \+\t\+\|\s\+$/

" F3 removes the useless spaces (those marked in red).
nmap <F3> :call RmUselessSpaces()<CR>

function! RmUselessSpaces()
        " Trailing whitespace
        :%s/\s\+$//e
        " Leading whitespace
        :%s/ \+\t/\t/ge
endfunction

" If it exists, load .vimrc.local.
if filereadable(glob("~/.vimrc.local"))
        source ~/.vimrc.local
endif
