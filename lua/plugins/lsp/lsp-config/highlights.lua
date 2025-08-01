-- LSP highlighting configuration
-- Sets up diagnostic colors and underline styles

local constants = require("plugins.lsp.lsp-config.constants")

local M = {}

-- Set diagnostic highlight colors
function M.setup_colors()
  for group, color in pairs(constants.diagnostic_colors) do
    vim.api.nvim_set_hl(0, group, { fg = color })
  end
end

-- Set diagnostic underline styles
function M.setup_underlines()
  for group, attrs in pairs(constants.diagnostic_underline) do
    vim.api.nvim_set_hl(0, group, attrs)
  end
end

-- Setup all highlighting
function M.setup()
  M.setup_colors()
  M.setup_underlines()
end

return M