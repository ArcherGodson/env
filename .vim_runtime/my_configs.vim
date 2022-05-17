" PEP-8
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set number
set foldcolumn=0

syntax on

set noerrorbells
set novisualbell

set mouse=a

" Commands
" \python to make python3 header
map <leader>python <ESC>i#!/usr/bin/env python3<CR><CR>

" Search
set ignorecase
set smartcase

set hlsearch

set incsearch

nmap <F6> :NERDTreeToggle<CR>

:hi CursorLine   cterm=NONE ctermbg=233 ctermfg=NONE
:hi CursorLineNR cterm=NONE ctermbg=233
:set cursorline
:set number
:let g:netrw_silent=1

:map <F2> :w!<CR>
imap <F2> <ESC>:w!<CR>
":map <F10> :q! <CR>
:map <ESC><ESC> :q <CR>

set wildmenu
set wcm=<Tab>
menu Exit.quit     :quit<CR>
menu Exit.quit!    :quit!<CR>
menu Exit.save_on_exit     :exit<CR>
map <F10> :emenu Exit.<Tab>
imap <F10> <ESC>:emenu Exit.<Tab>

"nnoremap <F4> :call HexToggle() <CR>
nnoremap <F4> :call ToggleHex() <CR>

function ToggleHex()
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    let b:oldft=&ft
    let b:oldbin=&bin
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    let b:editHex=1
    %!xxd
  else
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    let b:editHex=0
    %!xxd -r
  endif
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

