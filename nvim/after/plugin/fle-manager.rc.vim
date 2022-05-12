" Plug 'gelguy/wilder.nvim' {{{
call wilder#setup({'modes': [':', '/', '?']})
" }}}


" Plug 'GustavoKatel/sidebar.nvim' {{{
lua << EOF
require("sidebar-nvim").setup({})
-- require("sidebar-nvim").setup({
--     disable_default_keybindings = 0,
--     bindings = nil,
--     open = false,
--     side = "left",
--     initial_width = 35,
--     update_interval = 1000,
--     sections = { "datetime", "git-status", "lsp-diagnostics" },
--     section_separator = "-----",
--     docker = {
--         attach_shell = "/bin/sh", show_all = true, interval = 5000,
--     },
--     datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
--     todos = { ignored_paths = { "~" } }
-- })
EOF
nnoremap <leader>sb <cmd>SidebarNvimToggl<cr>
" }}}


" export-to-vscode {{{
nnoremap <silent> <leader>code <cmd>lua require('export-to-vscode').launch()<cr>
lua << EOF
--vim.api.nvim_set_keymap(
--  'n',
--  '<leader>code',
--  '<cmd>lua require("export-to-vscode").launch()<cr>',
--  { noremap = true, silent = true }
--)
EOF
" }}}


" norcalli/nvim-colorizer.lua {{{
lua require'colorizer'.setup()
" }}}

" nvim-tree {{{
lua << EOF
require'nvim-tree'.setup {
  ignore_ft_on_setup  = { 'startify', 'dashboard' },
}
EOF
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" }}}


" tpope/vim-commentary {{{
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>
"}}}

" NERDTree {{{
  let NERDTreeShowHidden=1
"}}}

" 'glephir/dashboard-nvim' {{{
let g:dashboard_default_executive ='telescope'
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
" nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>ct :DashboardChangeColorscheme<CR>
" nnoremap <silent> <Leader>fg :DashboardFindWord<CR>
nnoremap <silent> <Leader>fm :DashboardJumpMark<CR>
nnoremap <silent> <Leader>nf :DashboardNewFile<CR>
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC n f',
\ 'change_colorscheme' : 'SPC c t',
\ 'find_word'          : 'SPC f g',
\ 'book_marks'         : 'SPC f m',
\ }
let s:header = [
    \ '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    \ '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
    \ '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
    \ '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
    \ '',
    \ '                 [ @dunggramer ]                 ',
    \ ]
let s:footer = []
let g:dashboard_custom_header = s:header
let g:dashboard_custom_footer = s:footer
" }}}