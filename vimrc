set nocompatible
filetype off

" Set the runtime path to include NeoBundle and initialize (Required)
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle (Required)
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'michalbachowski/vim-wombat256mod'
"NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/ag.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'https://github.com/Valloric/YouCompleteMe.git' , {
      \ 'build' : {
      \     'unix' : './install.sh --clang-completer --system-libclang'
      \    },
      \ }

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

call unite#custom_source('file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

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
