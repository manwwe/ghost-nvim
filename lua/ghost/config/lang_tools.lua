-- Shared language tooling configuration for LSP, Mason, formatting, and linting.

local M = {}
local prettier = { "prettier" }
local eslint = { "eslint_d" }

M.lsp_servers = {
  "clangd",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "ts_ls",
}

M.enabled_lsp_servers = vim.deepcopy(M.lsp_servers)

M.mason_tools = {
  "clang-format",
  "eslint_d",
  "prettier",
  "ruff",
  "stylua",
  "taplo",
}

M.formatters_by_ft = {
  c = { "clang_format" },
  cpp = { "clang_format" },
  javascript = prettier,
  javascriptreact = prettier,
  json = prettier,
  lua = { "stylua" },
  markdown = prettier,
  python = { "ruff_format" },
  rust = { "rustfmt" },
  toml = { "taplo" },
  typescript = prettier,
  typescriptreact = prettier,
  yaml = prettier,
}

M.linters_by_ft = {
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  javascript = eslint,
  javascriptreact = eslint,
  python = { "ruff" },
  typescript = eslint,
  typescriptreact = eslint,
}

return M
