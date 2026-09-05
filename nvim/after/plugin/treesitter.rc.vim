if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
local ts = require'nvim-treesitter'

ts.setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}

-- Parsers are installed asynchronously; no-op if already present.
ts.install {
  "tsx",
  "typescript",
  "javascript",
  "toml",
  "fish",
  "php",
  "json",
  "yaml",
  "swift",
  "html",
  "scss"
}

-- On the `main` branch, highlight/indent are no longer modules of this
-- plugin: highlighting comes from Neovim core and indent is opt-in per
-- buffer. Enable both wherever a parser is available.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('NvimTreesitterStart', { clear = true }),
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
EOF
