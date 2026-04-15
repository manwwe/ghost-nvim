-- Shared UI constants used across plugin configuration.

local M = {
  border = {
    default = "rounded",
    terminal = "single",
  },
  diagnostic_signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "󰌵",
  },
}

return M
