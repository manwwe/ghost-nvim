-- Specific configurations for none-ls tools
-- Contains custom configurations and conditions

local constants = require("plugins.lsp.none-ls-config.constants")

local M = {}

-- Yamllint configuration with custom rules
M.yamllint_config = {
  extra_args = {
    '-d',
    '{extends: default, rules: {line-length: {max: 150}, document-start: disable,document-end: disable, braces: disable}}',
  },
}

-- Sqlfluff configuration with custom config path
M.sqlfluff_config = {
  extra_args = { '--config', constants.paths.sqlfluff_config },
}

-- Prettier configuration with specific filetypes
M.prettier_config = {
  filetypes = constants.filetypes.prettier,
}

-- Shellcheck condition to exclude .env files
M.shellcheck_condition = function(utils)
  local filename = utils.bufname
  if not filename then
    return false
  end
  return not filename:match('%.env$') and not filename:match('%.env%.[^/]+$')
end

return M