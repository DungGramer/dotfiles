lua << EOF
-- `tami5/lspsaga.nvim` was abandoned; this is the maintained `nvimdev` fork,
-- where `init_lsp_saga()` was replaced by a plain `setup()` and the sign
-- glyphs moved under `diagnostic`.
local ok, saga = pcall(require, 'lspsaga')
if (not ok) then return end

saga.setup {
  ui = {
    border = 'rounded',
  },
  diagnostic = {
    signs = {
      error = ' ',
      warn  = ' ',
      hint  = ' ',
      info  = ' ',
    },
  },
}
EOF

nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga finder<CR>
nnoremap <silent> gp <Cmd>Lspsaga peek_definition<CR>
nnoremap <silent> gr <Cmd>Lspsaga rename<CR>
