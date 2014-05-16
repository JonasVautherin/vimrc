set nocompatible
filetype off

" Set the runtime path to include NeoBundle and initialize (Required)
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle (Required)
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'michalbachowski/vim-wombat256mod'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/ag.vim'

call neobundle#end()

syntax on
filetype plugin on
filetype indent on

" Colorscheme
" Use with a 256 terminal ('set term?' to check, 'set term=xterm-256color' to set)
try
        colorscheme wombat256mod
catch /^Vim\%((\a\+)\)\=:E185/
        " deal with it
endtry

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

" Keep more lines of context
set scrolloff=3

" Highlight search results
set hlsearch

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

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

NeoBundleCheck
