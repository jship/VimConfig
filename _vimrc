" +--------------------------------------------------------------------------+
" | FUNCTIONS                                                                |
" +--------------------------------------------------------------------------+

" Mark the window and buffer to prep it for a swap with another buffer.
" (See http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim)
function! MarkSwapAway()
    " marked window number
    let g:markedOldWinNum = winnr()
    let g:markedOldBufNum = bufnr("%")
endfunction

" Swap buffer locations based on marks from MarkSwapAway.
" (See http://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim)
function! DoWindowToss()
    let newWinNum = winnr()
    let newBufNum = bufnr("%")
    " Switch focus to marked window
    exe g:markedOldWinNum . "wincmd w"
    " Load current buffer on marked window
    exe 'hide buf' newBufNum
    " Switch focus to current window
    exe newWinNum . "wincmd w"
    " Load marked buffer on current window
    exe 'hide buf' g:markedOldBufNum
    " …and come back to the new one
    exe g:markedOldWinNum . "wincmd w"
endfunction


" Turn 80-character color column on or off.
" (Found online somewhere, but it's easy to follow)
function! ToggleColorColumn()
    if exists("b:colorcolumnon") && b:colorcolumnon
        let b:colorcolumnon = 0
        exec ':set colorcolumn=0'
        echo '80 column marker off'
    else
        let b:colorcolumnon = 1
        exec ':set colorcolumn=80'
        echo '80 column marker on'
    endif    
endfunction

" +--------------------------------------------------------------------------+
" | SETTINGS                                                                 |
" +--------------------------------------------------------------------------+

" Disable backup/swap.
set nobackup
set nowritebackup
set noswapfile

" smartindent (works with autoindent) with spaces instead of TAB characters.
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Highlight all matching patterns.
set hlsearch

" Case insensitive searching.
set ic

" +--------------------------------------------------------------------------+
" | AUTOMATIC COMMANDS                                                       |
" +--------------------------------------------------------------------------+

" For C++, use TDM-GCC's (MinGW's) make with vim-dispatch.
autocmd FileType cpp let b:dispatch = 'mingw32-make'

" After all start-up loading (including this file), turn on MiniBufExpl.
autocmd VimEnter * MBEOpen

" +--------------------------------------------------------------------------+
" | KEY MAPPINGS                                                             |
" +--------------------------------------------------------------------------+

" Swap buffer locations using the swap functions above.
nnoremap <C-w><C-h> :call MarkSwapAway()<CR> <C-w>h :call DoWindowToss()<CR>
nnoremap <C-w><C-j> :call MarkSwapAway()<CR> <C-w>j :call DoWindowToss()<CR>
nnoremap <C-w><C-k> :call MarkSwapAway()<CR> <C-w>k :call DoWindowToss()<CR>
nnoremap <C-w><C-l> :call MarkSwapAway()<CR> <C-w>l :call DoWindowToss()<CR>

" Toggle NERDTree.
nnoremap <F2> :NERDTreeToggle<CR><CR>

" Toggle TagBar.
nnoremap <F3> :TagbarToggle<CR>

" Toggle MiniBufExplorer
nnoremap <F4> :MBEToggle<CR>

" Switch buffers in MiniBufExpl.
noremap <C-TAB> :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

" Toggle 80 column marker.
nnoremap <F5> :call ToggleColorColumn()<CR>

" +--------------------------------------------------------------------------+
" | START-UP COMMANDS                                                        |
" +--------------------------------------------------------------------------+

" Start out in the home directory.
cd $HOME

" Have pathogen load all plugins.
execute pathogen#infect()
