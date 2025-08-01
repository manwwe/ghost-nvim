-- LSP keymaps and on_attach configuration
-- Centralizes all LSP-related key bindings

local M = {}

-- Configure LSP keymaps and options on attach
function M.on_attach(client, bufnr)
  -- Special case for sqls server
  if client.name == "sqls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  local map = vim.keymap.set
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP navigation and actions
  map("n", "gd", vim.lsp.buf.definition, bufopts)     -- Go to definition
  map("n", "gr", vim.lsp.buf.references, bufopts)     -- Find references
  map("n", "K", vim.lsp.buf.hover, bufopts)           -- Show hover information
  map("n", "<leader>rn", vim.lsp.buf.rename, bufopts) -- Rename symbol
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- Code actions

  -- Attach nvim-navic if available and client supports document symbols
  if client.server_capabilities.documentSymbolProvider then
    if pcall(require, "nvim-navic") then
      require("nvim-navic").attach(client, bufnr)
    end
  end
end

return M