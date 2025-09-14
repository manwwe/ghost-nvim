-- Constants for none-ls configuration
-- Centralizes tools list and common paths

local M = {}

-- Tools to ensure installation via mason-null-ls
M.tools = {
  'stylua',
  'isort',
  'sqruff',
  'sqlfluff',
  'prettier',
  'yamllint',
  'yamlfmt',
  'shfmt',
  'shellcheck',
  'npm-groovy-lint',
  'tfsec',
  'rustfmt',
}

-- Configuration paths
M.paths = {
  sqlfluff_config = vim.fn.expand '~/.sqlfluff',
}

-- File type configurations
M.filetypes = {
  prettier = { 'json', 'markdown', 'html', 'javascript', 'typescript', 'dockerfile' },
}

return M
