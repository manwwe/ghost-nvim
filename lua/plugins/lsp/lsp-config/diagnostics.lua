-- Diagnostic configuration for LSP
-- Handles filtering and UI configuration

local constants = require("plugins.lsp.lsp-config.constants")

local M = {}

-- Configure diagnostic UI
function M.setup_ui()
  vim.diagnostic.config({
    virtual_text = {
      prefix = function(diagnostic)
        return constants.diagnostic_icons[diagnostic.severity] or ""
      end,
      spacing = 4,
      source = "if_many",
      format = function(diagnostic)
        return string.format([[[%s] %s]], diagnostic.code, diagnostic.message or "")
      end,
    },
    signs = false,
    underline = { severity = { min = vim.diagnostic.severity.WARN } },
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
      format = function(diagnostic)
        return string.format("%s", diagnostic.message or "unknown")
      end,
      header = { " Diagnostics:", "DiagnosticHeader" },
    },
  })
end

-- Setup all diagnostic configuration
function M.setup()
  M.setup_ui()
end

return M
