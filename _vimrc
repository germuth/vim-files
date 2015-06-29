set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

" Tells vim it is allowed to use specific indent settings based on file type
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " ...
endif


" command-line completion
set wildmenu

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Allow Ctrl-/ to comment/uncomment a line (No success yet)
" map <C-B> Ia<Esc> 

" automatically scroll if cursor gets too close to bottom or top of file
set scrolloff=8

" can use ctrl-c to get out of insert mode
map <C-c> <Esc>

" oo insert line without entering insert mode
nmap oo o<Esc>k
nmap OO O<Esc>j

" add reverse joining of two lines (opposite of J)
" For example:
"
" //comment here
" some code here    ==>  some code here //comment here
"
" replaces help command...
" nmap K ddpkJ

" reduce delay you have to press oo
set timeoutlen=250

" relative line numberings
set rnu

" tab size 2
set tabstop=2

" autoindent after newline
set autoindent

" (really) nice color scheme
colorscheme desert "torte

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

