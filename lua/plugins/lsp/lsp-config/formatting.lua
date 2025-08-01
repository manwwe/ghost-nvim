-- LSP formatting configuration
-- Centralizes auto-format on save functionality

local M = {}

-- Auto-format on save using LSP
function M.setup_lsp_formatting()
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

-- Setup formatting (currently only LSP, none-ls handles its own)
function M.setup()
  M.setup_lsp_formatting()
end

return M