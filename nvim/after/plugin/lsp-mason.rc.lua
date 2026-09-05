-- Replaces `williamboman/nvim-lsp-installer`, which was archived in 2022.
-- mason.nvim installs the language servers; mason-lspconfig bridges their
-- names to nvim-lspconfig and enables each installed server automatically,
-- so the old `on_server_ready` callback is no longer needed.
local ok_mason, mason = pcall(require, "mason")
if (not ok_mason) then return end

mason.setup({
  ui = {
    border = "rounded",
  },
})

local ok_bridge, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not ok_bridge) then return end

mason_lspconfig.setup({
  ensure_installed = { "ts_ls", "diagnosticls" },
  automatic_enable = true,
})
