lua require('boot')

language en_IN

au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! noautocmd w

syntax on
set ruler               " Show the line and column numbers of the cursor.
set number

nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>
vnoremap <c-s> <Esc>:w<CR>

nnoremap <c-q> :wq<CR>
inoremap <c-q> <Esc>:wq<CR>
vnoremap <c-q> <Esc>:wq<CR>

" ctrl + j - [ ]
inoremap <C-j> - [ ] 

"nnoremap <^[[A> :m +1<CR>
"vnoremap <^[[A> <Esc>:m +1<CR>

"nnoremap <^[[B> :m +1<CR>
"vnoremap <^[[B> <Esc>:m +1<CR>

noremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

function Check()
    let l:line=getline('.')
    let l:curs=winsaveview()
    if l:line=~?'\s*-\s*\[\s*\].*'
        s/\[\s*\]/[\~]/
    elseif l:line=~?'\s*-\s*\[\~\].*'
        s/\[\~\]/[x]/
    elseif l:line=~?'\s*-\s*\[x\].*'
        s/\[x\]/[ ]/
    endif
    call winrestview(l:curs)
endfunction

autocmd FileType markdown nnoremap <silent> - :call Check()<CR>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
