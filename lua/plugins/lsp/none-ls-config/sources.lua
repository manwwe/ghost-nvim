-- Sources configuration for none-ls
-- Organizes formatters and diagnostics separately

local configs = require 'plugins.lsp.none-ls-config.configs'

local M = {}

-- Setup and return all sources for none-ls
function M.get_sources()
  local null_ls = require 'null-ls'
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  return {
    -- Formatters
    formatting.stylua,
    formatting.isort,
    formatting.sqruff.with(configs.sqlfluff_config),
    formatting.prettier.with(configs.prettier_config),
    formatting.shfmt,
    formatting.yamlfmt,
    formatting.npm_groovy_lint,
    formatting.gofumpt, -- Added formatter for Go
    formatting.rustfmt,

    -- Diagnostics
    diagnostics.sqruff.with(configs.sqlfluff_config),
    diagnostics.yamllint.with(configs.yamllint_config),
    diagnostics.npm_groovy_lint,
    diagnostics.tfsec,

    -- Shellcheck with custom condition
    require('none-ls-shellcheck.diagnostics').with {
      condition = configs.shellcheck_condition,
    },
  }
end

return M
