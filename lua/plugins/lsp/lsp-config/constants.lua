-- Constants for LSP configuration
-- Centralizes icons, colors, and configuration values

local M = {}

-- Diagnostic severity icons
M.diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = "",
  [vim.diagnostic.severity.WARN] = "",
  [vim.diagnostic.severity.INFO] = "",
  [vim.diagnostic.severity.HINT] = "󰌵",
}

-- Diagnostic colors
M.diagnostic_colors = {
  DiagnosticError = "#F44747",
  DiagnosticWarn = "#FFCC00",
  DiagnosticInfo = "#75BEFF",
  DiagnosticHint = "#4EC9B0",
}

-- Diagnostic underline styles
M.diagnostic_underline = {
  DiagnosticUnderlineError = { undercurl = true, sp = "#F44747" },
  DiagnosticUnderlineWarn = { undercurl = true, sp = "#FFCC00" },
  DiagnosticUnderlineInfo = { undercurl = true, sp = "#75BEFF" },
  DiagnosticUnderlineHint = { undercurl = true, sp = "#4EC9B0" },
}

-- LSP servers to ensure installation
M.lsp_servers = {
  "lua_ls", -- Lua
  "pyright", -- Python
  "ruff", -- Python (Linter)
  "yamlls", -- YAML
  "helm_ls", -- Helm
  "ts_ls", -- TypeScript and Javascript
  "bashls", -- Bash
  "sqls", -- SQL
  "terraformls", -- Terraform
  "gopls", -- Go
  "rust_analyzer", -- Rust
}

-- Pyright diagnostic messages to filter
M.pyright_filters = {
  "is not accessed",
  "could not be resolved",
  "Expression value is unused",
}

return M
