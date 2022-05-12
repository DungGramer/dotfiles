" Description: Keymaps

nnoremap <S-C-p> "1p
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Delete a word backwards
nnoremap dw vb"_d

" Select all
nmap <C-a> gg<S-v>G

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"-----------------------------
" Tabs

" Open current directory
nmap te :tabedit 
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

"------------------------------
" Windows

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

" NERDTree
map <silent> <F5> :NERDTreeToggle<CR>


inoremap jj <ESC> " jj to Escape

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Escape terminal mode
tnoremap <Esc> <C-\><C-n>

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
vnoremap <leader>y "+y
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" resize current buffer by +/- 5 
nnoremap <M-Right> :vertical resize -5<cr>
nnoremap <M-Up> :resize +5<cr>
nnoremap <M-Down> :resize -5<cr>
nnoremap <M-Left> :vertical resize +5<cr>

" toggle relativenumber
nnoremap <leader>tn :set invrelativenumber<cr>

" toggle word wrap
nnoremap <leader>tw :set wrap!<cr>

" clear and redraw screen, de-highlight, fix syntax highlighting
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" nnoremap gp `[v`] " reselect pasted text

nnoremap <leader>id :r!date -u +"\%Y-\%m-\%dT\%H:\%M:\%SZ"<CR>
" nnoremap id "=strftime("%FT%T%z")<CR>P

nnoremap <leader>x :!chmod +x %<cr>
" }}}

" Autocmd {{{
set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣
autocmd InsertEnter * set list
autocmd VimEnter,BufEnter,InsertLeave * set nolist
autocmd BufNewFile,BufRead *.md,*.mdx,*.markdown :set filetype=markdown
" }}}

" Abbreviations {{{
" iabbrev @@ emanor@planview.com
" }}}

" Snippets {{{
nnoremap ,desc :-1read $HOME/.config/snippets/describe.snip<CR>V2j=f"a
nnoremap ,it   :-1read $HOME/.config/snippets/it.snip<CR>V2j=f";i
nnoremap ,test :-1read $HOME/.config/snippets/test.snip<CR>V2j=f";i
" }}}
